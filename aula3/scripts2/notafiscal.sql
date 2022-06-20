drop table item;
drop table produto;
drop table notafiscal;
drop table operador;
drop table cliente;
drop table empresa;

create table empresa (
	cnpj char(14) not null, -- check (ehcnpjvalido(cnpj)),
	nome varchar(100) not null,
	endereco varchar(100) not null,
	primary key (cnpj)
);

insert into empresa (cnpj, nome, endereco) values
	('12123123123412', 'EMPRESA XYZ SA', 'R. ABC, 123 - RIO GRANDE - RS');

create table cliente (
	cpfcnpj char(14) not null, -- check (ehcnpjvalido(cpfcnpj) or ehcpfvalido(substr(cpfcnpj, 1, 11)),
	nome varchar(100) not null,
	endereco varchar(100) not null,
	primary key (cpfcnpj)
);

insert into cliente (cpfcnpj, nome, endereco) values
	('12312312312   ', 'FULANO DA SILVA', 'R. DEF, 123 - RIO GRANDE - RS');

create table operador (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);

insert into operador (codigo, nome) values
	(456, 'BELTRANO BRASIL');

create table notafiscal (
	nserie char(6) not null,
	quando timestamp not null default current_timestamp check (quando <= current_timestamp),
	empresa char(14) not null,
	cliente char(14), -- -O| PODE SER NULL!
	operador integer not null,
	foreign key (empresa) references empresa(cnpj),
	foreign key (cliente) references cliente(cpfcnpj),
	foreign key (operador) references operador(codigo),
	primary key (nserie)
);

insert into notafiscal (nserie, empresa, cliente, operador) values
	('12345A', '12123123123412', '12312312312   ', 456);

create table produto (
	codigo integer not null,
	descricao varchar(100) not null,
	unidade varchar(3) not null,
	preco real not null check (preco > 0),
	imposto real not null check (imposto >= 0),
	primary key (codigo)
);

insert into produto (codigo, descricao, unidade, preco, imposto) values
	(12345, 'COCA COLA 2L', 'UN', 5.50, 13.00),
	(67890, 'MORTADELA', 'KG', 20.00, 11.00),
	(24680, 'PAO FRANCES', 'KG', 9.90, 7.00);

create table item (
	nsequencial integer not null,
	notafiscal char(6) not null,
	produto integer not null,
	quantidade real not null default 1 check (quantidade > 0),
	foreign key (notafiscal) references notafiscal(nserie),
	foreign key (produto) references produto(codigo),
	primary key (nsequencial, notafiscal)
);

insert into item (nsequencial, notafiscal, produto, quantidade) values
	(1, '12345A', 12345, 2),
	(2, '12345A', 67890, 0.150),
	(3, '12345A', 24680, 0.330);

