SET search_path TO aula;

-- Recupere o nome completo dos empregados do sexo masculino.
SELECT nome || ' ' || sobrenome AS nome_completo
FROM EMPREGADO
WHERE sexo = 'M';

-- Liste o nome e o número dos projetos localizados em Stafford.
SELECT p_nome, p_numero
FROM PROJETO
WHERE p_localizacao = 'Stafford';

-- Recupere o nome e o sexo de cada dependente.
SELECT dep_nome, sexo
FROM DEPENDENTE;

-- Liste o nome do dependente e o nome do empregado do qual ele depende
SELECT d.dep_nome AS dependente, e.nome AS empregado
FROM DEPENDENTE d
INNER JOIN EMPREGADO e ON d.e_cpf = e.cpf;

-- Liste o nome de todos os dependentes de JOHN SMITH
SELECT dep_nome
FROM DEPENDENTE
WHERE e_cpf IN (SELECT cpf FROM EMPREGADO WHERE nome = 'John' AND sobrenome = 'Smith');

-- Recupere os nomes de todos os empregados no departamento 2 que trabalham mais do que 10 horas por semana no projeto 'Produto X'.
SELECT e.nome
FROM EMPREGADO e
INNER JOIN TRABALHA_EM tr ON e.cpf = tr.e_cpf
INNER JOIN PROJETO pj ON tr.p_num = pj.p_numero
WHERE tr.hora > 10 AND pj.p_nome = 'ProdutoX' AND e.d_num = 2;

-- Liste os nomes de todos os empregados que possuem um dependente cujo nome seja igual ao deles
SELECT e.nome
FROM EMPREGADO e
INNER JOIN DEPENDENTE d ON e.cpf = d.e_cpf
WHERE d.dep_nome = e.nome;

-- Encontre os nomes de todos os empregados que sejam diretamente supervisionados por 'FRANKLIN WONG'
SELECT e.nome
FROM EMPREGADO e
INNER JOIN EMPREGADO sup ON e.cpf_super = sup.cpf
WHERE sup.nome = 'Franklin' AND sup.sobrenome = 'Wong';

-- Recupere os nomes de todos os empregados e o nome dos projetos que eles trabalham.
SELECT e.nome AS empregado, p.p_nome AS projeto
FROM EMPREGADO e
INNER JOIN TRABALHA_EM t ON e.cpf = t.e_cpf
INNER JOIN PROJETO p ON t.p_num = p.p_numero;

-- Recupere os nomes de todos os empregados que não trabalham em nenhum projeto
SELECT nome
FROM EMPREGADO
WHERE cpf NOT IN (SELECT e_cpf FROM TRABALHA_EM);

-- Encontre os nomes e endereços de todos os empregados que trabalham em pelo menos um projeto	localizado em 'Houston'
SELECT e.nome, e.endereco
FROM EMPREGADO e
INNER JOIN TRABALHA_EM tr ON e.cpf = tr.e_cpf
INNER JOIN PROJETO pj ON tr.p_num = pj.p_numero
WHERE pj.p_localizacao = 'Houston';

-- Liste o nome do empregado, o nome do departamento e o nome dos projetos que trabalha
SELECT e.nome AS empregado, d.d_nome AS departamento, pj.p_nome AS projeto
FROM EMPREGADO e
INNER JOIN DEPARTAMENTO d ON e.d_num = d.d_numero
INNER JOIN TRABALHA_EM tr ON e.cpf = tr.e_cpf
INNER JOIN PROJETO pj ON tr.p_num = pj.p_numero;

-- Liste o nome dos empregados supervisionados pelo gerente do departamento COMPUTAÇÃO.
SELECT e.nome AS empregado
FROM EMPREGADO e
INNER JOIN DEPARTAMENTO d ON e.d_num = d.d_numero
INNER JOIN EMPREGADO gerente ON d.cpf_ger = gerente.cpf
WHERE d.d_nome = 'COMPUTAÇÃO';

-- Liste os sobrenomes de todos os gerentes de departamento que não possuam dependentes.
SELECT e.sobrenome
FROM EMPREGADO e
INNER JOIN DEPARTAMENTO d ON e.d_num = d.d_numero
LEFT JOIN DEPENDENTE dep ON e.cpf = dep.e_cpf
WHERE e.cpf = d.cpf_ger AND dep.e_cpf IS NULL;
