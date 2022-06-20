

DROP TABLE item ;
DROP TABLE contracheque ;
DROP TABLE produto ;
DROP TABLE nota_fiscal;
DROP TABLE vendedores ;
DROP TABLE clientes ;

CREATE TABLE clientes(
    cpfcliente CHAR(11) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE  CHECK ((CURRENT_DATE - data_nascimento) >= 6575),
    genero CHAR (1) CHECK(genero = 'M'  OR  genero = 'F') NOT NULL,
    PRIMARY KEY (cpfcliente)
);

CREATE TABLE vendedores(
    cpf VARCHAR(11) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    salario  decimal(12,2),   
    qtd_dependentes INTEGER, 
    PRIMARY KEY (cpf)
);

CREATE TABLE nota_fiscal(
    numeronf VARCHAR(8) NOT NULL,
    cliente VARCHAR(11),
    cpf_vendedor varchar(11),
    desconto FLOAT check (desconto<= 0.20),
    nome_gerente VARCHAR(100),
    data timestamp,
    PRIMARY KEY(numeronf),
    FOREIGN KEY(cpf_vendedor) REFERENCES vendedores (cpf)
);

CREATE TABLE produto (
    codigo_produto VARCHAR(10) NOT NULL,
    nome VARCHAR (50) NOT NULL,
    descricao VARCHAR (100),
    preco decimal(12,2) NOT NULL check (preco>0),
    comissao FLOAT NOT NULL,
    PRIMARY KEY (codigo_produto)
);
  
CREATE TABLE contracheque(    
    data_ref DATE,
    vendedor VARCHAR (11),
    salario decimal(12,2),    
    FOREIGN KEY (vendedor) REFERENCES vendedores(cpf),
    PRIMARY KEY (vendedor,data_ref)
);


CREATE TABLE item(
    codigo_item VARCHAR (4),
    nota_fiscal VARCHAR(8),
    codigo_produto VARCHAR (10),
    quantidade INTEGER,
    precoun decimal(12,2) not null,
    FOREIGN KEY (nota_fiscal) REFERENCES nota_fiscal(numeronf),
    PRIMARY KEY (codigo_item,nota_fiscal),	
    FOREIGN KEY (codigo_produto) REFERENCES produto(codigo_produto)
);