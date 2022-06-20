drop table lancamento;
drop table chequeespecial;
drop table clienteconta;
drop table contacorrente;
drop table parcela;
drop table emprestimo;
drop table seguro;
drop table poupanca;
drop table investimento;
drop table comprafatura;
drop table fatura;
drop table compracartao;
drop table cartaodecredito;
drop table cliente;
drop table produto;
drop table agencia;
drop table banco;



CREATE TABLE banco(
    nome VARCHAR (100) NOT NULL,  
    codigobanco CHAR (5) NOT NULL,    
    PRIMARY KEY (codigobanco)
);

CREATE TABLE agencia(
    codigoagencia VARCHAR (5) NOT NULL,  
    cidade CHAR (40) NOT NULL, 
    estado CHAR (2) NOT NULL,
    banco CHAR (5) NOT NULL,   
    PRIMARY KEY (codigoagencia),
    FOREIGN KEY (banco) REFERENCES banco (codigobanco)
);

CREATE TABLE produto(
    codproduto VARCHAR (5) NOT NULL,  
    nomeproduto VARCHAR (50) NOT NULL,
    banco CHAR (5) NOT NULL, 
    taxaadesao REAL ,             
    PRIMARY KEY (codproduto),
    FOREIGN KEY (banco) REFERENCES banco (codigobanco)
);

CREATE TABLE cliente(
    documento VARCHAR (14) NOT NULL,  
    nome VARCHAR (100) NOT NULL,
    datacadastro TIMESTAMP,
    cidade CHAR (40) NOT NULL,
    endereco VARCHAR (150) NOT NULL,
    estado  VARCHAR (2) NOT NULL, 
    agencia VARCHAR (5) NOT NULL,
    datadesligamento TIMESTAMP,
    rendamensal REAL,
        
    PRIMARY KEY (documento),
    FOREIGN KEY (agencia) REFERENCES agencia (codigoagencia)
);

CREATE TABLE cartaodecredito(
    bandeira VARCHAR (10) NOT NULL,  
    numerocartao VARCHAR (16) NOT NULL,  
    datavencimento integer,
    cliente VARCHAR (14) NOT NULL, 
    contrato VARCHAR (14),
    limite REAL,
    datacontratacao TIMESTAMP,
    validade DATE,
    datafechamento integer,             
    PRIMARY KEY (numerocartao),
    FOREIGN KEY (cliente) REFERENCES cliente (documento)
);

CREATE TABLE compracartao(
    codcompra VARCHAR (6) NOT NULL,  
    datacompra TIMESTAMP NOT NULL,
    valor REAL ,
    descricao VARCHAR (500),
    numparcelas integer,
    cartaodecredito VARCHAR (16) NOT NULL,                  
    PRIMARY KEY (codcompra),
    FOREIGN KEY (cartaodecredito) REFERENCES cartaodecredito (numerocartao) 
);

CREATE TABLE fatura(     
    codigofatura integer NOT NULL, 
    datavencimento DATE NOT NULL,
    valor REAL ,    
    datapagamento DATE,
    cartaodecredito VARCHAR (16) NOT NULL,  
    parcela integer NOT NULL,        
    codcompra VARCHAR (6) NOT NULL, 
    FOREIGN KEY (codcompra) REFERENCES compracartao (codcompra),
    FOREIGN KEY (cartaodecredito) REFERENCES cartaodecredito (numerocartao)  ,
    PRIMARY KEY (codigofatura)
);

CREATE TABLE comprafatura(
    
   codcompra VARCHAR (6) NOT NULL, 
   codigofatura integer NOT NULL,
   FOREIGN KEY (codigofatura) REFERENCES fatura (codigofatura),
   FOREIGN KEY (codcompra) REFERENCES compracartao (codcompra),    
   PRIMARY KEY (codcompra, codigofatura )
);

CREATE TABLE  investimento(      
    codinvestimento VARCHAR (6) NOT NULL,
    tipoinvestimento VARCHAR (500),
    datacontratacao TIMESTAMP NOT NULL,
    cliente VARCHAR (14) NOT NULL, 
    dataencerramento TIMESTAMP,                     
    PRIMARY KEY (codinvestimento),
    FOREIGN KEY (cliente) REFERENCES cliente (documento)
);
CREATE TABLE  poupanca(    
    codigolanc VARCHAR (10) NOT NULL,
    datalancamento TIMESTAMP,  
    valor REAL,   
    codinvestimento VARCHAR (6) NOT NULL, 
    descricao VARCHAR (100) ,
    agencia VARCHAR (5) NOT NULL,          
    PRIMARY KEY (codigolanc) ,
    FOREIGN KEY (agencia) REFERENCES agencia (codigoagencia),
    FOREIGN KEY (codinvestimento) REFERENCES investimento (codinvestimento)    
);



CREATE TABLE  seguro(      
    codseguro VARCHAR (6) NOT NULL,
    tiposeguro VARCHAR (500),
    valorseg REAL,
    datacontratacao TIMESTAMP NOT NULL,
    cliente VARCHAR (14) NOT NULL, 
    vigencia TIMESTAMP,                     
    PRIMARY KEY (codseguro),
    FOREIGN KEY (cliente) REFERENCES cliente (documento)  
);

CREATE TABLE  emprestimo(      
    codigoemp VARCHAR (5) NOT NULL,
    numerodeparcelas integer,
    valortotal REAL,
    datacontratacao TIMESTAMP NOT NULL,
    cliente VARCHAR (14) NOT NULL, 
    tipoemprestimo VARCHAR (500),  
    agencia VARCHAR (5) NOT NULL,                 
    PRIMARY KEY (codigoemp),
    FOREIGN KEY (cliente) REFERENCES cliente (documento),  
    FOREIGN KEY (agencia) REFERENCES agencia (codigoagencia)
);

CREATE TABLE  parcela(      
    emprestimo VARCHAR (5) NOT NULL,
    numeparcela integer NOT NULL,
    valorparcela REAL,
    vencimento DATE NOT NULL,
    datapagamento DATE,
    datacontratacao TIMESTAMP NOT NULL,
    agencia VARCHAR (5) NOT NULL,    
    FOREIGN KEY (emprestimo) REFERENCES emprestimo (codigoemp)  ,
    FOREIGN KEY (agencia) REFERENCES agencia (codigoagencia)  ,
    
    PRIMARY KEY (numeparcela, emprestimo)


    
);

CREATE TABLE  contacorrente(      
    codconta VARCHAR (7) NOT NULL,
    agencia VARCHAR (5) NOT NULL, 
    cliente VARCHAR (14) NOT NULL, 
    dataaberturacc TIMESTAMP,
    datafechamento TIMESTAMP,
    contrato VARCHAR (14),    
    PRIMARY KEY (codconta),
    FOREIGN KEY (agencia) REFERENCES agencia (codigoagencia),  
    FOREIGN KEY (cliente) REFERENCES cliente (documento) 
);

CREATE TABLE  clienteconta(      
    contacorrente VARCHAR (7) NOT NULL,    
    cliente VARCHAR (14) NOT NULL,        
    PRIMARY KEY (contacorrente, cliente),
    FOREIGN KEY (contacorrente) REFERENCES contacorrente (codconta),  
    FOREIGN KEY (cliente) REFERENCES cliente (documento) 
);

CREATE TABLE  chequeespecial(      
    contacorrente VARCHAR (7) NOT NULL, 
    datalancamento TIMESTAMP,   
    limite REAL,         
    PRIMARY KEY (contacorrente) ,
    FOREIGN KEY (contacorrente) REFERENCES contacorrente (codconta)    
);

CREATE TABLE  lancamento(    
    codigolanc VARCHAR (10) NOT NULL,
    datalancamento TIMESTAMP,  
    valor REAL,   
    contacorrente VARCHAR (7) NOT NULL, 
    descricao VARCHAR (100) ,          
    PRIMARY KEY (codigolanc) ,
    FOREIGN KEY (contacorrente) REFERENCES contacorrente (codconta)    
);

INSERT INTO banco (nome, codigobanco) values
('DinheirAll','00001');

INSERT INTO agencia (codigoagencia, cidade, estado, banco) values
('124-4',	'São Paulo',	'SP',	'00001'),
('124-5',	'Jundiaí',	'SP',	'00001'),
('124-6',	'Campinas',	'SP',	'00001'),
('123-2',	'Pelotas',	'RS',	'00001'),
('123-4',	'Rio Grande',	'RS',	'00001');

INSERT INTO produto (codproduto, nomeproduto, banco, taxaadesao) values
('00001','conta corrente','00001',40.00),
('00002','cheque especial','00001',20.00),
('00003','empréstimo','00001',35.00),
('00004','seguro','00001',NULL),
('00005','investimento','00001',NULL),
('00006','cartão de crédito','00001',20.00);

INSERT INTO cliente (nome, documento, datacadastro, cidade, endereco, estado, agencia, datadesligamento, rendamensal) values
('Alberto da Silva',	'12345678902',	'2020-08-01 10:30:00',	'Rio Grande'	,'Rua ABC, 999,Centro, CEP 96200-000'	,'RS',	'123-4'	,NULL,	2500.00),
('Fulano da Silva',	'12345678901',	'2020-08-01 10:30:00',	'Rio Grande'	,'Rua ABC, 999,Centro, CEP 96200-000'	,'RS',	'123-4'	,NULL,	2500.00);

INSERT INTO cartaodecredito (bandeira, numerocartao, datavencimento, cliente, contrato, limite, datacontratacao, validade, datafechamento) values
('VISA'	,'1234123412341234',	10,	'12345678901'	,'12357-123/2020',	5000.00	,'2020-08-05 11:05:00'	,'01/09/2024',	30);

INSERT INTO compracartao(codcompra, datacompra, valor, descricao, numparcelas, cartaodecredito) values
('000055','2020-08-13 18:30:00',2500.00,'NaveNet Informática',4,'1234123412341234'),
('000056','2020-09-06 16:10:00',500,'Ferragem Casa Mais',2,'1234123412341234');

INSERT INTO fatura (datavencimento, cartaodecredito, datapagamento, valor, parcela,codcompra,codigofatura) values
('2020/09/10','1234123412341234','2020/09/10',880.00,1,'000055',1),
('2020/10/10','1234123412341234', NULL ,880.00,2,'000055',2),
('2020/11/10','1234123412341234',NULL,880.00,3,'000055',3),
('2020/12/10','1234123412341234',NULL,880.00,4,'000055',4),
('2020/10/10','1234123412341234',NULL,250.00,1,'000056',5),
('2020/11/10','1234123412341234', NULL ,250.00,2,'000056',6);


INSERT INTO comprafatura (codigofatura, codcompra ) values
(1,'000055'),
(5,'000056');
 

INSERT INTO emprestimo (codigoemp,valortotal,numerodeparcelas,datacontratacao,tipoemprestimo,cliente, agencia) values
('00001',1000.00,12,'2020-09-09 11:00:00','emprestimo pessoal','12345678901','123-4'),
('00002',1000.00,12,'2020-10-09 11:00:00','emprestimo pessoal','12345678901','123-4'),
('00003',1000.00,12,'2021-01-09 11:00:00','emprestimo pessoal','12345678901','123-4'),
('00004',1000.00,12,'2021-02-09 11:00:00','emprestimo pessoal','12345678901','123-4'),
('00005',1000.00,12,'2021-03-09 11:00:00','emprestimo pessoal','12345678901','123-4'),
('00006',1000.00,12,'2021-03-09 11:00:00','emprestimo pessoal','12345678901','123-4');

INSERT INTO parcela (numeparcela,valorparcela,vencimento,emprestimo,datapagamento, datacontratacao, agencia) values
(1,95.00,'2020-10-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(2,95.00,'2020-11-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(3,95.00,'2020-12-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(4,95.00,'2021-01-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(5,95.00,'2021-02-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(6,95.00,'2021-03-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(7,95.00,'2021-04-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(8,95.00,'2021-05-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(9,95.00,'2021-06-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(10,95.00,'2021-07-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(11,95.00,'2021-08-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(12,95.00,'2021-09-03','00001',NULL, '2020-09-09 11:00:00','123-4'),
(1,100.00,'2020-11-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(2,100.00,'2020-12-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(3,100.00,'2021-01-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(4,100.00,'2021-02-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(5,100.00,'2021-03-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(6,100.00,'2021-04-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(7,100.00,'2021-05-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(8,100.00,'2021-06-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(9,100.00,'2021-07-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(10,100.00,'2021-08-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(11,100.00,'2021-09-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(12,100.00,'2021-10-03','00002',NULL, '2020-10-09 11:00:00','123-4'),
(1,105.00,'2021-02-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(2,105.00,'2021-03-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(3,105.00,'2021-04-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(4,105.00,'2021-05-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(5,105.00,'2021-06-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(6,105.00,'2021-07-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(7,105.00,'2021-08-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(8,105.00,'2021-09-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(9,105.00,'2021-10-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(10,105.00,'2021-11-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(11,105.00,'2021-12-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(12,105.00,'2022-01-03','00003',NULL, '2021-01-09 11:00:00','123-4'),
(1,400.00,'2021-03-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(2,400.00,'2021-04-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(3,400.00,'2021-05-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(4,400.00,'2021-06-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(5,400.00,'2021-07-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(6,400.00,'2021-08-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(7,400.00,'2021-09-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(8,400.00,'2021-10-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(9,400.00,'2021-11-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(10,400.00,'2021-12-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(11,400.00,'2022-01-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(12,400.00,'2022-02-03','00004',NULL, '2021-02-09 11:00:00','123-4'),
(1,200.00,'2021-04-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(2,200.00,'2021-05-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(3,200.00,'2021-06-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(4,200.00,'2021-07-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(5,200.00,'2021-08-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(6,200.00,'2021-09-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(7,200.00,'2021-10-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(8,200.00,'2021-11-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(9,200.00,'2021-12-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(10,200.00,'2022-01-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(11,200.00,'2022-02-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(12,200.00,'2022-03-03','00005',NULL, '2021-03-09 11:00:00','123-4'),
(1,450.00,'2021-04-03','00006',NULL, '2021-03-09 11:00:00','123-4'),
(2,450.00,'2021-05-03','00006',NULL, '2021-03-09 11:00:00','123-4'),
(3,450.00,'2021-06-03','00006',NULL, '2021-03-09 11:00:00','123-4'),
(4,450.00,'2021-07-03','00006',NULL, '2021-03-09 11:00:00','123-4'),
(5,450.00,'2021-08-03','00006',NULL, '2021-03-09 11:00:00','123-4'),
(6,450.00,'2021-09-03','00006',NULL, '2021-03-09 11:00:00','123-4'),
(7,450.00,'2021-10-03','00006',NULL, '2021-03-09 11:00:00','123-4'),
(8,450.00,'2021-11-03','00006',NULL, '2021-03-09 11:00:00','123-4'),
(9,450.00,'2021-12-03','00006',NULL, '2021-03-09 11:00:00','123-4'),
(10,450.00,'2022-01-03','00006',NULL, '2021-03-09 11:00:00','123-4'),
(11,450.00,'2022-02-03','00006',NULL, '2021-03-09 11:00:00','123-4'),
(12,450.00,'2022-03-03','00006',NULL, '2021-03-09 11:00:00','123-4');

INSERT INTO contacorrente (codconta,agencia,cliente,dataaberturacc,datafechamento,contrato) values
('12341-1','123-4','12345678902','2020-09-01 10:30:00',NULL,'12345-123/2020'),
('12361-1','123-4','12345678902','2021-09-01 10:30:00',NULL,'12345-123/2020'),
('12342-2','123-4','12345678901','2020-09-01 10:30:00','2020-10-01 10:30:00','12345-123/2020'),
('12345-6','123-4','12345678901','2020-08-01 10:30:00',NULL,'12345-123/2020');

INSERT INTO clienteconta (contacorrente,cliente) values
('12345-6','12345678901');

INSERT INTO chequeespecial (contacorrente,datalancamento,limite) values
('12345-6','2020-08-05 11:00:00',1000.00);

INSERT INTO lancamento (codigolanc,datalancamento,valor,contacorrente,descricao) values
('1234567891','2020-08-01 10:35:00',100.00,'12345-6','depósito'),
('1234567892','2020-08-02 10:30:00',-40.00,'12345-6','taxa de adesão ao contrato 12345-123/2020'),
('1234567893','2020-08-05 11:10:00',-20.00,'12345-6','taxa de adesão ao contrato 12356-123/2020'),
('1234567894','2020-08-05 11:15:00',-20.00,'12345-6','taxa de adesão ao contrato 12357-123/2020'),
('1234567896','2020-08-15 13:50:00',-35.00,'12345-6','Padaria Bom Pão'),
('1234567895','2020-08-20 14:50:00',-375.00,'12345-6','Mercado Tem Tudo'),
('1234567897','2020-08-23 17:00:00',-480.00,'12345-6','saque no terminal de autoatendimento'),
('1234567898','2020-08-24 14:10:00',1000.00,'12345-6','depósito'),
('1234567899','2020-09-03 10:00:00',-250.00,'12345-6','pagamento energia elétrica'),
('1234567810','2020-09-03 10:05:00',-90.00,'12345-6','pagamento água e esgoto'),
('1234567811','2020-09-05 10:30:00',-150.00,'12345-6','pagamento internet'),
('1234567812','2020-09-09 11:05:00',1000.00,'12345-6','emprestimo pessoal'),
('1236667812','2021-09-09 11:05:00',1000.00,'12345-6','emprestimo pessoal'),
('1234567813','2020-09-09 11:05:00',-35.00,'12345-6','taxa de adesão ao contrato 12365-123/2020'),
('1234567814','2020-09-10 11:10:00',-880.00,'12345-6','pagamento cartão');










