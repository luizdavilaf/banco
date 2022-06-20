

INSERT INTO funcionario(cpf_funcionario, nome_funcionario, cargo,salario_fixo)
VALUES ('12345678901','joao silva','vendedor', 2800.00);
INSERT INTO funcionario(cpf_funcionario, nome_funcionario, cargo,salario_fixo)
VALUES ('12345678950','Marcos Machado','vendedor',3700.00);
INSERT INTO funcionario(cpf_funcionario, nome_funcionario, cargo,salario_fixo)
VALUES ('12345678951','Antonio Pereira','vendedor',3700.00 );
INSERT INTO funcionario(cpf_funcionario, nome_funcionario, cargo, salario_fixo)
VALUES ('12345678952','Jose Perez','vendedor', 1700.00);
INSERT INTO funcionario(cpf_funcionario, nome_funcionario, cargo, salario_fixo)
VALUES ('12345678953','Tiburcio Souza','vendedor', 1700.00);
INSERT INTO funcionario(cpf_funcionario, nome_funcionario, cargo, salario_fixo)
VALUES ('34567890123','Pedro Silva','gerente', 4500.00);
 INSERT INTO funcionario(cpf_funcionario, nome_funcionario, cargo, salario_fixo)
VALUES ('12345678970','Marcelo Pires','gerente', 15000.00);


insert into cliente(cod_cliente,cpf_cliente,nome_cliente,nascimento,genero)
values('00001','23456789012','Maria Brasil','1990-01-01','F');
insert into cliente(cod_cliente,cpf_cliente,nome_cliente,nascimento,genero)
values('00002','23456789013','Carlos Tevez','2000-01-01','M');
insert into cliente(cod_cliente,cpf_cliente,nome_cliente,nascimento,genero)
values('00003','23456789014','Jose Silva','1980-01-01','M');
insert into cliente(cod_cliente,cpf_cliente,nome_cliente,nascimento,genero)
values('00004','23456789015','Romario das Neves','1999-01-01','M');
insert into cliente(cod_cliente,cpf_cliente,nome_cliente,nascimento,genero)
values('00005','23456789016','Marta Suplici','2001-01-01','F');

insert into dependente(cpf_dependente,nome_dependente,nascimento,cpf_funcionario)
values('12345678920','Marecelo Silva','06-06-2000','12345678901');
insert into dependente(cpf_dependente,nome_dependente,nascimento,cpf_funcionario)
values('12345678921','Betito Tads','13-04-1998','12345678950');
insert into dependente(cpf_dependente,nome_dependente,nascimento,cpf_funcionario)
values('12345678922','Cristian Paz','08-03-2001','12345678951');
insert into dependente(cpf_dependente,nome_dependente,nascimento,cpf_funcionario)
values('12345678923','Marecelo Pires','01-10-2010','12345678952');
insert into dependente(cpf_dependente,nome_dependente,nascimento,cpf_funcionario)
values('12345678924','Marina Santos','27-03-2005','12345678953');

insert into produto(cod_produto,descricao,preco,comissao)values
('00001','notebook ASUS',6500.00, 0.02),
('00002','SSD 240GB',500.00, 0.05),
('00003','mouse logitech',50.00, 0.0),
('00004','Teclado SONY',350.00, 0.05),
('00010','PRODUTO 10', 2.00, 0.0),
('00020','PRODUTO 20', 5.00, 0.02),
('00030','PRODUTO 30', 10.00, 0.05),
('00040','PRODUTO 40', 45.00, 0.10);

insert into venda(cod_venda, cpf_funcionario, data, cod_cliente, desconto_gerente)values
('50001','12345678901','2021-07-10', '00001',0.05),
('50002','12345678950','2021-06-10', '00002',0.07),
('50003','12345678951','2021-05-10', '00003',0.15),
('50004','12345678952','2021-04-10', '00004',0.18),
('50005','12345678953','2021-03-10', '00005',0.2),
insert into venda(cod_venda, cpf_funcionario, data, cod_cliente, desconto_gerente, gerente_que_autorizou)values
('90001','12345678951','2021-07-15', '00005',0.18,'Marcelo Pires');
insert into venda(cod_venda, cpf_funcionario, data, cod_cliente, desconto_gerente, gerente_que_autorizou)values
('90010','12345678953','2021-07-16', '00005',0.00,'Marcelo Pires')
 insert into venda(cod_venda, cpf_funcionario, data, cod_cliente, desconto_gerente, gerente_que_autorizou)values
('90011','12345678953','2021-03-16', '00005',0.00,'Marcelo Pires')
 insert into venda(cod_venda, cpf_funcionario, data, cod_cliente, desconto_gerente, gerente_que_autorizou)values
('90012','12345678953','2021-03-16', '00005',0.15,'Marcelo Pires')
insert into venda(cod_venda, cpf_funcionario, data, cod_cliente, desconto_gerente, gerente_que_autorizou)values
('90013','12345678953','2021-05-16', '00005',0.15,'Marcelo Pires')
insert into venda(cod_venda, cpf_funcionario, data, cod_cliente, desconto_gerente, gerente_que_autorizou)values
('90014','12345678953','2021-06-23', '00003',0.15,'Marcelo Pires')

insert into nota_fiscal(cod_nota_fiscal, item, descricao_produto,cod_produto,preco_unitario,quantidade,valor,cpf_funcionario,nome_funcionario,cod_cliente,cpf_cliente,nome_cliente,data,cod_venda)values
('10101','1','notebook ASUS','00001',6500.00, 1,6500.00,'12345678901','João Silva','00001','23456789012','Maria Brasil','2021-07-10','50001'),
('10101','2','SSD 240GB','00002',500.00, 3,1500.00,'12345678901','João Silva','00001','23456789012','Maria Brasil','2021-07-10','50001'),
('10102','1','notebook ASUS','00001',6500.00, 1,6500.00,'12345678950','Marcos Machado','00002','23456789013','Carlos Tevez','2021-06-10','50002'),
('10103','1','notebook ASUS','00001',6500.00, 1,6500.00,'12345678951','Antonio Pereira','00003','23456789014','Jose Silva','2021-05-10','50003'),
('10105','1','notebook ASUS','00001',6500.00, 1,6500.00,'12345678952','Jose Perez','00004','23456789015','Romario das Neves','2021-04-10','50004');
insert into nota_fiscal(cod_nota_fiscal, item, descricao_produto,cod_produto,preco_unitario,quantidade,valor,cpf_funcionario,nome_funcionario,cod_cliente,cpf_cliente,nome_cliente,data,cod_venda)values
('10006','1','mouse logitech','00003',50.00, 21,1050.00,'12345678953','Tiburcio Souza','00005','23456789016','Marta suplici','2021-07-16','90010');
insert into nota_fiscal(cod_nota_fiscal, item, descricao_produto,cod_produto,preco_unitario,quantidade,valor,cpf_funcionario,nome_funcionario,cod_cliente,cpf_cliente,nome_cliente,data,cod_venda)values
('10007','1','mouse logitech','00003',50.00, 23,1150.00,'12345678953','Tiburcio Souza','00005','23456789016','Marta suplici','2021-07-16','90011');
insert into nota_fiscal(cod_nota_fiscal, item, descricao_produto,cod_produto,preco_unitario,quantidade,valor,cpf_funcionario,nome_funcionario,cod_cliente,cpf_cliente,nome_cliente,data,cod_venda)values
('10008','1','ssd 240gb','00002',500.00, 5,2500.00,'12345678953','Tiburcio Souza','00005','23456789014','José Silva','2021-06-16','90012');
insert into nota_fiscal(cod_nota_fiscal, item, descricao_produto,cod_produto,preco_unitario,quantidade,valor,cpf_funcionario,nome_funcionario,cod_cliente,cpf_cliente,nome_cliente,data,cod_venda)values
('10009','1','ssd 240gb','00002',500.00, 3,1500.00,'12345678953','Tiburcio Souza','00005','23456789014','José Silva','2021-05-16','90013');
insert into nota_fiscal(cod_nota_fiscal, item, descricao_produto,cod_produto,preco_unitario,quantidade,valor,cpf_funcionario,nome_funcionario,cod_cliente,cpf_cliente,nome_cliente,data,cod_venda)values
('10010','1','ssd 240gb','00002',500.00, 3,1500.00,'12345678953','Tiburcio Souza','00003','23456789014','José Silva','2021-06-23','90014');
insert into nota_fiscal(cod_nota_fiscal, item, descricao_produto,cod_produto,preco_unitario,quantidade,valor,cpf_funcionario,nome_funcionario,cod_cliente,cpf_cliente,nome_cliente,data,cod_venda)values
('90001','1','notebook ASUS','00001',6500.00, 1,6500.00,'12345678951','Antonio Pereira','00005','23456789016','Marta suplici','2021-07-15','90001'),
('90001','2','SSD 240GB','00002',500.00, 3,1500.00,'12345678951','Antonio Pereira','00005','23456789016','Marta Suplici','2021-07-15','90001'),

insert into nota_fiscal(cod_nota_fiscal, item, descricao_produto,cod_produto,preco_unitario,quantidade,valor,cpf_funcionario,nome_funcionario,cod_cliente,cpf_cliente,nome_cliente,data,cod_venda)values
('15001','1','monitor del','00005',1500.00, 1,1500.00,'12345678953','tiburcio souza','00005','23456789016','Marta suplici','2021-03-10','50005'),

"50005"	"12345678953"	"2021-03-10 00:00:00"	"00005"	0.20	"pedro silva"




insert into produto_nota_fiscal(cod_produto,item, cod_nota_fiscal)values('00001','1','10101');
insert into produto_nota_fiscal(cod_produto,item, cod_nota_fiscal)values('00002','2','10101');
insert into produto_nota_fiscal(cod_produto,item, cod_nota_fiscal)values('00001','1','10102');
insert into produto_nota_fiscal(cod_produto,item, cod_nota_fiscal)values('00001','1','10103');
insert into produto_nota_fiscal(cod_produto,item, cod_nota_fiscal)values('00001','1','10105');

insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00001','12345678901','joao silva', 1, 3200.00 ,  '2021-02-01');
insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00002','12345678901','joao silva', 1, 3600.00 , '2021-03-01');
insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00003','12345678901','joao silva', 1, 2800.00 , '2021-04-01');
insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00004','12345678950','Marcos Machado', 1, 3800.00 ,  '2021-04-01');
insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00005','12345678950','Marcos Machado', 1, 3600.00 , '2021-05-01');
insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00006','12345678950','Marcos Machado', 1, 3700.00 , '2021-06-01');
insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00007','12345678951','Antonio Pereira', 1, 3700.00 , '2021-05-01');
insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00008','12345678951','Antonio Pereira', 1, 3700.00 ,  '2021-06-01');
insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00009','12345678951','Antonio Pereira', 1, 3700.00 , '2021-07-01');
insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00010','12345678952','Jose Perez', 1, 1700.00 ,  '2021-05-01');
insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00011','12345678952','Jose Perez', 1, 1700.00 , '2021-06-01');
insert into contra_cheque(cod_contra_cheque,cpf_funcionario,nome_funcionario,num_dependentes,salario_fixo,data)values('00012','12345678952','Jose Perez', 1, 1700.00 ,  '2021-07-01');