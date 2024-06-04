-- Cria o esquema "Empresa"
CREATE SCHEMA IF NOT EXISTS empresa;

-- Define o uso do esquema "Empresa"
SET search_path TO empresa;

-- Cria a tabela "Empregado"
CREATE TABLE Empregado (
    cpf NUMERIC(11) PRIMARY KEY,
    nome VARCHAR(50),
    iniciais_meio VARCHAR(3),
    sobrenome VARCHAR(50),
    dt_nascimento DATE,
    sexo CHARACTER(1),
    salario FLOAT,
    cpf_super NUMERIC(11),
    d_num INT
);

-- Cria a tabela "Dependente"
CREATE TABLE Dependente (
    e_cpf NUMERIC(11),
    dep_nome VARCHAR(50),
    parentesco VARCHAR(20),
    PRIMARY KEY (e_cpf, dep_nome)
);

-- Cria a tabela "Departamento"
CREATE TABLE Departamento (
    d_numero SERIAL PRIMARY KEY,
    d_nome VARCHAR(20),
    cpf_ger NUMERIC(11),
    dt_inicio_ger DATE
);

-- Cria a tabela "Localizacao_dep"
CREATE TABLE Localizacao_dep (
    d_num INT,
    localizacao VARCHAR(20),
    PRIMARY KEY (d_num, localizacao)
);

-- Cria a tabela "Projeto"
CREATE TABLE Projeto (
    p_numero SERIAL PRIMARY KEY,
    p_nome VARCHAR(20),
    p_num INT,
    p_d_num INT,
    p_localizacao VARCHAR(50)
);

-- Cria a tabela "Trabalha_em"
CREATE TABLE Trabalha_em (
    p_num INT,
    e_cpf NUMERIC(11),
    horas TIME,
    PRIMARY KEY (p_num, e_cpf)
);

-- Adiciona as chaves estrangeiras
ALTER TABLE Empregado
    ADD CONSTRAINT fk_empregado_supervisor FOREIGN KEY (cpf_super) REFERENCES Empregado(cpf),
    ADD CONSTRAINT fk_empregado_departamento FOREIGN KEY (d_num) REFERENCES Departamento(d_numero);

ALTER TABLE Dependente
    ADD CONSTRAINT fk_dependente_empregado FOREIGN KEY (e_cpf) REFERENCES Empregado(cpf);

ALTER TABLE Departamento
    ADD CONSTRAINT fk_departamento_gerente FOREIGN KEY (cpf_ger) REFERENCES Empregado(cpf);

ALTER TABLE Localizacao_dep
    ADD CONSTRAINT fk_localizacao_departamento FOREIGN KEY (d_num) REFERENCES Departamento(d_numero);

ALTER TABLE Projeto
    ADD CONSTRAINT fk_projeto_localizacao FOREIGN KEY (p_d_num, p_localizacao) REFERENCES Localizacao_dep(d_num, localizacao);

ALTER TABLE Trabalha_em
    ADD CONSTRAINT fk_trabalha_em_projeto FOREIGN KEY (p_num) REFERENCES Projeto(p_numero),
    ADD CONSTRAINT fk_trabalha_em_empregado FOREIGN KEY (e_cpf) REFERENCES Empregado(cpf);

-- Novo atributo "endereco"
ALTER TABLE Empregado ADD endereco VARCHAR(100);

-- Adiciona o atributo "sexo" à tabela "Dependente" e define a restrição de valores permitidos
ALTER TABLE Dependente ADD sexo CHAR(1);

-- Adiciona a constraint para limitar os valores de "sexo"
ALTER TABLE Dependente ADD CONSTRAINT chk_sexo CHECK (sexo IN ('F', 'f', 'M', 'm'));

-- Adiciona o atributo "dt_nascimento" à tabela "Dependente"
ALTER TABLE Dependente ADD dt_nascimento DATE;

-- Remove o atributo "sexo" da tabela "Dependente"
ALTER TABLE Dependente DROP COLUMN sexo;
