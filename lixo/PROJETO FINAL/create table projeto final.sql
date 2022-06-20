
drop table produto_nota_fiscal;
drop table nota_fiscal;
drop table venda;
drop table contra_cheque;
drop table dependente;
drop table produto;
drop table funcionario;
drop table cliente;


select * from produto_nota_fiscal;
select * from nota_fiscal;
select * from venda;
select * from contra_cheque;
select * from dependente;
select * from produto;
select * from funcionario;
select * from cliente;


create table cliente(
	cod_cliente char(5) primary key not null,
	cpf_cliente char(11),
	nome_cliente varchar(100),
	nascimento date not null check(current_date - nascimento >= 18),
	genero char(1) check (genero='M' or genero ='F')	
);

create table funcionario(
	cpf_funcionario char(11) primary key not null,
	nome_funcionario varchar(100) not null,
	cargo varchar(100) not null,
	salario_fixo numeric(12,2) check(salario_fixo > 0)

);

create table produto(
	cod_produto char(5) primary key not null,
	descricao varchar(100) not null,
	preco numeric(12,2) not null check(preco > 0), 
	comissao numeric(12,2) not null check((comissao >=0) and (comissao <=30))
	);


create table dependente(
	cpf_dependente char(11)primary key not null,
	nome_dependente varchar(100),
	nascimento date not null check(nascimento <= now()),
	cpf_funcionario char(11) not null,
	FOREIGN KEY(cpf_funcionario) REFERENCES funcionario(cpf_funcionario)
);

create table contra_cheque(
	cod_contra_cheque char(5) primary key not null,
	cpf_funcionario char(11) not null,
	nome_funcionario varchar(100) not null,
	num_dependentes int check(num_dependentes >= 0),
	salario_fixo numeric(12,2) not null check(salario_fixo > 0),
    data date not null check(data <= now()),    
	FOREIGN KEY(cpf_funcionario) REFERENCES funcionario(cpf_funcionario)
	--calcular
	--comissao numeric(12,2),
	--salario_bruto numeric(12,2) not null check(salario_bruto > 0),
	--inss numeric(12,2) not null,
	--irpf numeric(12,2),
	--salario_liquido numeric(12,2) not null
);
	--calcular
	--comissao numeric(12,2),
	--salario_bruto numeric(12,2) not null check(salario_bruto > 0),
	--inss numeric(12,2) not null,
	--irpf numeric(12,2),
	--salario_liquido numeric(12,2) not null
);

create table venda(
	cod_venda char(5) primary key not null,
	cpf_funcionario char(11) not null,
	FOREIGN KEY(cpf_funcionario) REFERENCES funcionario(cpf_funcionario),
	data timestamp check(data <= now()) default now(),
	--bonus tem que ser calculado
	cod_cliente char(5) not null,
	FOREIGN KEY(cod_cliente) REFERENCES cliente(cod_cliente),
	desconto_gerente numeric(3,2) not null check(desconto_gerente >= 0 and desconto_gerente <= 0.20),
	gerente_que_autorizou char(100)
);	
	

create table nota_fiscal(	
	item char(5) not null, 
	cod_nota_fiscal char(5) not null,
	descricao_produto varchar(100) not null,
	cod_produto char(5) not null,
	FOREIGN KEY(cod_produto) REFERENCES produto(cod_produto),
	preco_unitario numeric(12,2) not null check(preco_unitario > 0),
	quantidade int not null check(quantidade > 0) default 1,
	valor numeric(12,2) not null check(valor > 0),
	cpf_funcionario char(11) not null,
	FOREIGN KEY(cpf_funcionario) REFERENCES funcionario(cpf_funcionario),
	nome_funcionario varchar(100) not null,
	cod_cliente char(5) not null,
	cpf_cliente char(11),
	nome_cliente varchar(100),
	data timestamp check(data <= now()) not null,
	cod_venda char(5) not null,
	FOREIGN KEY(cod_venda) REFERENCES venda(cod_venda),
	primary key (item, cod_nota_fiscal) 
);
	
create table produto_nota_fiscal(
	cod_produto char(5) not null,
	FOREIGN KEY(cod_produto) REFERENCES produto(cod_produto),
	item char(5) not null,
	cod_nota_fiscal char(5) not null,
	FOREIGN KEY(item,cod_nota_fiscal) REFERENCES nota_fiscal(item,cod_nota_fiscal)
);	
	

	
	






