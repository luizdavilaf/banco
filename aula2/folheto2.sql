drop table folhetooferta;
drop table supermercadooferta;
drop table folheto;
drop table oferta;
drop table secaosupermercado;
drop table produto;
drop table meiodepagamento;
drop table secao;
drop table supermercado;




CREATE TABLE supermercado(
    nome VARCHAR (100) NOT NULL,  
    CNPJ CHAR (14) NOT NULL,
    cidade VARCHAR (40) NOT NULL,
    PRIMARY KEY (CNPJ)
);

CREATE TABLE secao(
    codigosecao CHAR (5) NOT NULL,
    nomesecao VARCHAR (20) NOT NULL,
    PRIMARY KEY (codigosecao)
);

CREATE TABLE meiodepagamento(
    codigopagamento CHAR (5) NOT NULL,
    nomepagamento VARCHAR (50) NOT NULL,
    PRIMARY KEY (codigopagamento)
);

CREATE TABLE produto(
    precoprod REAL,
    nomeProd VARCHAR (50),
    codigoprod CHAR (10) NOT NULL,
    descricao VARCHAR (200),   
    secao CHAR (5),
    PRIMARY KEY (codigoprod),
    FOREIGN KEY (secao) REFERENCES secao (codigosecao)
);



CREATE TABLE oferta(
    nomepromo CHAR (100) NOT NULL,
    codigopromo CHAR (5) NOT NULL,
    descricao VARCHAR (200),
    precopromo REAL,
    datainiciopromo TIMESTAMP,
    datafimpromo TIMESTAMP,
    meiodepagamento CHAR (5),
    produto CHAR (10) NOT NULL,
    PRIMARY KEY (codigopromo),
    FOREIGN KEY (meiodepagamento) REFERENCES meiodepagamento (codigopagamento),
    FOREIGN KEY (produto) REFERENCES produto (codigoprod)
);

CREATE TABLE folheto(    
    codigopanfleto CHAR (5) NOT NULL,
    supermercado CHAR (14) NOT NULL,          
    PRIMARY KEY (codigopanfleto),
    FOREIGN KEY (supermercado) REFERENCES supermercado (CNPJ)
    
);

CREATE TABLE folhetooferta(    
    folheto CHAR (5) NOT NULL,    
    oferta CHAR (5) NOT NULL,   
    PRIMARY KEY (folheto, oferta),    
    FOREIGN KEY (folheto) REFERENCES folheto (codigopanfleto),
    FOREIGN KEY (oferta) REFERENCES oferta (codigopromo)
);

CREATE TABLE supermercadooferta(    
    supermercado CHAR (14) NOT NULL,      
    oferta CHAR (5) NOT NULL,   
    PRIMARY KEY (supermercado, oferta),    
    FOREIGN KEY (supermercado) REFERENCES supermercado (CNPJ),
    FOREIGN KEY (oferta) REFERENCES oferta (codigopromo)
);
CREATE TABLE secaosupermercado(
    secao CHAR (5) NOT NULL,
    supermercado CHAR (14) NOT NULL,
    PRIMARY KEY (secao, supermercado),    
    FOREIGN KEY (secao) REFERENCES secao (codigosecao),
    FOREIGN KEY (supermercado) REFERENCES supermercado (CNPJ)
);



INSERT INTO supermercado (cidade, CNPJ, nome) values
('Pelotas','12345678901234','CompreCompreCompre Pelotas'),
('Rio Grande','12345678901235','CompreCompreCompre Rio Grande'),
('S??o Jos?? do Norte','12345678901236','CompreCompreCompre S??o Jos?? do Norte');

INSERT INTO secao (codigosecao, nomesecao) values
('00001','Ver??o'),
('00002','Alimentos'),
('00003','Higiene e Beleza');

INSERT INTO meiodepagamento (codigopagamento, nomepagamento) values
('00001','Cart??o de Credito CompreCompreCompre'),
('00002','dinheiro'),
('00003','Debito'),
('00004','Credito');

INSERT INTO secaosupermercado (secao, supermercado) values
('00001' , '12345678901234'),
('00002' , '12345678901234'),
('00003' , '12345678901234'),
('00001' , '12345678901235'),
('00002' , '12345678901235'),
('00003' , '12345678901235'),
('00001' , '12345678901236'),
('00002' , '12345678901236'),
('00003' , '12345678901236');

INSERT INTO produto (nomeProd, precoprod, codigoprod, secao) values
('Cadeira de praia SummerBeach',49.90,'6583094671','00001'),
('Lat??o de 475ml da cerveja BemGelada ', 3.99 ,'1745823139','00001'),
('Pizza pr??-pronta congelada Italian??ssima 4 queijos ', 9.90,'8697836843','00002'),
('Pizza pr??-pronta congelada calabresa',9.90,'8697836845','00002'),
('350g de amendoim torrado salgado BemBom ',NULL,'5130341195','00002'),
('Guaran?? Brasil 2L',NULL,'4532000427','00002'),
('Refrigerante Cola Coca 2L ', 6.60,'4532000793','00002'),
('Copo de 200ml de iogurte natural DoLeite ', 2.49 ,'1996328810','00002'),
('??leo de soja Fritare 800ml',NULL,'6682736037','00002'),
('Salgadins 1',NULL,'7740218685','00002'),
('Salgadins 2',NULL,'7740218688','00002'),
('Salgadins 3',NULL,'7740218689','00002'),
('Salgadins 4',NULL,'7740218690','00002'),
('Salgadins 5',NULL,'7740218692','00002'),
('Sabonete Cr??Cr?? ', 6.45,'0797272814','00003'),
('Absorvente Intimus com 35 unidades', 14.8 ,'5693331880','00003'),
('MeuBeb?? 1',NULL,'3560288208','00003'),
('MeuBeb?? 2',NULL,'3560288209','00003'),
('MeuBeb?? 3',NULL,'3560288210','00003'),
('MeuBeb?? 4',NULL,'3560288213','00003'),
('MeuBeb?? 5',NULL,'3560288215','00003'),
('MeuBeb?? 6',NULL,'3560288217','00003'),
('MeuBeb?? 7',NULL,'3560288218','00003'),
('Shampoo Cheiroso 450ml ',17.30,'2321306068','00003'),
('Condicionador Cheiroso 450ml ', 18.55,'2321306070','00003');








INSERT INTO oferta (nomepromo, codigopromo, descricao,precopromo, datainiciopromo,datafimpromo, meiodepagamento, produto) values
('Promo????o Cadeira de praia SummerBeach','00001','De 49,90 por 33,80', 33.80,'01/02/2021','28/02/2021','00001','6583094671'),
('Promo????o Lat??o de 475ml da cerveja BemGelada','00002','A cada 6 unidades ganha um pacote de 350g de amendoim torrado salgado BemBom', 23.94,'01/02/2021','28/02/2021',NULL,'1745823139'),
('Promo????o Pizza pr??-pronta congelada Italian??ssima 4 queijos','00003','a cada 2 unidades um refrigerante Guaran?? Brasil 2L sai por 0,10', 19.90 ,'01/02/2021','28/02/2021',NULL,'8697836843'),
('Promo????o Pizza pr??-pronta congelada Italian??ssima Calabresa','00004','a cada 2 unidades um refrigerante Guaran?? Brasil 2L sai por 0,11',19.90,'01/02/2021','28/02/2021',NULL,'8697836845'),
('Promo????o Refrigerante Cola Coca 2L ','00005','ganhe 20% de desconto no cart??o CompreCompreCompre no dia do seu anivers??rio', 5.28 ,'01/02/2021','28/02/2021','00001','4532000793'),
('Promo????o Copo de 200ml de iogurte natural DoLeite','00006','desconto de 50% a 3 ou menos dias do vencimento', 1.25,'01/02/2021','28/02/2021',NULL,'1996328810'),
('Promo????o ??leo de soja Fritare 800ml ','00007','promo????o v??lida apenas para os dias 15 e 16/02, m??ximo de 6 unidades por cliente', 5.99,'15/02/2021','16/02/2021',NULL,'6682736037'),
('Promo????o Marca Salgadins','00008','Leve 3 produtos da marca Salgadins ',NULL,'01/02/2021','28/02/2021',NULL,'7740218685'),
('Promo????o Sabonete Cr??Cr??','00009','leve 3 pague 2;', 12.90 ,'01/02/2021','28/02/2021',NULL,'0797272814'),
('Promo????o Absorvente Intimus com 35 unidades','00010','leve 3 ganhe 15% de desconto', 37.74,'01/02/2021','28/02/2021',NULL,'5693331880'),
('Promo????o marca MeuBeb??','00011','nas ter??as-feiras tem 10% de desconto',NULL,'01/02/2021','28/02/2021',NULL,'3560288208'),
('Promo????o Shampoo Cheiroso 450ml ','00012','com desconto', 17.30 ,'01/02/2021','28/02/2021',NULL,'2321306068'),
('Promo????o Condicionador Cheiroso 450ml','00013','com desconto', 18.55, '01/02/2021','28/02/2021',NULL,'2321306068'),
('Promo????o Shampoo Cheiroso 450ml + Condicionador Cheiroso 450ml','00014','com desconto', 29.99 ,'01/02/2021','28/02/2021',NULL,'2321306070');

INSERT INTO folheto (codigopanfleto, supermercado) values
('00001' , '12345678901234'),
('00002' , '12345678901235'),
('00003' , '12345678901236');


INSERT INTO supermercadooferta(oferta, supermercado) values
('00001','12345678901235'),
('00001','12345678901236'),
('00002','12345678901235'),
('00003','12345678901235'),
('00004','12345678901235'),
('00005','12345678901235'),
('00006','12345678901235'),
('00007','12345678901235'),
('00008','12345678901235'),
('00009','12345678901235'),
('00010','12345678901235'),
('00011','12345678901235'),
('00012','12345678901235'),
('00013','12345678901235'),
('00014','12345678901235'),
('00002','12345678901236'),
('00003','12345678901236'),
('00004','12345678901236'),
('00005','12345678901236'),
('00006','12345678901236'),
('00007','12345678901236'),
('00008','12345678901236'),
('00009','12345678901236'),
('00010','12345678901236'),
('00011','12345678901236'),
('00012','12345678901236'),
('00013','12345678901236'),
('00014','12345678901236'),
('00002','12345678901234'),
('00003','12345678901234'),
('00004','12345678901234'),
('00005','12345678901234'),
('00006','12345678901234'),
('00007','12345678901234'),
('00008','12345678901234'),
('00009','12345678901234'),
('00010','12345678901234'),
('00011','12345678901234'),
('00012','12345678901234'),
('00013','12345678901234'),
('00014','12345678901234');


INSERT INTO folhetooferta (folheto, oferta) values
('00001','00001'),
('00001','00002'),
('00001','00003'),
('00001','00004'),
('00001','00005'),
('00001','00006'),
('00001','00007'),
('00001','00008'),
('00001','00009'),
('00001','00010'),
('00001','00011'),
('00001','00012'),
('00001','00013'),
('00001','00014');

