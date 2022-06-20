drop table locacao;
drop table condutor;
drop table revisao;
drop table cliente;
drop table veiculocaracteristica;
drop table caracteristica;
drop table veiculo;
drop table categoriaveiculo;
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

CREATE TABLE categoriaveiculo(
    nome VARCHAR (14) NOT NULL,  
    filial CHAR (14) NOT NULL, 
    codigocat VARCHAR(3) NOT NULL,
    valordadiaria REAL NOT NULL,   
    FOREIGN KEY (filial) REFERENCES filial (CNPJ),
    PRIMARY KEY (codigocat)
    
);

CREATE TABLE veiculo(
    marca VARCHAR (20) NOT NULL,  
    modelo VARCHAR (50) NOT NULL,
    placa VARCHAR (7) NOT NULL,
    categoria VARCHAR(3) NOT NULL,
    ano VARCHAR (4) NOT NULL,
    apolice VARCHAR (50),
    descricao VARCHAR (200),
    filial CHAR (14) NOT NULL, 
    dataultimarevisao TIMESTAMP NOT NULL,        
    PRIMARY KEY (placa),
    FOREIGN KEY (filial) REFERENCES filial (CNPJ),
    FOREIGN KEY (categoria) REFERENCES categoriaveiculo (codigocat)
    
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

CREATE TABLE condutor(
    documento VARCHAR (14) NOT NULL,  
    nome VARCHAR (100) NOT NULL,
    datadenascimento DATE,   
    genero VARCHAR (1) NOT NULL,
    matriz CHAR (14) NOT NULL,      
    PRIMARY KEY (documento),
    FOREIGN KEY (matriz) REFERENCES matriz (CNPJ)
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
    condutor VARCHAR (14) NOT NULL,            
    PRIMARY KEY (codigolocacao),
    FOREIGN KEY (veiculo) REFERENCES veiculo (placa),
    FOREIGN KEY (cliente) REFERENCES cliente (documento),
    FOREIGN KEY (condutor) REFERENCES condutor (documento),
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

INSERT INTO categoriaveiculo (codigocat,nome,filial,valordadiaria) values
('1','SUV','12345678911234',480),
('2','camionete','12345678911234',480),
('3','compacto','12345678911234',480),
('4','SUV','12345678911235',480),
('5','camionete','12345678911235',480),
('6','compacto','12345678911235',480);




INSERT INTO veiculo (marca, modelo, placa, categoria, filial,ano, apolice, descricao, dataultimarevisao) values
('Renault','Duster 1.6','ABC1A23','4', '12345678911235','2019','ABC12345/2020','câmbio manual, ar-condicionado, direção hidráulica, vidros e travas elétricas, freios ABS', '2020-08-31 09:00:00'),
('volkswagen','gremio','XYZ1A35','5','12345678911235','2020','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('volkswagen','gremio','XYZ1A36','5','12345678911235','2018','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('volkswagen','flamengo','XYZ1A37','5','12345678911235','2021','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('volkswagen','fusca','XYZ1A38','3','12345678911234','1970','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('volkswagen','gol','XYZ1A39','6','12345678911235','2005','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('volkswagen','gol','XYZ1A40','6','12345678911235','2010','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('Renault','kwid','XYZ1A41','6','12345678911235','2015','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('Renault','clio','XYZ1A42','3','12345678911234','2018','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('Renault','barcelona','XYZ1A43','6','12345678911235','2017','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('chevrolet','celta','XYZ1A44','3','12345678911234','1970','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('chevrolet','celta','XYZ1A45','6','12345678911235','2005','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('chevrolet','celta','XYZ1A46','6','12345678911235','2010','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('chevrolet','celta','XYZ1A47','3','12345678911234','2015','ABC12345/2020',NULL,'2021-01-01 09:00:00'),
('chevrolet','celta','XYZ1A48','6','12345678911235','2018','ABC12345/2020',NULL,'2021-07-01 09:00:00'),
('fiat','uno','XYZ1A49','3','12345678911234','2017','ABC12345/2020',NULL,'2021-07-01 09:00:00'),
('fiat','palio','XYZ1A50','6','12345678911235','2018','ABC12345/2020',NULL,'2021-07-01 09:00:00'),
('fiat','uno','XYZ1A51','6','12345678911235','2017','ABC12345/2020',NULL,'2021-07-01 09:00:00'),
('fiat','palio','XYZ1A52','6','12345678911235','2018','ABC12345/2021',NULL,'2021-07-01 09:00:00'),
('Renault','Duster 1.6','XYZ1A34','4','12345678911235','2019','ABC12345/2020','câmbio manual, ar-condicionado, direção hidráulica, vidros e travas elétricas, freios ABS','2020-08-25 09:00:00');

INSERT INTO condutor (documento, nome, datadenascimento, genero, matriz) values
('123456789','Luis Inácio Lula da Silva','1950-01-10','m','12345678911231'),
('123456788','Roberto Jefferson','1955-01-10','m','12345678911231'),
('123456786','Ciro Gomes','1970-01-10','m','12345678911231'),
('123333781','Geraldo Alckmin','1980-01-10','m','12345678911231'),
('123444782','Marisa Leticia','1990-01-10','f','12345678911231'),
('122226783','Sergia Moro','2000-01-10','f','12345678911231'),
('123411184','Antonia Palocci','1999-01-10','f','12345678911231');


INSERT INTO locacao (codigolocacao, dataretirada, dataentrega, filialretirada, filialentrega, kmretirada, kmentrega, formapagamento, valordalocacao, condicoesveiculo, cliente, veiculo, condutor) values
('00001','2019-01-21 18:00:00','2019-01-24 09:00:00','12345678911235','12345678911234',25030,25640,'dinheiro',480,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','XYZ1A34','123456789'),
('00002','2019-08-21 18:00:00','2019-08-24 09:00:00','12345678911235','12345678911234',25030,25640,'dinheiro',480,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','XYZ1A34','123456789'),
('00003','2020-08-21 18:00:00','2020-08-24 09:00:00','12345678911235','12345678911234',25030,25640,'dinheiro',480,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','XYZ1A34','123456789'),
('00004','2020-08-22 18:00:00','2020-08-25 09:00:00','12345678911235','12345678911234',25030,25640,'dinheiro',600,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','ABC1A23','123456789'),
('00005','2020-08-25 18:00:00','2020-08-31 09:00:00','12345678911235','12345678911234',25640,28000,'dinheiro',480,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','XYZ1A34','123456789'),
('00006','2020-08-25 18:00:00','2020-08-31 09:00:00','12345678911235','12345678911234',5000,5500,'dinheiro',400,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456785','XYZ1A36','123333781'),
('00007','2021-01-02 18:00:00','2021-01-04 09:00:00','12345678911234','12345678911235',25640,25840,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','ABC1A23','123456788'),
('00008','2021-01-02 18:00:00','2021-01-04 09:00:00','12345678911234','12345678911235',6250,6500,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A37','123456788'),
('00009','2021-01-02 18:00:00','2021-01-04 09:00:00','12345678911234','12345678911235',6250,6500,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A38','123456788'),
('00010','2021-01-02 18:00:00','2021-01-04 09:00:00','12345678911234','12345678911235',6250,6500,' cartao de credito',600,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A39','123456788'),
('00011','2021-01-02 18:00:00','2021-01-04 09:00:00','12345678911234','12345678911235',6250,6500,'dinheiro',400,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A40','123456788'),
('00012','2021-01-10 18:00:00','2021-01-15 09:00:00','12345678911235','12345678911235',25840,26040,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','ABC1A23','123456788'),
('00013','2021-01-10 18:00:00','2021-01-15 09:00:00','12345678911234','12345678911235',5500,5750,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A36','123456788'),
('00014','2021-01-20 18:00:00','2021-01-25 09:00:00','12345678911234','12345678911235',26040,26240,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','ABC1A23','123456788'),
('00015','2021-01-20 18:00:00','2021-01-25 09:00:00','12345678911234','12345678911235',28000,30000,' cartao de credito',1800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A35','123456788'),
('00016','2021-01-20 18:00:00','2021-01-25 09:00:00','12345678911235','12345678911234',5750,6000,'dinheiro',400,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','XYZ1A36','123456788'),
('00017','2021-02-01 09:00:00','2021-02-02 18:00:00','12345678911235','12345678911234',0,200,'dinheiro',480,NULL,'123456787','XYZ1A48','123456789'),
('00018','2021-02-01 18:00:00','2021-02-05 09:00:00','12345678911234','12345678911235',26240,26440,' cartao de credito',800,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456788','ABC1A23','123456788'),
('00019','2021-02-01 18:00:00','2021-02-05 09:00:00','12345678911235','12345678911234',6000,6250,'dinheiro',400,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456787','XYZ1A36','123456789'),
('00020','2021-02-02 18:00:00','2021-02-03 09:00:00','12345678911234','12345678911234',200,400,'dinheiro',480,NULL,'123456787','XYZ1A48','123456789'),
('00021','2021-02-03 09:00:00','2021-02-03 18:00:00','12345678911235','12345678911234',400,600,'dinheiro',480,NULL,'123456786','XYZ1A48','123456786'),
('00022','2021-02-03 18:00:00','2021-02-04 09:00:00','12345678911235','12345678911234',600,800,'dinheiro',480,NULL,'123456787','XYZ1A48','123444782'),
('00023','2021-02-04 09:00:00','2021-02-05 18:00:00','12345678911234','12345678911235',800,1000,'dinheiro',480,NULL,'123456790','XYZ1A48','123444782'),
('00024','2021-04-05 18:00:00','2021-04-06 09:00:00','12345678911235','12345678911234',1000,1200,'dinheiro',480,NULL,'123456790','XYZ1A48','123444782'),
('00025','2021-04-06 09:00:00','2021-04-06 18:00:00','12345678911234','12345678911234',1200,1400,'dinheiro',480,NULL,'123456790','XYZ1A48','123444782'),
('00026','2021-05-06 18:00:00','2021-05-07 09:00:00','12345678911234','12345678911234',1400,1600,'dinheiro',480,NULL,'123456791','XYZ1A48','122226783'),
('00027','2021-06-07 09:00:00','2021-06-07 18:00:00','12345678911234','12345678911234',1600,1800,'dinheiro',480,NULL,'123456791','XYZ1A48','122226783'),
('00028','2021-07-07 18:00:00','2021-07-08 09:00:00','12345678911234','12345678911234',1800,2000,'dinheiro',480,NULL,'123456792','XYZ1A48','122226783'),
('00029','2021-08-01 09:00:00','2021-08-02 18:00:00','12345678911234','12345678911234',0,200,'dinheiro',480,NULL,'123456792','XYZ1A49','123456789'),
('00030','2021-09-02 18:00:00','2021-09-03 09:00:00','12345678911235','12345678911234',200,400,'dinheiro',480,NULL,'123456790','XYZ1A49','123456789'),
('00031','2021-09-03 09:00:00','2021-09-03 18:00:00','12345678911235','12345678911234',400,600,'dinheiro',480,NULL,'123456790','XYZ1A49','123456789'),
('00032','2021-09-03 18:00:00','2021-09-04 09:00:00','12345678911235','12345678911234',600,800,'dinheiro',480,NULL,'123456790','XYZ1A49','123456789'),
('00033','2021-09-04 09:00:00','2021-09-05 18:00:00','12345678911235','12345678911234',800,1000,'dinheiro',480,NULL,'123456791','XYZ1A49','123456789'),
('00034','2021-09-05 18:00:00','2021-09-06 09:00:00','12345678911235','12345678911234',1000,1200,'dinheiro',480,NULL,'123456792','XYZ1A49','123456789'),
('00035','2021-09-06 09:00:00','2021-09-06 18:00:00','12345678911235','12345678911234',1200,1400,'dinheiro',480,NULL,'123456792','XYZ1A49','123456789'),
('00036','2021-09-06 18:00:00','2021-09-07 09:00:00','12345678911235','12345678911234',1400,1600,'dinheiro',480,NULL,'123456792','XYZ1A49','123456789'),
('00037','2021-09-07 09:00:00','2021-09-07 18:00:00','12345678911235','12345678911234',1600,1800,'dinheiro',480,NULL,'123456787','XYZ1A51','123456789'),
('00038','2021-09-07 18:00:00','2021-09-08 09:00:00','12345678911235','12345678911234',1800,2000,'dinheiro',480,NULL,'123456787','XYZ1A51','123456789'),
('00039','2021-09-30 18:00:00','2021-10-02 18:00:00','12345678911235','12345678911234',28000,30000,'dinheiro',480,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456789','XYZ1A34','123456789'),
('00040','2021-09-30 18:00:00','2021-10-02 18:00:00','12345678911235','12345678911234',6250,6500,'dinheiro',400,'tanque cheio e sem alterações na condição da lataria e da mecânica','123456786','XYZ1A36','123456786'),
('00041','2021-10-10 18:00:00',NULL,'12345678911235',NULL,6500,NULL,'dinheiro',400,NULL,'123456792','XYZ1A36','123333781'),
('00042','2021-10-10 18:00:00',NULL,'12345678911235',NULL,30000,NULL,'dinheiro',480,NULL,'123456789','XYZ1A34','123456789');

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
('00003','2020-08-31 09:00:00', 12450.00, 'ABC1A23' ),
('00002','2020-08-26 09:00:00', 12450.00, 'ABC1A23' ),
('00001','2020-08-25 09:00:00', 12450.00, 'XYZ1A34' ),
('00004','2021-01-01 09:00:00',28000,'XYZ1A35'),
('00005','2021-01-01 09:00:00',6250,'XYZ1A40'),
('00006','2021-01-01 09:00:00',6250,'XYZ1A37'),
('00007','2021-01-01 09:00:00',0,'XYZ1A48'),
('00008','2021-01-01 09:00:00',1600,'XYZ1A51'),
('00009','2021-01-01 09:00:00',0,'XYZ1A49'),
('00010','2021-01-01 09:00:00',6250,'XYZ1A39'),
('00011','2021-01-01 09:00:00',5000,'XYZ1A36'),
('00012','2021-01-01 09:00:00',6250,'XYZ1A38'),
('00013','2021-10-01 09:00:00',26440,'ABC1A23'),
('00014','2021-10-01 09:00:00',28000,'XYZ1A34'),
('00015','2021-10-01 09:00:00',30000,'XYZ1A35'),
('00016','2021-01-01 09:00:00',0,'XYZ1A41'),
('00017','2021-01-01 09:00:00',0,'XYZ1A42'),
('00018','2021-01-01 09:00:00',0,'XYZ1A43'),
('00019','2021-01-01 09:00:00',0,'XYZ1A44'),
('00020','2021-01-01 09:00:00',0,'XYZ1A45'),
('00021','2021-01-01 09:00:00',0,'XYZ1A46'),
('00022','2021-01-01 09:00:00',0,'XYZ1A47'),
('00023','2021-07-01 09:00:00',0,'XYZ1A50'),
('00024','2021-07-01 09:00:00',0,'XYZ1A52');















