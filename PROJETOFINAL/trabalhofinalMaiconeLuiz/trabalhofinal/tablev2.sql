

DROP TABLE item ;
DROP TABLE contracheque ;
DROP TABLE produto ;
DROP TABLE nota_fiscal;
DROP TABLE vendedores ;
DROP TABLE clientes ;

CREATE TABLE clientes(
    cpfcliente CHAR(11) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE  CHECK (extract(year from age(data_nascimento)) >=18),
    genero CHAR (1) CHECK(genero = 'M'  OR  genero = 'F') NOT NULL,
    PRIMARY KEY (cpfcliente)
);

CREATE TABLE vendedores(
    cpf VARCHAR(11) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    salario  decimal(12,2) CHECK (salario>0) NOT NULL,   
    qtd_dependentes INTEGER NOT NULL, 
    PRIMARY KEY (cpf)
);

CREATE TABLE nota_fiscal(
    numeronf VARCHAR(8) NOT NULL,
    cliente VARCHAR(11),
    cpf_vendedor varchar(11) NOT NULL,
    desconto FLOAT check (desconto<= 0.20) NOT NULL,
    nome_gerente VARCHAR(100),
    data date NOT NULL,
    hora time NOT NULL,
    PRIMARY KEY(numeronf),
    FOREIGN KEY(cpf_vendedor) REFERENCES vendedores (cpf),
    FOREIGN KEY(cliente) REFERENCES clientes (cpfcliente)
);

CREATE TABLE produto (
    codigo_produto VARCHAR(10) NOT NULL,
    nome VARCHAR (50) NOT NULL,
    descricao VARCHAR (100),
    preco decimal(12,2) NOT NULL check (preco>0),
    comissao FLOAT NOT NULL check (comissao<=0.30),
    PRIMARY KEY (codigo_produto)
);
  
CREATE TABLE contracheque(    
    data_ref DATE NOT NULL,
    vendedor VARCHAR (11) NOT NULL,
    salario decimal(12,2) CHECK (salario>0) NOT NULL,  
    qtd_dependentes INTEGER NOT NULL,     
    FOREIGN KEY (vendedor) REFERENCES vendedores(cpf),
    PRIMARY KEY (vendedor,data_ref)
);


CREATE TABLE item(
    codigo_item VARCHAR (4) NOT NULL,
    nota_fiscal VARCHAR(8) NOT NULL,
    codigo_produto VARCHAR (10) NOT NULL,
    quantidade INTEGER CHECK (quantidade>0) NOT NULL,
    precoun decimal(12,2) CHECK (precoun>0) not null,
    comissao FLOAT NOT NULL check (comissao<=0.30),
    FOREIGN KEY (nota_fiscal) REFERENCES nota_fiscal(numeronf),    
    FOREIGN KEY (codigo_produto) REFERENCES produto(codigo_produto),
    PRIMARY KEY (codigo_item,nota_fiscal)
);