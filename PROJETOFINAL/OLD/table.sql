CREATE DATABASE loja;

DROP TABLE item IF EXISTS;
--DROP TABLE vendas IF EXISTS;
DROP TABLE contracheque IF EXISTS;
DROP TABLE produto IF EXISTS;
DROP TABLE vendedores IF EXISTS;
DROP TABLE clientes IF EXISTS;

CREATE TABLE clientes(
    cpfclientes CHAR(11) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    --data_nascimento DATE NOT NULL CHECK ((CURRENT_DATE - data_nascimento) >= 6575),
    genero CHAR (1) CHECK(genero = 'M'  OR  genero = 'F') NOT NULL,
    PRIMARY KEY (cpfclientes)
);

CREATE TABLE vendedores(
    matricula VARCHAR(5) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    salario  FLOAT,
   /* data_nascimento DATE NOT NULL,
    qtd_dependentes INTEGER, */   
    PRIMARY KEY (matricula)
);

CREATE TABLE notafiscal(
    codigonf INT NOT NULL,
    cliente VARCHAR(11),
    matricula_vendedor varchar(5),
    PRIMARY KEY(codigonf),
    FOREIGN KEY(matricula_vendedor) REFERENCES(matricula)
)

CREATE TABLE produto (
    codigoproduto VARCHAR(20),
    nome VARCHAR (100),
    descricao VARCHAR (30),
    preco FLOAT,
    comissao FLOAT,
    PRIMARY KEY (codigoproduto)
);
  
CREATE TABLE contracheque(
    matricula VARCHAR(5),
    data_ref DATE,
    vendedor VARCHAR (5),
    salario FLOAT,
    PRIMARY KEY (matricula),
    FOREIGN KEY (vendedor) REFERENCES vendedores(matricula)
);

/*CREATE TABLE vendas(
    codigo VARCHAR(20),
    cliente CHAR(11),
    vendedor CHAR (11),
    quantidade INTEGER,
    comissao FLOAT,
    data_venda TIMESTAMP,
    PRIMARY KEY (codigo),
    FOREIGN KEY (cliente) REFERENCES clientes(cpf),
    FOREIGN KEY (vendedor) REFERENCES vendedores(cpf)
);*/

CREATE TABLE item(
    codigoitem VARCHAR (20),
    notafiscal VARCHAR(15),
    codigo_produto VARCHAR (20),
    PRIMARY KEY (codigoitem),
	--FOREIGN KEY (venda) REFERENCES vendas(codigo),
    FOREIGN KEY (codigo_produto) REFERENCES produto(codigoproduto)
);