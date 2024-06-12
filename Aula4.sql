CREATE SCHEMA IF NOT EXISTS pedido_cliente;

SET search_path TO pedido_cliente;

-- Criação da tabela Cliente
CREATE TABLE Cliente (
    Cod_Cliente INTEGER PRIMARY KEY,
    Nome_Cliente VARCHAR(50),
    Endereco_Cliente VARCHAR(60)
);

-- Criação da tabela Vendedor
CREATE TABLE Vendedor (
    Cod_Vendedor INTEGER PRIMARY KEY,
    Nome_Vendedor VARCHAR(50),
    Endereco_Vendedor VARCHAR(60)
);

-- Criação da tabela Pedido
CREATE TABLE Pedido (
    Cod_Pedido INTEGER PRIMARY KEY,
    Cod_Vendedor INTEGER,
    Cod_Cliente INTEGER,
    Data_Pedido DATE,
    QTDE_Pedido FLOAT,
    Valor_Pedido FLOAT
);

-- Criação da tabela Item
CREATE TABLE Item (
    Cod_Pedido INTEGER,
    Cod_Produto INTEGER,
    QTDE_Item FLOAT,
    Valor_Unit FLOAT,
    Valor_Parcial FLOAT,
    PRIMARY KEY (Cod_Pedido, Cod_Produto)
);

-- Criação da tabela Linha_Produto
CREATE TABLE Linha_Produto (
    Cod_Linha INTEGER PRIMARY KEY,
    Descricao_Linha VARCHAR(50)
);

-- Criação da tabela Produto
CREATE TABLE Produto (
    Cod_Produto INTEGER PRIMARY KEY,
    Cod_Linha INTEGER,
    Nome_Produto VARCHAR(50),
    QTDE_Produto FLOAT
);

-- Adição das chaves estrangeiras
ALTER TABLE Pedido
ADD CONSTRAINT fk_Pedido_Vendedor
FOREIGN KEY (Cod_Vendedor) REFERENCES Vendedor(Cod_Vendedor);

ALTER TABLE Pedido
ADD CONSTRAINT fk_Pedido_Cliente
FOREIGN KEY (Cod_Cliente) REFERENCES Cliente(Cod_Cliente);

ALTER TABLE Item
ADD CONSTRAINT fk_Item_Pedido
FOREIGN KEY (Cod_Pedido) REFERENCES Pedido(Cod_Pedido);

ALTER TABLE Item
ADD CONSTRAINT fk_Item_Produto
FOREIGN KEY (Cod_Produto) REFERENCES Produto(Cod_Produto);

ALTER TABLE Produto
ADD CONSTRAINT fk_Produto_Linha
FOREIGN KEY (Cod_Linha) REFERENCES Linha_Produto(Cod_Linha);

-- Inserir dados na tabela Cliente
INSERT INTO Cliente (Cod_Cliente, Nome_Cliente, Endereco_Cliente)
VALUES 
(1, 'JOSÉ DA SILVA', 'RUA A, 100 – CENTRO'),
(2, 'ANTONIO CABRAL', 'AV. SÃO JOSE, 73 – CANDEIAS');

-- Inserir dados na tabela Vendedor
INSERT INTO Vendedor (Cod_Vendedor, Nome_Vendedor, Endereco_Vendedor)
VALUES 
(1, 'MANOEL CAXIAS', 'RUA TRINDADE, 347 – BRASIL');

-- Inserir dados na tabela Linha_Produto
INSERT INTO Linha_Produto (Cod_Linha, Descricao_Linha)
VALUES 
(1, 'CALÇADOS'),
(2, 'CONFECÇÕES');

-- Inserir dados na tabela Produto
INSERT INTO Produto (Cod_Produto, Cod_Linha, Nome_Produto, QTDE_Produto)
VALUES 
(1, 2, 'CALÇA JEANS', 109),
(2, 1, 'SAPATO MASCULINO', 500);

-- Inserir dados na tabela Pedido
INSERT INTO Pedido (Cod_Pedido, Cod_Vendedor, Cod_Cliente, Data_Pedido, QTDE_Pedido, Valor_Pedido)
VALUES 
(1, 1, 2, '2019-05-18', 3, 170);

-- Inserir dados na tabela Item
INSERT INTO Item (Cod_Pedido, Cod_Produto, QTDE_Item, Valor_Unit, Valor_Parcial)
VALUES 
(1, 1, 2, 50, 100),
(1, 2, 1, 70, 70);

-- A operação falhará devido à violação da restrição de chave estrangeira (fk_Produto_Linha).
DELETE FROM Linha_Produto WHERE Cod_Linha=1; 

-- A atualização será bem-sucedida sem violar nenhuma restrição de integridade referencial.
UPDATE Pedido SET Cod_Cliente =1 WHERE Cod_Pedido=1;

-- Essa operação falhará devido à violação da restrição de chave estrangeira (fk_Item_Produto).
UPDATE Item SET Cod_Produto =3 WHERE Cod_Pedido=1;

-- A exclusão será bem-sucedida
DELETE FROM Item WHERE Cod_Produto=1;

-- Selecionar o nome e endereço de todos os clientes
SELECT Nome_Cliente, Endereco_Cliente
FROM Cliente;

-- Selecionar o código e nome dos produtos da linha 2
SELECT Cod_Produto, Nome_Produto
FROM Produto
WHERE Cod_Linha = 2;

-- Selecionar o código, nome e quantidade dos produtos da linha 'Confecções'
SELECT P.Cod_Produto, P.Nome_Produto, P.QTDE_Produto
FROM Produto P
JOIN Linha_Produto LP ON P.Cod_Linha = LP.Cod_Linha
WHERE LP.Descricao_Linha = 'CONFECÇÕES';

-- Selecionar o nome e endereço dos clientes que compraram no mês de maio/2019
SELECT DISTINCT C.Nome_Cliente, C.Endereco_Cliente
FROM Cliente C
JOIN Pedido P ON C.Cod_Cliente = P.Cod_Cliente
WHERE P.Data_Pedido BETWEEN '2019-05-01' AND '2019-05-31';

-- Para cada vendedor, selecionar o nome, a quantidade de pedidos e o valor total vendido
SELECT V.Nome_Vendedor, COUNT(P.Cod_Pedido) AS Quantidade_Pedidos, SUM(P.Valor_Pedido) AS Valor_Total_Vendido
FROM Vendedor V
JOIN Pedido P ON V.Cod_Vendedor = P.Cod_Vendedor
GROUP BY V.Nome_Vendedor;

-- Selecionar o nome do vendedor que mais realizou pedidos
SELECT V.Nome_Vendedor
FROM Vendedor V
JOIN Pedido P ON V.Cod_Vendedor = P.Cod_Vendedor
GROUP BY V.Nome_Vendedor
ORDER BY COUNT(P.Cod_Pedido) DESC
LIMIT 1;

-- Criar uma visão que mostre o nome do produto e o valor total que vendeu de cada produto
CREATE VIEW Produto_Vendas_Totais AS
SELECT P.Nome_Produto, SUM(I.QTDE_Item * I.Valor_Unit) AS Valor_Total_Vendido
FROM Produto P
JOIN Item I ON P.Cod_Produto = I.Cod_Produto
GROUP BY P.Nome_Produto;

-- Criar uma visão que mostre o código do pedido, o nome do cliente, o nome do vendedor e o valor total do pedido
CREATE VIEW Pedidos_Detalhados AS
SELECT P.Cod_Pedido, C.Nome_Cliente, V.Nome_Vendedor, P.Valor_Pedido
FROM Pedido P
JOIN Cliente C ON P.Cod_Cliente = C.Cod_Cliente
JOIN Vendedor V ON P.Cod_Vendedor = V.Cod_Vendedor;
