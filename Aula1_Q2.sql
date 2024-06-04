-- Cria o esquema "Vendas"
CREATE SCHEMA IF NOT EXISTS Vendas;

-- Define o uso do esquema "Vendas"
SET search_path TO Vendas;

-- Cria a tabela "Cliente"
CREATE TABLE Cliente (
    Cod_Cliente INTEGER PRIMARY KEY,
    Nome_Cliente VARCHAR(50),
    Endereco_Cliente VARCHAR(60)
);

-- Cria a tabela "Vendedor"
CREATE TABLE Vendedor (
    Cod_Vendedor INTEGER PRIMARY KEY,
    Nome_Vendedor VARCHAR(50),
    Endereco_Vendedor VARCHAR(60)
);

-- Cria a tabela "Pedido"
CREATE TABLE Pedido (
    Cod_Pedido INTEGER PRIMARY KEY,
    Cod_Vendedor INTEGER,
    Cod_Cliente INTEGER,
    Data_Pedido DATE,
    QTDE_Pedido FLOAT,
    Valor_Pedido FLOAT
);

-- Cria a tabela "Linha_Produto"
CREATE TABLE Linha_Produto (
    Cod_Linha INTEGER PRIMARY KEY,
    Descricao_Linha VARCHAR(60)
);

-- Cria a tabela "Produto"
CREATE TABLE Produto (
    Cod_Produto INTEGER PRIMARY KEY,
    Cod_Linha INTEGER,
    Nome_Produto VARCHAR(60),
    QTDE_Produto FLOAT
);

-- Cria a tabela "Item"
CREATE TABLE Item (
    Cod_Pedido INTEGER,
    Cod_Produto INTEGER,
    QTDE_Item FLOAT,
    Valor_Unit FLOAT,
    Valor_Parcial FLOAT,
    PRIMARY KEY (Cod_Pedido, Cod_Produto)
);

-- Adiciona as chaves estrangeiras
ALTER TABLE Pedido
ADD CONSTRAINT fk_pedido_vendedor
FOREIGN KEY (Cod_Vendedor) REFERENCES Vendedor(Cod_Vendedor);

ALTER TABLE Pedido
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (Cod_Cliente) REFERENCES Cliente(Cod_Cliente);

ALTER TABLE Produto
ADD CONSTRAINT fk_produto_linha
FOREIGN KEY (Cod_Linha) REFERENCES Linha_Produto(Cod_Linha);

ALTER TABLE Item
ADD CONSTRAINT fk_item_pedido
FOREIGN KEY (Cod_Pedido) REFERENCES Pedido(Cod_Pedido);

ALTER TABLE Item
ADD CONSTRAINT fk_item_produto
FOREIGN KEY (Cod_Produto) REFERENCES Produto(Cod_Produto);