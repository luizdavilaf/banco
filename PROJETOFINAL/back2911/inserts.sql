INSERT INTO clientes(cpfcliente,nome,data_nascimento,genero) values
('41597400201','Rafael Neves Melo','1980-12-20','F'),
('49914766802','Maria Brito Pereira','1946-03-29','M'),
('66066056403','Isadora Brito Airez','1993-12-16','F'),
('06764228904','RaFael Brasil Brito','1966-06-23','M'),
('12922909805','Pedro Brasil Brasil','1967-07-31','M'),
('06328386506','Pedro Silva Silva','1964-03-13','M'),
('49336575907','Maicon Melo Silva','1994-03-19','F');


INSERT INTO vendedores(cpf,nome,salario,qtd_dependentes) values
('40836022408','Rafael Neves Brasil',2000,1),
('54605716609','Gabryel Pereira Pinho',1500,2),
('76444408910','Isadora Pinho Oliveira',4000,0),
('21310038311','Isadora Brasil Brito',1500,1),
('63740753912','Maicon Brasil Silva',2000,0);



INSERT INTO nota_fiscal(numeronf,cliente,cpf_vendedor,desconto,nome_gerente,data) values
('1','41597400201','40836022408',0.10,'Roberto Silva','2021-02-02 18:00:00'),
('2','49914766802','40836022408',0.15,'Roberto Silva','2021-02-03 09:00:00'),
('3','66066056403','40836022408',0.18,'Roberto Silva','2021-02-03 18:00:00'),
('4','06764228904','40836022408',NULL,NULL,'2021-02-04 09:00:00'),
('5','41597400201','40836022408',NULL,NULL,'2021-04-05 18:00:00'),
('6','41597400201','40836022408',NULL,NULL,'2021-04-06 09:00:00'),
('7','41597400201','40836022408',NULL,NULL,'2021-05-06 18:00:00'),
('8','41597400201','76444408910',NULL,NULL,'2021-06-07 09:00:00'),
('9','41597400201','76444408910',NULL,NULL,'2021-07-07 18:00:00'),
('10','66066056403','63740753912',NULL,NULL,'2021-08-01 09:00:00'),
('11','66066056403','63740753912',0.05,'Roberto Silva','2021-08-02 18:00:00'),
('12','06764228904','63740753912',0.02,'Roberto Silva','2021-09-03 09:00:00'),
('13','06764228904','63740753912',0.02,'Daniel Carlos','2021-09-03 18:00:00'),
('14','66066056403','76444408910',NULL,NULL,'2021-09-02 18:00:00'),
('15','66066056403','76444408910',NULL,NULL,'2021-09-02 18:00:00'),
('16','41597400201','40836022408',NULL,NULL,'2021-09-02 18:00:00'),
('17','41597400201','54605716609',NULL,NULL,'2021-09-02 18:00:00'),
('18','41597400201','76444408910',NULL,NULL,'2021-09-02 18:00:00'),
('19','41597400201','21310038311',NULL,NULL,'2021-09-02 18:00:00'),
('20','41597400201','63740753912',NULL,NULL,'2021-09-02 18:00:00'),
('21','41597400201','40836022408',NULL,NULL,'2021-09-02 18:00:00'),
('22','49914766802','54605716609',NULL,NULL,'2021-09-02 18:00:00'),
('23','49914766802','76444408910',NULL,NULL,'2021-09-02 18:00:00'),
('24','49914766802','21310038311',NULL,NULL,'2021-09-02 18:00:00'),
('25','49336575907','63740753912',NULL,NULL,'2021-10-02 18:00:00'),
('26','49336575907','40836022408',NULL,NULL,'2021-10-03 18:00:00'),
('27','49336575907','54605716609',NULL,NULL,'2021-10-04 18:00:00'),
('28','49914766802','76444408910',NULL,NULL,'2021-10-05 18:00:00'),
('29','49914766802','21310038311',NULL,NULL,'2021-10-06 18:00:00'),
('30','12922909805','63740753912',NULL,NULL,'2021-10-07 18:00:00'),
('31','12922909805','40836022408',NULL,NULL,'2021-10-07 18:00:00'),
('32','NULL','54605716609',NULL,NULL,'2021-10-07 18:00:00'),
('33','NULL','76444408910',NULL,NULL,'2021-10-07 18:00:00'),
('34','NULL','21310038311',NULL,NULL,'2021-10-07 18:00:00'),
('35','NULL','63740753912',NULL,NULL,'2021-10-07 18:00:00');


INSERT INTO produto(codigo_produto,nome,descricao,preco,comissao) values
('0000033801','Máquina de solda inversora',NULL,10.00,0.02),
('0000002402','Kit para unhas em gel',NULL,20.00,0.05),
('0000078403','Boneca Reborn original',NULL,15.00,0.05),
('0000028004','Capa de chuva para motoqueiro',NULL,8.00,0.02),
('0000068005','Tênis Olympikus feminino',NULL,5.00,0.02),
('0000059606','Churrasqueira tijolinho',NULL,4.00,0.02),
('0000033707','Capacho',NULL,10.00,0.02),
('0000089708','Samsung A01',NULL,20.00,0.02),
('0000092909','Mousepad gamer',NULL,25.00,0.02),
('0000059810','Placa de vídeo 4GB',NULL,10000.00,0.00),
('0000049111','Caneta 3D',NULL,100.00,0.05),
('0000081112','Chevette',NULL,600.00,0.05);

INSERT INTO contracheque(data_ref,vendedor,salario) values
('2021-08-01','40836022408',2000.00),
('2021-08-01','54605716609',1500.00),
('2021-08-01','76444408910',4000.00),
('2021-08-01','21310038311',1500.00),
('2021-08-01','63740753912',2000.00),
('2021-09-01','40836022408',2000.00),
('2021-09-01','54605716609',1500.00),
('2021-09-01','76444408910',4000.00),
('2021-09-01','21310038311',1500.00),
('2021-09-01','63740753912',2000.00);


INSERT INTO item(codigo_item,nota_fiscal,codigo_produto,quantidade,precoun) values
('1','1','0000033801',3,10.00),
('2','1','0000081112',1,600.00),
('3','1','0000049111',1,100.00),
('1','2','0000002402',1,20.00),
('1','3','0000078403',1,15.00),
('1','4','0000028004',1,8.00),
('2','4','0000092909',1,25.00),
('3','4','0000002402',1,20.00),
('1','5','0000068005',1,5.00),
('2','5','0000078403',1,15.00),
('3','5','0000033801',1,10.00),
('4','5','0000049111',1,100.00),
('5','5','0000068005',1,5.00),
('6','5','0000078403',1,15.00),
('7','5','0000059810',1,10000.00),
('1','6','0000059606',1,4.00),
('2','6','0000068005',1,5.00),
('1','7','0000033707',1,10.00),
('2','7','0000033801',1,10.00),
('3','7','0000028004',1,8.00),
('1','8','0000033801',1,10.00),
('1','9','0000002402',1,20.00),
('2','9','0000059810',1,10000.00),
('1','10','0000059810',1,10000.00),
('2','10','0000059810',10,10.00),
('3','10','0000033707',1,10.00),
('1','11','0000028004',1,8.00),
('2','11','0000089708',1,20.00),
('1','12','0000068005',1,5.00),
('2','12','0000059810',1,10000.00),
('1','13','0000059606',1,4.00),
('2','13','0000033707',1,10.00),
('1','14','0000033801',1,10),
('1','15','0000002402',2,20),
('1','16','0000078403',3,15),
('1','17','0000028004',4,8),
('1','18','0000068005',4,5),
('1','19','0000059606',1,4),
('1','20','0000033707',30,10),
('1','21','0000089708',3,20),
('1','22','0000092909',4,25),
('1','23','0000059810',4,10000),
('1','24','0000049111',1,100),
('1','25','0000081112',2,600),
('1','26','0000033801',3,10),
('1','27','0000002402',4,20),
('1','28','0000078403',4,15),
('1','29','0000028004',1,8),
('1','30','0000068005',2,5),
('1','31','0000059606',3,4),
('1','32','0000033707',4,10),
('1','33','0000089708',4,20),
('1','34','0000092909',1,25),
('1','35','0000059810',1,10000);
