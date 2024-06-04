-- Cria o esquema "aula2"
CREATE SCHEMA IF NOT EXISTS empresa;

SET search_path TO empresa;

CREATE TABLE if not exists departamento
(
    d_numero serial NOT NULL,
    d_nome varchar(20) NOT NULL,
    cpf_ger numeric(11,0),
    dt_inicio_ger date,
    PRIMARY KEY (d_numero)
);

CREATE TABLE if not exists empregado
(
    cpf numeric(11,0) NOT NULL,
    nome varchar (50) NOT NULL,
    iniciais_meio varchar (3),
    sobrenome varchar (50),
    dt_nascimento date,
    sexo character(1) ,
    salario float, 
    cpf_super numeric(11,0),
    d_num integer,
    PRIMARY KEY (cpf),
    FOREIGN KEY (cpf_super) REFERENCES empregado (cpf),
    FOREIGN KEY (d_num) REFERENCES departamento (d_numero) 
);

CREATE TABLE if not exists projeto
(
    p_numero serial NOT NULL,
    p_nome varchar(20),
    d_num integer,
    p_localizacao varchar(50) COLLATE pg_catalog."default",
    PRIMARY KEY (p_numero),
    FOREIGN KEY (d_num) REFERENCES departamento (d_numero)
);

CREATE TABLE if not exists dependente
(
    e_cpf numeric(11,0) NOT NULL,
    dep_nome varchar(50) NOT NULL,
    sexo character(1),
    dt_nascimento date,
    parentesco varchar(20),
    PRIMARY KEY (e_cpf, dep_nome),
    FOREIGN KEY (e_cpf) REFERENCES empregado (cpf),
    CHECK (sexo in ('M', 'F', 'm', 'f'))
);

CREATE TABLE if not exists trabalha_em
(
    p_num integer NOT NULL,
    e_cpf numeric(11,0) NOT NULL,
    hora float,
    PRIMARY KEY (p_num, e_cpf),
    FOREIGN KEY (e_cpf) REFERENCES empregado (cpf),
    FOREIGN KEY (p_num) REFERENCES projeto (p_numero)
);

CREATE TABLE if not exists localizacao_dep
(
    d_num integer NOT NULL,
    localizacao varchar (20) NOT NULL,
    PRIMARY KEY (d_num, localizacao),
    FOREIGN KEY (d_num) REFERENCES departamento (d_numero)
);


alter table departamento add FOREIGN KEY (cpf_ger) REFERENCES empregado (cpf);

-- Adiciona o atributo endereço do tipo varchar (100) à tabela empregado
ALTER TABLE empregado ADD COLUMN endereco VARCHAR(100);

-- Adiciona o atributo dt_nascimento do tipo date à tabela dependente
--ALTER TABLE dependente ADD COLUMN dt_nascimento DATE;

-- script para inserir dados na tabela empregado
INSERT INTO empregado(cpf, nome, iniciais_meio, sobrenome, dt_nascimento, sexo, cpf_super, 
            salario)
    VALUES (123456789,'JOHN', 'B', 'SMITH', '09-01-1965', 'M', NULL, 
            30000);
 
INSERT INTO empregado(
            cpf, nome, iniciais_meio, sobrenome, dt_nascimento, sexo, cpf_super, 
            salario)
    VALUES (333445555,'FRANKLIN', 'T', 'WOND', '08-12-1955', 'M', NULL, 
            40000);

 INSERT INTO empregado(
            cpf, nome, iniciais_meio, sobrenome, dt_nascimento, sexo, cpf_super, 
            salario)
    VALUES (999887777,'ALICIA', 'J', 'ZELAYA', '19-07-1968', 'F', NULL, 
            25000);

 INSERT INTO empregado(
           cpf, nome, iniciais_meio, sobrenome, dt_nascimento, sexo, cpf_super, 
            salario)
    VALUES (987654321,'JENNFFER', 'S', 'WALLACE', '20-06-1941', 'F', NULL, 
            43000);

INSERT INTO empregado(
            cpf, nome, iniciais_meio, sobrenome, dt_nascimento, sexo, cpf_super, 
            salario)
    VALUES (666894444,'RAMESH', 'K', 'NARAYAN', '15-09-1962', 'M', NULL, 
            38000);

INSERT INTO empregado(
           cpf, nome, iniciais_meio, sobrenome, dt_nascimento, sexo, cpf_super, 
            salario)
    VALUES (453453453,'JOYCE', 'A', 'ENGLISH', '31-07-1972', 'F', NULL, 
            25000);

 INSERT INTO empregado(
            cpf, nome, iniciais_meio, sobrenome, dt_nascimento, sexo, cpf_super, 
            salario)
    VALUES (987987987,'AHMAD', 'V', 'JABBAR', '29-03-1969', 'M', NULL, 
            25000);

INSERT INTO empregado(
            cpf, nome, iniciais_meio, sobrenome, dt_nascimento, sexo, cpf_super, 
            salario)
    VALUES (888665555,'JAMES', 'E', 'BORG', '10-11-1937', 'M', NULL, 
            55000);
			
-- Povoar a tabela departamento com os dados
INSERT INTO departamento (d_nome, cpf_ger, dt_inicio_ger) VALUES
('COMPUTAÇÃO', 333445555, '1998-05-22'),
('ADMINISTRAÇÃO', 987654321, '1995-01-01'),
('COORDENAÇÃO', 888665555, '1981-06-19');

-- Atualizar dados na tabela empregado
UPDATE empregado
SET nome = 'John', iniciais_meio = 'B', sobrenome = 'Smith', cpf = 123456789, 
    dt_nascimento = '1965-01-09', endereco = '731 Fondren, Houston, TX', sexo = 'M', 
    salario = 30000, cpf_super = 333445555, d_num = 1
WHERE cpf = 123456789;

UPDATE empregado
SET nome = 'Franklin', iniciais_meio = 'T', sobrenome = 'Wong', cpf = 333445555, 
    dt_nascimento = '1955-12-08', endereco = '638 Voss, Houston, TX', sexo = 'M', 
    salario = 40000, cpf_super = 888665555, d_num = 2
WHERE cpf = 333445555;

UPDATE empregado
SET nome = 'Alicia', iniciais_meio = 'J', sobrenome = 'Zelaya', cpf = 999887777, 
    dt_nascimento = '1968-07-19', endereco = '3321 Castle, Spring, TX', sexo = 'F', 
    salario = 25000, cpf_super = 987654321, d_num = 2
WHERE cpf = 999887777;

UPDATE empregado
SET nome = 'Jennffer', iniciais_meio = 'S', sobrenome = 'Wallace', cpf = 987654321, 
    dt_nascimento = '1941-06-20', endereco = '291 Berry, Bellaire, TX', sexo = 'F', 
    salario = 43000, cpf_super = 888665555, d_num = 2
WHERE cpf = 987654321;

UPDATE empregado
SET nome = 'Ramesh', iniciais_meio = 'K', sobrenome = 'Narayan', cpf = 666894444, 
    dt_nascimento = '1962-09-15', endereco = '975 Flre Oak, Humble, TX', sexo = 'M', 
    salario = 38000, cpf_super = 333445555, d_num = 1
WHERE cpf = 666894444;

UPDATE empregado
SET nome = 'Joyce', iniciais_meio = 'A', sobrenome = 'English', cpf = 453453453, 
    dt_nascimento = '1972-07-31', endereco = '5631 Rice, Houston, TX', sexo = 'F', 
    salario = 25000, cpf_super = 333445555, d_num = 1
WHERE cpf = 453453453;

UPDATE empregado
SET nome = 'Ahmad', iniciais_meio = 'V', sobrenome = 'Jabbar', cpf = 987987987, 
    dt_nascimento = '1969-03-29', endereco = '980 Dallas, Houston, TX', sexo = 'M', 
    salario = 25000, cpf_super = 987654321, d_num = 2
WHERE cpf = 987987987;

UPDATE empregado
SET nome = 'James', iniciais_meio = 'E', sobrenome = 'Borg', cpf = 888665555, 
    dt_nascimento = '1937-11-10', endereco = '450 Stone, Houston, TX', sexo = 'M', 
    salario = 55000, cpf_super = null, d_num = 3
WHERE cpf = 888665555;

-- Inserir dados na tabela projeto
INSERT INTO projeto (p_numero, p_nome, d_num, p_localizacao)
VALUES
(1, 'ProdutoX', 1, 'Bellaire'),
(2, 'ProdutoY', 1, 'Sugarland'),
(3, 'ProdutoZ', 1, 'Houston'),
(4, 'Informatização', 2, 'Stafford'),
(5, 'Reorganização', 3, 'Houston'),
(6, 'Novos Benefícios', 2, 'Stafford');

-- Inserir dados na tabela trabalha_em
INSERT INTO trabalha_em (e_cpf, p_num, hora)
VALUES
(123456789, 1, 32.5),
(123456789, 2, 7.5),
(666894444, 3, 40.0),
(453453453, 1, 20.0),
(453453453, 2, 20.0),
(333445555, 2, 10.0),
(333445555, 3, 10.0),
(333445555, 4, 10.0),
(333445555, 5, 10.0),
(999887777, 6, 30.0),
(999887777, 4, 10.0),
(987987987, 4, 35.0),
(987987987, 6, 5.0),
(987654321, 6, 20.0),
(987654321, 5, 15.0),
(888665555, 5, null);

-- Inserir dados na tabela localizacao_dep
INSERT INTO localizacao_dep (d_num, localizacao)
VALUES
(3, 'Houston'),
(2, 'Stafbrd'),
(1, 'Beliaire'),
(1, 'Sugartard'),
(1, 'Houston');

-- Inserir dados na tabela dependente
INSERT INTO dependente (e_cpf, dep_nome, sexo, dt_nascimento, parentesco)
VALUES
(333445555, 'Alice', 'F', '1986-04-05', 'Filha'),
(333445555, 'Theodore', 'M', '1983-10-25', 'Filho'),
(333445555, 'Joy', 'F', '1958-05-03', 'Esposa'),
(987654321, 'Abner', 'M', '1942-02-28', 'Esposa'),
(123456789, 'Michael', 'M', '1986-01-04', 'Filho'),
(123456789, 'Alice', 'F', '1988-12-30', 'Filha'),
(123456789, 'Elizabeth', 'F', '1967-05-05', 'Esposa');

--Questao 4
-- a. Inserir 'Robert' em EMPREGADO : Violação de chave primária única
INSERT INTO EMPREGADO (cpf, nome, iniciais_meio, sobrenome, dt_nascimento, endereco, sexo, salario, cpf_super, d_num)
VALUES ('943775543', 'Robert', 'F', 'Scou', '1952-06-21', '2365 Newcastle Rd, Bellaire, TX', 'M', 58000, '888665555', 5);

-- b. Inserir 'ProdutoA' em PROJETO : Violação de chave estrangeira
INSERT INTO PROJETO (p_nome, d_num, p_localizacao)
VALUES ('ProdutoA', 4, 'Bellaire');

-- c. Inserir 'Produção' em DEPARTAMENTO : Violação de chave primária única
INSERT INTO DEPARTAMENTO (d_nome, d_numero, cpf_ger, dt_inicio_ger)
VALUES ('Produção', 4, '943775543', '1988-10-01');

-- d. Inserir '677678989' em TRABALHA_EM : Violação de chave estrangeira
INSERT INTO TRABALHA_EM (e_cpf, p_num, hora)
VALUES ('677678989', NULL, '40,0');

-- e. Inserir '453453453' em DEPENDENTE : Violação de restrição de enumeração
INSERT INTO DEPENDENTE (e_cpf, dep_nome, sexo, dt_nascimento, parentesco)
VALUES ('453453453', 'John', 'M', '1970-12-12', 'ESPOSA');

-- f, g, h, i, j, e k não causariam violações de integridade:

-- f. Excluir as tuplas TRABALHA_EM com e_cpf = '333445555'
DELETE FROM TRABALHA_EM WHERE e_cpf = '333445555';

-- g. Excluir a tupla EMPREGADO com cpf = '987654321'
DELETE FROM EMPREGADO WHERE cpf = '987654321';

-- h. Excluir a tupla PROJETO com P_NOME = 'ProdutoX'
DELETE FROM PROJETO WHERE p_nome = 'ProdutoX';

-- i. Modificar CPF_GER e DT_INICIO_GER da tupla DEPARTAMENTO com D_NUMERO = 1
UPDATE DEPARTAMENTO SET cpf_ger = '123456789', dt_inicio_ger = '1999-10-01' WHERE d_numero = 1;

-- j. Modificar o atributo CPF_SUPER da tupla EMPREGADO com CPF = '999887777'
UPDATE EMPREGADO SET cpf_super = '943775543' WHERE cpf = '999887777';

-- k. Modificar o atributo HORAS da tupla TRABALHA_EM com E_CPF = '999887777' e P_NUM = 4
UPDATE TRABALHA_EM SET hora = '5,0' WHERE e_cpf = '999887777' AND p_num = 4;
