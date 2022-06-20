drop table locacao;
drop table revisao;
drop table cliente;
drop table veiculo;
drop table filial;
drop table matriz;



CREATE TABLE matriz(
    nome VARCHAR (100) NOT NULL,  
    CNPJ CHAR (14) NOT NULL,    
    PRIMARY KEY (CNPJ)
);

CREATE TABLE filial(
    nome VARCHAR (100) NOT NULL,  
    CNPJ CHAR (14) NOT NULL, 
    matriz CHAR (14) NOT NULL,   
    PRIMARY KEY (CNPJ),
    FOREIGN KEY (matriz) REFERENCES matriz (CNPJ)
);

CREATE TABLE veiculo(
    marca VARCHAR (20) NOT NULL,  
    modelo VARCHAR (50) NOT NULL,
    placa VARCHAR (7) NOT NULL,
    categoria VARCHAR (15) NOT NULL,
    ano VARCHAR (4) NOT NULL,
    apolice VARCHAR (50),
    descricao VARCHAR (200),
    filial CHAR (14) NOT NULL,         
    PRIMARY KEY (placa),
    FOREIGN KEY (filial) REFERENCES filial (CNPJ)
);

CREATE TABLE cliente(
    documento VARCHAR (14) NOT NULL,  
    nome VARCHAR (100) NOT NULL,
    datadenascimento DATE,
    PFPJ VARCHAR (2) NOT NULL,
    quantlocacoes integer,    
    matriz CHAR (14) NOT NULL,      
    PRIMARY KEY (documento),
    FOREIGN KEY (matriz) REFERENCES matriz (CNPJ)
);

CREATE TABLE revisao(
    codsequencial VARCHAR (5) NOT NULL,  
    datarevisao TIMESTAMP NOT NULL,
    kmrevisao REAL NOT NULL,
    veiculo VARCHAR (7) NOT NULL,              
    PRIMARY KEY (codsequencial),
    FOREIGN KEY (veiculo) REFERENCES veiculo (placa)
);

CREATE TABLE locacao(
    codigolocacao VARCHAR (5) NOT NULL,  
    dataretirada TIMESTAMP NOT NULL,
    dataentrega TIMESTAMP ,
    filialretirada CHAR (14) NOT NULL,
    filialentrega CHAR (14) , 
    kmretirada REAL NOT NULL,
    kmentrega REAL ,
    formapagamento VARCHAR (20),
    condicoesveiculo VARCHAR (500),
    cliente VARCHAR (14) NOT NULL,
    veiculo VARCHAR (7) NOT NULL,                 
    PRIMARY KEY (codigolocacao),
    FOREIGN KEY (veiculo) REFERENCES veiculo (placa),
    FOREIGN KEY (cliente) REFERENCES cliente (documento),
    FOREIGN KEY (filialretirada) REFERENCES filial (CNPJ),
    FOREIGN KEY (filialentrega) REFERENCES filial (CNPJ)
);


INSERT INTO matriz (CNPJ, nome) values
('12345678911231','São Paulo');

INSERT INTO filial (CNPJ, nome, matriz) values
('12345678911234','Porto Alegre – Aeroporto','12345678911231'),
('12345678911235','Rio Grande','12345678911231');

INSERT INTO cliente (documento, nome, datadenascimento,PFPJ, quantlocacoes, matriz) values
('123456789','Fulano da Silva',NULL,'pf',NULL,'12345678911231');

INSERT INTO veiculo (marca, modelo, placa, categoria,ano, apolice, descricao, filial) values
('Renault','Duster 1.6','XYZ1A34','SUV','2019','ABC12345/2020','câmbio manual, ar-condicionado, direção hidráulica, vidros e travas elétricas, freios ABS','12345678911235');

INSERT INTO locacao (codigolocacao, dataretirada, dataentrega, filialretirada, filialentrega, kmretirada, kmentrega, formapagamento, condicoesveiculo, cliente, veiculo) values
('00001', '2020-08-21 18:00:00' , '2020-08-24 09:00:00' , '12345678911235' , '12345678911234', 25030.00, 25640.00, '480 em dinheiro', 'tanque cheio e sem alterações na condição da lataria e da mecânica', '123456789', 'XYZ1A34');





