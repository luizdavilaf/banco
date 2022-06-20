drop table locacao;
drop table revisao;
drop table cliente;
drop table veiculocaracteristica;
drop table caracteristica;
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
    dataultimarevisao TIMESTAMP,        
    PRIMARY KEY (placa),
    FOREIGN KEY (filial) REFERENCES filial (CNPJ)
);

CREATE TABLE caracteristica(
    codigocaracteristica VARCHAR (3) NOT NULL,
    nome VARCHAR (30) NOT NULL,
    PRIMARY KEY (codigocaracteristica)
);

CREATE TABLE veiculocaracteristica(
    codigocaracteristica VARCHAR (3) NOT NULL,
    veiculo VARCHAR (7) NOT NULL,
    FOREIGN KEY (codigocaracteristica) REFERENCES caracteristica (codigocaracteristica),
    FOREIGN KEY (veiculo) REFERENCES veiculo (placa),    
    PRIMARY KEY (codigocaracteristica, veiculo )
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
    formapagamento VARCHAR (50),
    condicoesveiculo VARCHAR (500),
    cliente VARCHAR (14) NOT NULL,
    veiculo VARCHAR (7) NOT NULL,  
    valordalocacao REAL NOT NULL,               
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
('123456789','Luis Inácio Lula da Silva',NULL,'pf',NULL,'12345678911231'),
('123456788','Roberto Jefferson',NULL,'pf',NULL,'12345678911231'),
('123456787','Antonio Palocci S/A',NULL,'pj',NULL,'12345678911231'),
('123456790','Lebom LTDA',NULL,'pj',NULL,'12345678911231'),
('123456791','Gerdau',NULL,'pj',NULL,'12345678911231'),
('123456792','Itau',NULL,'pj',NULL,'12345678911231'),
('123456786','Ciro Gomes',NULL,'pf',NULL,'12345678911231'),
('123456785','Sergio Moro Enterprises',NULL,'pj',NULL,'12345678911231');




INSERT INTO veiculo (marca, modelo, placa, categoria,ano, apolice, descricao, filial, dataultimarevisao) values
('Renault','Duster 1.6','ABC1A23','SUV','2019','ABC12345/2020','câmbio manual, ar-condicionado, direção hidráulica, vidros e travas elétricas, freios ABS','12345678911235', '2020-08-31 09:00:00'),
('volkswagen','gremio','XYZ1A35','camionete','2020','ABC12345/2020',NULL,'12345678911235','2021-01-01 09:00:00'),
('volkswagen','gremio','XYZ1A36','camionete','2018','ABC12345/2020',NULL,'12345678911235','2021-01-01 09:00:00'),
('volkswagen','flamengo','XYZ1A37','camionete','2021','ABC12345/2020',NULL,'12345678911235','2021-01-01 09:00:00'),
('volkswagen','fusca','XYZ1A38','compacto','1970','ABC12345/2020',NULL,'12345678911234','2021-01-01 09:00:00'),
('volkswagen','gol','XYZ1A39','compacto','2005','ABC12345/2020',NULL,'12345678911235','2021-01-01 09:00:00'),
('volkswagen','gol','XYZ1A40','compacto','2010','ABC12345/2020',NULL,'12345678911235','2021-01-01 09:00:00'),
('Renault','kwid','XYZ1A41','compacto','2015','ABC12345/2020',NULL,'12345678911235','2021-01-01 09:00:00'),
('Renault','clio','XYZ1A42','compacto','2018','ABC12345/2020',NULL,'12345678911234','2021-01-01 09:00:00'),
('Renault','barcelona','XYZ1A43','compacto','2017','ABC12345/2020',NULL,'12345678911235','2021-01-01 09:00:00'),
('chevrolet','celta','XYZ1A44','compacto','1970','ABC12345/2020',NULL,'12345678911234','2021-01-01 09:00:00'),
('chevrolet','celta','XYZ1A45','compacto','2005','ABC12345/2020',NULL,'12345678911235','2021-01-01 09:00:00'),
('chevrolet','celta','XYZ1A46','compacto','2010','ABC12345/2020',NULL,'12345678911235','2021-01-01 09:00:00'),
('chevrolet','celta','XYZ1A47','compacto','2015','ABC12345/2020',NULL,'12345678911234','2021-01-01 09:00:00'),
('chevrolet','celta','XYZ1A48','compacto','2018','ABC12345/2020',NULL,'12345678911235','2021-07-01 09:00:00'),
('fiat','uno','XYZ1A49','compacto','2017','ABC12345/2020',NULL,'12345678911234','2021-07-01 09:00:00'),
('fiat','palio','XYZ1A50','compacto','2018','ABC12345/2020',NULL,'12345678911235','2021-07-01 09:00:00'),
('fiat','uno','XYZ1A51','compacto','2017','ABC12345/2020',NULL,'12345678911235','2021-07-01 09:00:00'),
('fiat','palio','XYZ1A52','compacto','2018','ABC12345/2021',NULL,'12345678911235','2021-07-01 09:00:00'),
('Renault','Duster 1.6','XYZ1A34','SUV','2019','ABC12345/2020','câmbio manual, ar-condicionado, direção hidráulica, vidros e travas elétricas, freios ABS','12345678911235','2020-08-25 09:00:00');

INSERT INTO locacao (codigolocacao, dataretirada, dataentrega, filialretirada, filialentrega, kmretirada, kmentrega, formapagamento, valordalocacao, condicoesveiculo, cliente, veiculo) values
('0001','2019-01-21 18:00:00','2019-01-24 09:00:00','12345678911235','12345678911234',25030,25640,'dinheiro',480,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','XYZ1A34'),
('0002','2019-08-21 18:00:00','2019-08-24 09:00:00','12345678911235','12345678911234',25030,25640,'dinheiro',480,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','XYZ1A34'),
('0003','2020-08-21 18:00:00','2020-08-24 09:00:00','12345678911235','12345678911234',25030,25640,'dinheiro',480,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','XYZ1A34'),
('0004','2020-08-22 18:00:00','2020-08-25 09:00:00','12345678911235','12345678911234',25030,25640,'dinheiro',600,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','ABC1A23'),
('0005','2020-08-25 18:00:00','2020-08-31 09:00:00','12345678911235','12345678911234',25640,28000,'dinheiro',480,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','XYZ1A34'),
('0006','2020-08-25 18:00:00','2020-08-31 09:00:00','12345678911235','12345678911234',5000,5500,'dinheiro',400,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456785','XYZ1A36'),
('0007','2021-01-02 18:00:00','2021-01-04 09:00:00','12345678911234','12345678911235',25640,25840,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','ABC1A23'),
('0008','2021-01-02 18:00:00','2021-01-04 09:00:00','12345678911234','12345678911235',6250,6500,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A37'),
('0009','2021-01-02 18:00:00','2021-01-04 09:00:00','12345678911234','12345678911235',6250,6500,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A38'),
('00010','2021-01-02 18:00:00','2021-01-04 09:00:00','12345678911234','12345678911235',6250,6500,' cartao de credito',600,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A39'),
('00011','2021-01-02 18:00:00','2021-01-04 09:00:00','12345678911234','12345678911235',6250,6500,'dinheiro',400,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A40'),
('00012','2021-01-10 18:00:00','2021-01-15 09:00:00','12345678911235','12345678911235',25840,26040,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','ABC1A23'),
('00013','2021-01-10 18:00:00','2021-01-15 09:00:00','12345678911234','12345678911235',5500,5750,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A36'),
('00014','2021-01-20 18:00:00','2021-01-25 09:00:00','12345678911234','12345678911235',26040,26240,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','ABC1A23'),
('00015','2021-01-20 18:00:00','2021-01-25 09:00:00','12345678911234','12345678911235',28000,30000,' cartao de credito',1800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A35'),
('00016','2021-01-20 18:00:00','2021-01-25 09:00:00','12345678911235','12345678911234',5750,6000,'dinheiro',400,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A36'),
('00017','2021-02-01 09:00:00','2021-02-02 18:00:00','12345678911235','12345678911234',0,200,'dinheiro',480,NULL,'123456787','XYZ1A48'),
('00018','2021-02-01 18:00:00','2021-02-05 09:00:00','12345678911234','12345678911235',26240,26440,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','ABC1A23'),
('00019','2021-02-01 18:00:00','2021-02-05 09:00:00','12345678911235','12345678911234',6000,6250,'dinheiro',400,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456787','XYZ1A36'),
('00020','2021-02-02 18:00:00','2021-02-03 09:00:00','12345678911234','12345678911234',200,400,'dinheiro',480,NULL,'123456787','XYZ1A48'),
('00021','2021-02-03 09:00:00','2021-02-03 18:00:00','12345678911235','12345678911234',400,600,'dinheiro',480,NULL,'123456786','XYZ1A48'),
('00022','2021-02-03 18:00:00','2021-02-04 09:00:00','12345678911235','12345678911234',600,800,'dinheiro',480,NULL,'123456787','XYZ1A48'),
('00023','2021-02-04 09:00:00','2021-02-05 18:00:00','12345678911234','12345678911235',800,1000,'dinheiro',480,NULL,'123456790','XYZ1A48'),
('00024','2021-02-05 18:00:00','2021-02-06 09:00:00','12345678911234','12345678911234',1000,1200,'dinheiro',480,NULL,'123456790','XYZ1A48'),
('00025','2021-02-06 09:00:00','2021-02-06 18:00:00','12345678911234','12345678911234',1200,1400,'dinheiro',480,NULL,'123456790','XYZ1A48'),
('00026','2021-02-06 18:00:00','2021-02-07 09:00:00','12345678911234','12345678911234',1400,1600,'dinheiro',480,NULL,'123456791','XYZ1A48'),
('00027','2021-02-07 09:00:00','2021-02-07 18:00:00','12345678911234','12345678911234',1600,1800,'dinheiro',480,NULL,'123456791','XYZ1A48'),
('00028','2021-02-07 18:00:00','2021-02-08 09:00:00','12345678911234','12345678911234',1800,2000,'dinheiro',480,NULL,'123456792','XYZ1A48'),
('00029','2021-08-01 09:00:00','2021-08-02 18:00:00','12345678911234','12345678911234',0,200,'dinheiro',480,NULL,'123456792','XYZ1A49'),
('00030','2021-09-02 18:00:00','2021-09-03 09:00:00','12345678911235','12345678911234',200,400,'dinheiro',480,NULL,'123456790','XYZ1A49'),
('00031','2021-09-03 09:00:00','2021-09-03 18:00:00','12345678911235','12345678911234',400,600,'dinheiro',480,NULL,'123456790','XYZ1A49'),
('00032','2021-09-03 18:00:00','2021-09-04 09:00:00','12345678911235','12345678911234',600,800,'dinheiro',480,NULL,'123456790','XYZ1A49'),
('00033','2021-09-04 09:00:00','2021-09-05 18:00:00','12345678911235','12345678911234',800,1000,'dinheiro',480,NULL,'123456791','XYZ1A49'),
('00034','2021-09-05 18:00:00','2021-09-06 09:00:00','12345678911235','12345678911234',1000,1200,'dinheiro',480,NULL,'123456792','XYZ1A49'),
('00035','2021-09-06 09:00:00','2021-09-06 18:00:00','12345678911235','12345678911234',1200,1400,'dinheiro',480,NULL,'123456792','XYZ1A49'),
('00036','2021-09-06 18:00:00','2021-09-07 09:00:00','12345678911235','12345678911234',1400,1600,'dinheiro',480,NULL,'123456792','XYZ1A49'),
('00037','2021-09-07 09:00:00','2021-09-07 18:00:00','12345678911235','12345678911234',1600,1800,'dinheiro',480,NULL,'123456787','XYZ1A51'),
('00038','2021-09-07 18:00:00','2021-09-08 09:00:00','12345678911235','12345678911234',1800,2000,'dinheiro',480,NULL,'123456787','XYZ1A51'),
('00039','2021-09-30 18:00:00','2021-10-02 18:00:00','12345678911235','12345678911234',28000,30000,'dinheiro',480,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','XYZ1A34'),
('00040','2021-09-30 18:00:00','2021-10-02 18:00:00','12345678911235','12345678911234',6250,6500,'dinheiro',400,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456786','XYZ1A36'),
('00041','2021-10-10 18:00:00',NULL,'12345678911235',NULL,6500,NULL,'dinheiro',400,NULL,'123456792','XYZ1A36'),
('00042','2021-10-10 18:00:00',NULL,'12345678911235',NULL,30000,NULL,'dinheiro',480,NULL,'123456789','XYZ1A34');

insert into caracteristica(codigocaracteristica, nome) values
('001','cambio manual'),
('002','cambio automatico'),
('003','ar condicionado'),
('004','direcao hidraulica'),
('005','direcao eletrica'),
('007','trava eletrica'),
('008','freios abs'),
('006','vidro eletrico');

insert into veiculocaracteristica(codigocaracteristica, veiculo) values
('001','ABC1A23'),
('003','ABC1A23'),
('004','ABC1A23'),
('006','ABC1A23'),
('007','ABC1A23'),
('008','ABC1A23'),
('002','XYZ1A35'),
('002','XYZ1A36'),
('001','XYZ1A37'),
('001','XYZ1A38'),
('001','XYZ1A39'),
('001','XYZ1A40'),
('001','XYZ1A41'),
('001','XYZ1A42'),
('001','XYZ1A43'),
('001','XYZ1A44'),
('001','XYZ1A45'),
('001','XYZ1A46'),
('001','XYZ1A47'),
('002','XYZ1A48'),
('002','XYZ1A49'),
('002','XYZ1A50'),
('002','XYZ1A51'),
('001','XYZ1A52'),
('001','XYZ1A34'),
('003','XYZ1A36'),
('003','XYZ1A37'),
('003','XYZ1A38'),
('005','XYZ1A36'),
('005','XYZ1A37'),
('005','XYZ1A38'),
('006','XYZ1A36'),
('006','XYZ1A37'),
('006','XYZ1A38'),
('007','XYZ1A36'),
('007','XYZ1A37'),
('007','XYZ1A38'),
('008','XYZ1A36'),
('008','XYZ1A37'),
('008','XYZ1A38');


insert into revisao(codsequencial, datarevisao, kmrevisao, veiculo) values
('3','2020-08-31 09:00:00', 12450.00, 'ABC1A23' ),
('2','2020-08-26 09:00:00', 12450.00, 'ABC1A23' ),
('1','2020-08-25 09:00:00', 12450.00, 'XYZ1A34' );















