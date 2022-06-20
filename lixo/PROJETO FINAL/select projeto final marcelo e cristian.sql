
--3.1) Mostrar o total de vendas (valor da nota) por dia em um dado período de datas.

select sum(tmp2.valor) as total,
(select extract('day' from tmp2.dia)) as dia,
(select
	case extract(dow from tmp2.dia)
		when 0 then 'domingo'
		when 1 then 'segunda'
		when 2 then 'terca'
		when 3 then 'quarta'
		when 4 then 'quinta'
		when 5 then 'sexta'
		when 6 then 'sabado'
	end as dia_semana)
from
(select tmp1.valor as valor, tmp1.data as dia
from 
      (select nota_fiscal.cod_venda, nota_fiscal.data, nota_fiscal.cod_produto, 
       nota_fiscal.preco_unitario*quantidade as valor 
       from nota_fiscal) as tmp1
where tmp1.data > current_date - cast('6 months' as interval))as tmp2
group by 2,3;


--3.2) Mostrar o valor total autorizado em descontos por gerente por mês nos últimos 6 meses.

select 		
	   tmp3.gerente_que_autorizou, tmp3.mes, trunc(sum(tmp3.desconto_total),2) as total_desconto_gerente
from
		(select 
			   tmp2.gerente_que_autorizou, tmp2.mes as mes,sum(tmp2.valor_desconto_gerente) as desconto_total
		from 
		    (select tmp1.gerente_que_autorizou, 
					tmp1.desconto_gerente as valor_desconto_gerente, 
					tmp1.mes as mes
			from 
					(select nota_fiscal.cod_venda as venda, 
					    (select extract('month' from venda.data)) as mes,  nota_fiscal.cod_produto,
					     sum(nota_fiscal.valor*venda.desconto_gerente) as desconto_gerente,
					     venda.gerente_que_autorizou
					from nota_fiscal
						right join venda on nota_fiscal.cod_venda = venda.cod_venda
					    join funcionario on venda.cpf_funcionario = funcionario.cpf_funcionario
					where venda.data > current_date - cast('6 months' as interval)
					group by 1,2,3,5)as tmp1
			group by 1,2,3) as tmp2
		group by 1,2) as tmp3
group by 1,2;

--3.3) Mostrar os vendedores que venderam mais de $1.000,00 em produtos que não tem 
--comissão em um dado mês e ano.
 select tmp2.nome, tmp2.comissao,tmp2.mes, tmp2.ano
from
	(select f.nome_funcionario as nome, 
		 v.cpf_funcionario,
		(select extract('month' from v.data)) as mes,
 		(select extract('year' from v.data)) as ano,
 			sum(nf.quantidade *
 			nf.valor) as total_valor, 
 			nf.cod_produto as cod_produto, 
			 produto.comissao as comissao
		from funcionario as f
			join venda as v on f.cpf_funcionario = v.cpf_funcionario
			join nota_fiscal as nf on v.cod_venda = nf.cod_venda
			join produto on nf.cod_produto = produto.cod_produto
			where nf.quantidade *
 			nf.valor > 1000
			group by 1,2,3,4,6,7
) as tmp2
where tmp2.comissao not in
(select  
  produto.comissao
from produto
join produto_nota_fiscal on produto.cod_produto = produto_nota_fiscal.cod_produto
where comissao > '0');

--3.4) Mostrar o faturamento líquido quinzenal em um dado mês e ano.

(select tmp3.mes,tmp3.ano, sum(tmp3.valor_liquido) as liquido_por_quinzena_1ª_e_2ª ,
 (select case when tmp3.data >'2021-06-01' and tmp3.data < '2021-06-15' then '1ª quinzena'
else '2ª quinzena'
end) as quinzena--1ªquinzena
from
	(select tmp2.valor_liquido, tmp2.data as data, tmp2.mes as mes, tmp2.ano as ano
	from
	(select count(*),((nf.valor)-(nf.valor*v.desconto_gerente)-(nf.valor*pd.comissao)) as valor_liquido,
	 nf.data, 
	 extract('month' from nf.data) as mes,
	 extract('year' from nf.data) as ano, nf.cod_nota_fiscal
	from nota_fiscal nf
			inner join venda v on nf.cod_venda = v.cod_venda
			inner join produto_nota_fiscal pnf on nf.cod_produto = pnf.cod_produto
			inner join produto pd on pd.cod_produto = pnf.cod_produto
	WHERE nf.data between cast('2021-06-01' as date) AND cast('2021-06-15' as date)	
	group by 2,3,4,5,6
    order by 1 desc)as tmp2) as tmp3
group by 1,2,4)
union		   		   
(select tmp3.mes,tmp3.ano, sum(tmp3.valor_liquido) as segunda_quinzena ,
(select case when tmp3.data >'2021-06-01' and tmp3.data < '2021-06-15' then '1ª quinzena'
else '2ª quinzena'
end)as quinzena
from
		(select tmp2.valor_liquido, tmp2.data as data, tmp2.mes as mes, tmp2.ano as ano
		from
		(select count(*),((nf.valor)-(nf.valor*v.desconto_gerente)-(nf.valor*pd.comissao)) as valor_liquido,
		 nf.data, extract('month' from nf.data) as mes, extract('year' from nf.data) as ano, nf.cod_nota_fiscal
		 from nota_fiscal nf
				inner join venda v on nf.cod_venda = v.cod_venda
				inner join produto_nota_fiscal pnf on nf.cod_produto = pnf.cod_produto
				inner join produto pd on pd.cod_produto = pnf.cod_produto
		WHERE nf.data between cast('2021-06-16' as date) AND cast('2021-06-30' as date)
		group by 2,3,4,5,6
		order by 1 desc)as tmp2) as tmp3
group by 1,2,4
);


--3.5) Mostrar os clientes que realizaram mais de 1 compra em cada um dos 3 últimos meses.
select tmp.cpf,tmp.mes, tmp.qtde 
from
	((select distinct c.cpf_cliente as cpf,(select extract('month' from nf.data)) as mes,count(*) as qtde
	  from cliente as c
			join nota_fiscal as nf on c.cod_cliente = nf.cod_cliente
	  where (select extract('month' from nf.data)) = (select extract('month' from current_date)-1)
      group by 1,2
	  having count(*) > 1)-- as ultimo--as a);
union
	(select distinct c.cpf_cliente as cpf,(select extract('month' from nf.data)) as mes,count(*) as qtde
	from cliente as c
	join nota_fiscal as nf on c.cod_cliente = nf.cod_cliente
	where (select extract('month' from nf.data)) = (select extract('month' from current_date)-2)
	group by 1,2
	having count(*) > 1)-- as penultimo
union
	(select distinct c.cpf_cliente as cpf,(select extract('month' from nf.data)) as mes,count(*) as qtde
	from cliente as c
	join nota_fiscal as nf on c.cod_cliente = nf.cod_cliente
	where (select extract('month' from nf.data)) = (select extract('month' from current_date)-3)
	group by 1,2
	having count(*) > 1)) as tmp
order by 2;-- as antepenultimo

--3.6) Mostrar o ranking dos produtos mais vendidos por faixa etária e por gênero em um dado período de datas. 
--Considerar as faixas etárias 18-25, 26-35, 36-45, 46-55, 56-65, 66-75 e 76-.

select tmp2.faixa, tmp2.qtde, tmp2.genero, tmp2.produto 
from 
((select '18-25' as faixa, sum(tmp1.qtde) as qtde,tmp1.genero as genero,
tmp1.descricao_produto as produto
from 
	(select nota_fiscal.quantidade as qtde, age(cliente.nascimento) as idade, 
	cliente.nascimento as nascimento,cliente.genero as genero,nota_fiscal.descricao_produto
			from nota_fiscal join cliente on nota_fiscal.cod_cliente = cliente.cod_cliente 
			where nota_fiscal.data between '2021-05-01' and '2021-08-01') as tmp1 
where (current_date - tmp1.nascimento)/365 between 18 and 25
group by 1,3,4)

union

(select '26-35' as faixa, sum(tmp1.qtde) as qtde,tmp1.genero as genero,
tmp1.descricao_produto as produto
from (select nota_fiscal.quantidade as qtde, age(cliente.nascimento) as idade,
 cliente.nascimento as nascimento,cliente.genero as genero,nota_fiscal.descricao_produto
		from nota_fiscal join cliente on nota_fiscal.cod_cliente = cliente.cod_cliente 
		where nota_fiscal.data between '2021-05-01' and '2021-08-01') as tmp1 
where (current_date - tmp1.nascimento)/365 between 26 and 35
group by 1,3,4)

union

(select '36-45' as faixa, sum(tmp1.qtde) as qtde,tmp1.genero as genero,
tmp1.descricao_produto as produto
from (select nota_fiscal.quantidade as qtde, age(cliente.nascimento) as idade, cliente.nascimento as nascimento,cliente.genero as genero,nota_fiscal.descricao_produto
		from nota_fiscal join cliente on nota_fiscal.cod_cliente = cliente.cod_cliente 
		where nota_fiscal.data between '2021-05-01' and '2021-08-01') as tmp1 
where (current_date - tmp1.nascimento)/365 between 36 and 45
group by 1,3,4)

union

(select '46-55' as faixa, sum(tmp1.qtde) as qtde,tmp1.genero as genero,
tmp1.descricao_produto as produto
from (select nota_fiscal.quantidade as qtde, age(cliente.nascimento) as idade, cliente.nascimento as nascimento,cliente.genero as genero,nota_fiscal.descricao_produto
		from nota_fiscal join cliente on nota_fiscal.cod_cliente = cliente.cod_cliente 
		where nota_fiscal.data between '2021-05-01' and '2021-08-01') as tmp1 
where (current_date - tmp1.nascimento)/365 between 46 and 55
group by 1,3,4)

union
(select '56-65' as faixa, sum(tmp1.qtde) as qtde,tmp1.genero as genero,
tmp1.descricao_produto as produto
from (select nota_fiscal.quantidade as qtde, age(cliente.nascimento) as idade, cliente.nascimento as nascimento,cliente.genero as genero,nota_fiscal.descricao_produto
		from nota_fiscal join cliente on nota_fiscal.cod_cliente = cliente.cod_cliente 
		where nota_fiscal.data between '2021-05-01' and '2021-08-01') as tmp1 
where (current_date - tmp1.nascimento)/365 between 56 and 65
group by 1,3,4)

union

(select '66-75' as faixa, sum(tmp1.qtde) as qtde,tmp1.genero as genero,
tmp1.descricao_produto as produto
from (select nota_fiscal.quantidade as qtde, age(cliente.nascimento) as idade, cliente.nascimento as nascimento,cliente.genero as genero,nota_fiscal.descricao_produto
		from nota_fiscal join cliente on nota_fiscal.cod_cliente = cliente.cod_cliente 
		where nota_fiscal.data between '2021-05-01' and '2021-08-01') as tmp1 
where (current_date - tmp1.nascimento)/365 between 66 and 75
group by 1,3,4)

union
(select '76-' as faixa,
 sum(tmp1.qtde) as qtde,
 tmp1.genero as genero,
 tmp1.descricao_produto  as produto
from 
	(select nota_fiscal.quantidade as qtde, 
		age(cliente.nascimento) as idade, 
		cliente.nascimento as nascimento,
		cliente.genero as genero,nota_fiscal.descricao_produto
	from nota_fiscal 
	join cliente on nota_fiscal.cod_cliente = cliente.cod_cliente 
	where nota_fiscal.data between '2021-05-01' and '2021-08-01') as tmp1 
where (current_date - tmp1.nascimento)/365 >= 76 group by 1,3,4)order by 2 desc)as tmp2;

--3.7) Mostrar o total em vendas (valor da nota) por faixa etária e por gênero dos clientes em um dado período 
--de datas. Considerar as faixas etárias 18-25, 26-35, 36-45, 46-55, 56-65, 66-75 e 76-.

select sum(tmp2.valor_nota) as valor_nota,
tmp2.genero,
( select 
		 case when tmp2.idade >=18 and tmp2.idade <= 25 then '18-25'
			  when tmp2.idade >=26 and tmp2.idade <= 35 then '26-35'
			  when tmp2.idade >=36 and tmp2.idade <= 45 then '36-45'
			  when tmp2.idade >=46 and tmp2.idade <= 55 then '46-55'
			  when tmp2.idade >=56 and tmp2.idade <= 65 then '56-65'
			  when tmp2.idade >=66 and tmp2.idade <= 75 then '66-75'
			  when tmp2.idade >=76 then '76-'
			end faixa) as faixa_etaria
from 
	(select ((nota_fiscal.quantidade * nota_fiscal.preco_unitario)-((nota_fiscal.quantidade * nota_fiscal.preco_unitario) * venda.desconto_gerente)) as valor_nota , nota_fiscal.descricao_produto as produto, cliente.genero as genero, (current_date - cliente.nascimento)/365 as idade,count(*)
	from nota_fiscal
		join produto on nota_fiscal.cod_produto = produto.cod_produto
		join cliente on nota_fiscal.cod_cliente = cliente.cod_cliente
		join venda on cliente.cod_cliente = venda.cod_cliente
	where nota_fiscal.data > current_date - cast('6 months' as interval)
	group by 1,2,3,4
	order by 1 desc) as tmp2
group by 2,3;

--3.8) Mostrar as 5 vendas de maior valor (valor da nota) em um dado período de datas.
select  tmp.valor_nota as valor_nota, tmp.nf 
from 
	(select sum((nota_fiscal.valor)-((nota_fiscal.valor) * venda.desconto_gerente)) as valor_nota, nota_fiscal.cod_nota_fiscal as nf
	from nota_fiscal
		join venda on nota_fiscal.cod_venda = venda.cod_venda
	where nota_fiscal.data between '2021-02-01' and '2021-07-01'
	group by 2 order by 1 desc) as tmp
where tmp.valor_nota in
	(select distinct a.valor_nota 
	from 
		(select  SUM((nota_fiscal.valor)-((nota_fiscal.valor) * venda.desconto_gerente)) as valor_nota, nota_fiscal.						cod_nota_fiscal  as nf
		from nota_fiscal
			inner join venda on nota_fiscal.cod_venda = venda.cod_venda
			where nota_fiscal.data between '2021-02-01' and '2021-07-01'
			group by 2		
			order by 1 desc)as a order by 1 desc limit 5);

--3.9) Mostrar os vendedores que venderam (valor da nota) mais no penúltimo mês do que no último mês.

select b.nome_funcionario as penultimo_mes, b.nf as valor_vendido--, c.nome_funcionario as ultimo_mes, c.nf as valor_vendido
from 
	(select max(a.nota) as nf, a.nome_funcionario from 
		(select nome_funcionario, sum(nota_fiscal.valor - (nota_fiscal.valor *venda.desconto_gerente))as nota
		from nota_fiscal
			join venda on nota_fiscal.cod_venda = venda.cod_venda
		where extract('month' from nota_fiscal.data) = extract('month' from current_date)-2 
		group by 1)as a group by 2) as b
left join 
	(select max(a.nota) as nf, a.nome_funcionario from 
		(select nome_funcionario, sum(nota_fiscal.valor - (nota_fiscal.valor * venda.desconto_gerente))as nota
		from nota_fiscal
			join venda on nota_fiscal.cod_venda = venda.cod_venda
		where extract('month' from nota_fiscal.data) = extract('month' from current_date)-1 
		group by 1)as a group by 2) as c 
		on b.nome_funcionario = c.nome_funcionario
		and b.nf > c.nf;
			
--3.10) Mostrar os vendedores por faixa de vendas (valor da nota) nos últimos 3 meses. 
--Considerar as faixas de venda
---$999,99, $1.000,00-$4.999,99, $5.000,00-$9.999,99, $10.000,00-$49.999,99, $50.000,00-$99.999,99 e $100.000,00-.

select tmp2.nome,
( select 
		 case when tmp2.valor_nota <= 999.99   then '-$999.99'
			  when tmp2.valor_nota <= 4999.99  then '$1000.00-$4999.99'
			  when tmp2.valor_nota <= 9999.99  then '$5000.00-$9999.99'
			  when tmp2.valor_nota <= 49999.99 then '$10000.00-$49999.99'
			  when tmp2.valor_nota <= 99999.99 then '$50000.00-$99999.99'
			  when tmp2.valor_nota > 100000.00 then '$100000.00-'
			  end faixa) as faixa_venda
from 
	(select sum((nota_fiscal.valor)-((nota_fiscal.valor) * venda.desconto_gerente)) as valor_nota ,nome_funcionario as nome
	from nota_fiscal
		join produto on nota_fiscal.cod_produto = produto.cod_produto
		join cliente on nota_fiscal.cod_cliente = cliente.cod_cliente
		join venda on cliente.cod_cliente = venda.cod_cliente
	where nota_fiscal.data > current_date - cast('3 months' as interval)
	group by 2
	order by 1 desc) as tmp2
group by 1,2 order by 2 desc;

--3.11) Mostrar um valor sugerido de desconto para uma dada venda, com base na quantidade de compras do cliente 
--nos 6 meses anteriores. Considerar 0,00% de desconto para 0-2 compras, 5,00% para 3-5 compras, 10,00% para 6-10
 --compras e 15% para 10- compras.
 
 select tmp3.cpf,
( select 
		 case when tmp3.compras >= 0 and tmp3.compras <= 2  then '0.00%'
			  when tmp3.compras >= 3 and tmp3.compras <= 5	then '5.00%'
			  when tmp3.compras >= 6 and tmp3.compras <= 10 then '10%'
			  when tmp3.compras > 10 then '15%'
			  end faixa) as sugestao_desconto
from 
	(select count(*) as compras, tmp2.cpf as cpf
	from
	(select nota_fiscal.cod_nota_fiscal as nf,nota_fiscal.data, cliente.cpf_cliente as cpf,
	 count(*)
	from nota_fiscal
		join produto on nota_fiscal.cod_produto = produto.cod_produto
		join cliente on nota_fiscal.cod_cliente = cliente.cod_cliente
		join venda on cliente.cod_cliente = venda.cod_cliente
	where nota_fiscal.data > current_date - cast('6 months' as interval)
	group by 1,2,3) as tmp2
    group by 2 order by 1 desc) as tmp3;


--3.12) Mostrar o contracheque dos vendedores em um dado mês e ano.

select temp4.cpf as funcionario, temp4.dependentes as dependentes, temp4.salario as fixo,
temp4.comissao as comissao, temp4.bruto as bruto, temp4.inss as inss, temp4.irrf as irrf, 
(temp4.bruto - temp4.inss - temp4.irrf)::decimal(10,2) as liquido
from
	(select *, 
		(case
			when temp3.salario_base <= 1903.98 then (temp3.salario_base*0)::decimal(10,2)
			when temp3.salario_base <= 2826.65 then ((temp3.salario_base*0.075)-142.80)::decimal(10,2)
			when temp3.salario_base <= 3751.05 then ((temp3.salario_base*0.15)-354.80)::decimal(10,2)
			when temp3.salario_base <= 4664.68 then ((temp3.salario_base*0.225)-636.13)::decimal(10,2)
			when temp3.salario_base >  4664.68 then ((temp3.salario_base*0.275)-869.36)::decimal(10,2) end) as irrf
	from			
		(select *,(temp2.bruto - temp2.inss - (temp2.dependentes*189.59))::decimal(10,2) as salario_base
			from 
				(select temp1.cpf, temp1.dependentes, temp1.salario, temp1.comissao, temp1.bruto,
					case
						when temp1.bruto <= 1693.72 then (temp1.bruto*8/100)::decimal(10,2)
						when temp1.bruto <= 2822.90 then (temp1.bruto*9/100)::decimal(10,2)
						when temp1.bruto <= 5645.80 then (temp1.bruto*11/100)::decimal(10,2)
						when temp1.bruto <= 5645.80 then (5645.80*11/100)::decimal(10,2) 
						end as inss
				from
					(select funcionario.cpf_funcionario cpf,count(dependente.cpf_funcionario) dependentes, funcionario.salario_fixo salario,
						sum(nota_fiscal.quantidade*produto.preco*produto.comissao/100)::decimal(10,2) as comissao,
						(sum(nota_fiscal.quantidade*produto.preco*produto.comissao/100) + funcionario.salario_fixo)::decimal(10,2) as bruto
					 from nota_fiscal
						join produto on produto.cod_produto = nota_fiscal.cod_produto
						join venda on nota_fiscal.cod_venda = venda.cod_venda
						join funcionario on funcionario.cpf_funcionario = venda.cpf_funcionario
						join dependente on funcionario.cpf_funcionario = dependente.cpf_funcionario
					where venda.data between '2021-06-01' and '2021-06-30'
group by 1,3 order by 1) as temp1)
 		as temp2) 
 	as temp3) as temp4;

--3.13) Mostrar o lucro líquido obtido em um dado mês e ano. Considerar o lucro líquido de 
--um mês como sendo o somatório do valor das notas naquele mês subtraído dos gastos em 
--contracheque de vendedores naquele mês.
select 
(select sum(tmp2.valor_nota) from
(select (tmp1.nf - tmp1.nf*tmp1.desconto) as valor_nota
from
(select sum(nota_fiscal.valor) as nf, nota_fiscal.data, venda.desconto_gerente as desconto
from nota_fiscal
join venda on nota_fiscal.cod_venda = venda.cod_venda
where nota_fiscal.data between '2021-06-01' and '2021-06-30'
group by 2,3) as tmp1) as tmp2) as total_notas,
(select sum(tmp5.liquido) from
(select temp4.bruto as bruto, temp4.inss as inss, temp4.irrf as irrf, 
	(temp4.bruto - temp4.inss - temp4.irrf)::decimal(10,2) as liquido
from
	(select *, 
		(case
			when temp3.salario_base <= 1903.98 then (temp3.salario_base*0)::decimal(10,2)
			when temp3.salario_base <= 2826.65 then ((temp3.salario_base*0.075)-142.80)::decimal(10,2)
			when temp3.salario_base <= 3751.05 then ((temp3.salario_base*0.15)-354.80)::decimal(10,2)
			when temp3.salario_base <= 4664.68 then ((temp3.salario_base*0.225)-636.13)::decimal(10,2)
			when temp3.salario_base >  4664.68 then ((temp3.salario_base*0.275)-869.36)::decimal(10,2) end) as irrf
	from			
		(select *,(temp2.bruto - temp2.inss - (temp2.dependentes*189.59))::decimal(10,2) as salario_base
			from 
				(select temp1.cpf, temp1.dependentes, temp1.salario, temp1.comissao, temp1.bruto,
					case
						when temp1.bruto <= 1693.72 then (temp1.bruto*8/100)::decimal(10,2)
						when temp1.bruto <= 2822.90 then (temp1.bruto*9/100)::decimal(10,2)
						when temp1.bruto <= 5645.80 then (temp1.bruto*11/100)::decimal(10,2)
						when temp1.bruto <= 5645.80 then (5645.80*11/100)::decimal(10,2) 
						end as inss
				from
					(select funcionario.cpf_funcionario cpf,count(dependente.cpf_funcionario) dependentes, funcionario.salario_fixo salario,
						sum(nota_fiscal.quantidade*produto.preco*produto.comissao/100)::decimal(10,2) as comissao,
						(sum(nota_fiscal.quantidade*produto.preco*produto.comissao/100) + funcionario.salario_fixo)::decimal(10,2) as bruto
					from nota_fiscal
						join produto on produto.cod_produto = nota_fiscal.cod_produto
						join venda on nota_fiscal.cod_venda = venda.cod_venda
						join funcionario on funcionario.cpf_funcionario = venda.cpf_funcionario
						join dependente on funcionario.cpf_funcionario = dependente.cpf_funcionario
					where venda.data between '2021-06-01' and '2021-06-30'
group by 1,3 order by 1) as temp1)
 		as temp2) 
 	as temp3) as temp4) as tmp5) as total_contra_cheque, (select (select sum(tmp2.valor_nota) from
(select (tmp1.nf - tmp1.nf*tmp1.desconto) as valor_nota
from
(select sum(nota_fiscal.valor) as nf, nota_fiscal.data, venda.desconto_gerente as desconto
from nota_fiscal
join venda on nota_fiscal.cod_venda = venda.cod_venda
where nota_fiscal.data between '2021-06-01' and '2021-06-30'
group by 2,3) as tmp1) as tmp2) - (select sum(tmp5.liquido) from
(select temp4.bruto as bruto, temp4.inss as inss, temp4.irrf as irrf, 
	(temp4.bruto - temp4.inss - temp4.irrf)::decimal(10,2) as liquido
from
	(select *, 
		(case
			when temp3.salario_base <= 1903.98 then (temp3.salario_base*0)::decimal(10,2)
			when temp3.salario_base <= 2826.65 then ((temp3.salario_base*0.075)-142.80)::decimal(10,2)
			when temp3.salario_base <= 3751.05 then ((temp3.salario_base*0.15)-354.80)::decimal(10,2)
			when temp3.salario_base <= 4664.68 then ((temp3.salario_base*0.225)-636.13)::decimal(10,2)
			when temp3.salario_base >  4664.68 then ((temp3.salario_base*0.275)-869.36)::decimal(10,2) end) as irrf
	from			
		(select *,(temp2.bruto - temp2.inss - (temp2.dependentes*189.59))::decimal(10,2) as salario_base
			from 
				(select temp1.cpf, temp1.dependentes, temp1.salario, temp1.comissao, temp1.bruto,
					case
						when temp1.bruto <= 1693.72 then (temp1.bruto*8/100)::decimal(10,2)
						when temp1.bruto <= 2822.90 then (temp1.bruto*9/100)::decimal(10,2)
						when temp1.bruto <= 5645.80 then (temp1.bruto*11/100)::decimal(10,2)
						when temp1.bruto <= 5645.80 then (5645.80*11/100)::decimal(10,2) 
						end as inss
				from
					(select funcionario.cpf_funcionario cpf,count(dependente.cpf_funcionario) dependentes, funcionario.salario_fixo salario,
						sum(nota_fiscal.quantidade*produto.preco*produto.comissao/100)::decimal(10,2) as comissao,
						(sum(nota_fiscal.quantidade*produto.preco*produto.comissao/100) + funcionario.salario_fixo)::decimal(10,2) as bruto
					from nota_fiscal
						join produto on produto.cod_produto = nota_fiscal.cod_produto
						join venda on nota_fiscal.cod_venda = venda.cod_venda
						join funcionario on funcionario.cpf_funcionario = venda.cpf_funcionario
						join dependente on funcionario.cpf_funcionario = dependente.cpf_funcionario
					where venda.data between '2021-06-01' and '2021-06-30'
group by 1,3 order by 1) as temp1)
 		as temp2) 
 	as temp3) as temp4) as tmp5)) as lucro_liquido;

--3.14) Mostrar o gráfico do lucro líquido por mês para um dado ano conforme o exemplo. 
--Considerar cada * proporcional à quantidade de dígitos na parte inteira do maior lucro
--líquido mensal naquele ano. Se o maior lucro líquido possuir 1 dígitos na parte inteira,
--cada * equivale a $1; 2 dígitos, a $10; 3 dígitos, a $100; e assim por diante.

 --mes       | lucro     | grafico
-----------+-----------+---------
 --janeiro   | $4.351,13 | ****
-- fevereiro | $3.278,20 | ***
 --marco     | $6.703,88 | ******
--...
--log10(1000)
--log10(10000)
--log(100)
--log(999)
--Rafael Betito19:53
--1+log10(n)
--length(cast(cast(n as integer) as text))


select 
		case
		when mes=1 then '01-janeiro' 
		when mes=2 then '02-fevereiro' 
		when mes=3 then '03-março' 
		when mes=4 then '04-abril' 
		when mes=5 then '05-maio' 
		when mes=6 then '06-junho' 
		when mes=7 then '07-julho' 
		when mes=8 then '08-agosto' 
		when mes=9 then '09-setembro' 
		when mes=10 then '10-outubro' 
		when mes=11 then '11-novembro' 
		when mes=12 then '12-dezembro' 
		else 'mes'
		end as mes, ano, lucro_liquido

,repeat('*',cast(substring(cast(abs(lucro_liquido) as text),1,cast((length(cast(cast(abs(lucro_liquido) as integer) as text))-qtde_caracteres)+1 as integer))
as integer)) 
from 
(select mes, ano, lucro_liquido, 
1+(select min(qtde_inteira) 
from (select mes, ano, lucro_liquido, floor(log10(abs(lucro_liquido))) as qtde_inteira from
(select mes, ano, sum(valor_nota) as valor_nota, sum(contra_cheque) as contra_cheque, sum(valor_nota) - sum(contra_cheque) as lucro_liquido
from 
(select *
from 
(select tmp1.mes, tmp1.ano, 0 as contra_cheque, sum(tmp1.nf - tmp1.nf*tmp1.desconto) as valor_nota
from
		(select sum(nota_fiscal.valor) as nf, nota_fiscal.data, venda.desconto_gerente as desconto,
		  nota_fiscal.data,extract('month' from nota_fiscal.data) as mes, 
		extract('year' from nota_fiscal.data) as ano
		from nota_fiscal
		join venda on nota_fiscal.cod_venda = venda.cod_venda
		where nota_fiscal.data between '2021-01-01' and '2021-12-31'
		group by 2,3,4,5) as tmp1
group by 1,2) as tmp50
union

select *
from

(select temp4.mes, temp4.ano, sum(temp4.bruto - temp4.inss - temp4.irrf)::decimal(10,2) as contra_cheque,0 as valor_nota
				from
					(select *, 
						(case
							when temp3.salario_base <= 1903.98 then (temp3.salario_base*0)::decimal(10,2)
							when temp3.salario_base <= 2826.65 then ((temp3.salario_base*0.075)-142.80)::decimal(10,2)
							when temp3.salario_base <= 3751.05 then ((temp3.salario_base*0.15)-354.80)::decimal(10,2)
							when temp3.salario_base <= 4664.68 then ((temp3.salario_base*0.225)-636.13)::decimal(10,2)
							when temp3.salario_base >  4664.68 then ((temp3.salario_base*0.275)-869.36)::decimal(10,2) end) as irrf	      
					from			
						(select *,(temp2.bruto - temp2.inss - (temp2.dependentes*189.59))::decimal(10,2) as salario_base
							from 
								(select temp1.cpf, temp1.dependentes, temp1.salario, temp1.comissao, temp1.bruto,
									case
										when temp1.bruto <= 1693.72 then (temp1.bruto*8/100)::decimal(10,2)
										when temp1.bruto <= 2822.90 then (temp1.bruto*9/100)::decimal(10,2)
										when temp1.bruto <= 5645.80 then (temp1.bruto*11/100)::decimal(10,2)
										when temp1.bruto <= 5645.80 then (5645.80*11/100)::decimal(10,2) 
										end as inss, temp1.mes, temp1.ano
								from
									(select funcionario.cpf_funcionario cpf,count(dependente.cpf_funcionario) dependentes, funcionario.salario_fixo salario,
										sum(nota_fiscal.quantidade*produto.preco*produto.comissao/100)::decimal(10,2) as comissao,
										(sum(nota_fiscal.quantidade*produto.preco*produto.comissao/100) + funcionario.salario_fixo)::decimal(10,2) as bruto,
									 venda.data,extract('month' from venda.data) as mes, extract('year' from venda.data) as ano
									 from nota_fiscal
										join produto on produto.cod_produto = nota_fiscal.cod_produto
										join venda on nota_fiscal.cod_venda = venda.cod_venda
										join funcionario on funcionario.cpf_funcionario = venda.cpf_funcionario
										join dependente on funcionario.cpf_funcionario = dependente.cpf_funcionario
									where venda.data between '2021-01-01' and '2021-12-31'
									group by 1,3,6,7 order by 1) as temp1)
						as temp2) 
					as temp3) as temp4
group by 1,2) as tmp60) as tmp61			
group by 1,2) as tmp62) as tmp63) as qtde_caracteres
from 
(select mes, ano, lucro_liquido, floor(log10(abs(lucro_liquido))) as qtde_inteira ,repeat('*',cast(floor(log10(abs(lucro_liquido))) as integer)) 
from
(select mes, ano, sum(valor_nota) as valor_nota, sum(contra_cheque) as contra_cheque, sum(valor_nota) - sum(contra_cheque) as lucro_liquido
from 
(select *
from 
(select tmp1.mes, tmp1.ano, 0 as contra_cheque, sum(tmp1.nf - tmp1.nf*tmp1.desconto) as valor_nota
from
		(select sum(nota_fiscal.valor) as nf, nota_fiscal.data, venda.desconto_gerente as desconto,
		  nota_fiscal.data,extract('month' from nota_fiscal.data) as mes, 
		extract('year' from nota_fiscal.data) as ano
		from nota_fiscal
		join venda on nota_fiscal.cod_venda = venda.cod_venda
		where nota_fiscal.data between '2021-01-01' and '2021-12-31'
		group by 2,3,4,5) as tmp1
group by 1,2) as tmp50
union
select *
from
(select temp4.mes, temp4.ano, sum(temp4.bruto - temp4.inss - temp4.irrf)::decimal(10,2) as contra_cheque,0 as valor_nota
				from
					(select *, 
						(case
							when temp3.salario_base <= 1903.98 then (temp3.salario_base*0)::decimal(10,2)
							when temp3.salario_base <= 2826.65 then ((temp3.salario_base*0.075)-142.80)::decimal(10,2)
							when temp3.salario_base <= 3751.05 then ((temp3.salario_base*0.15)-354.80)::decimal(10,2)
							when temp3.salario_base <= 4664.68 then ((temp3.salario_base*0.225)-636.13)::decimal(10,2)
							when temp3.salario_base >  4664.68 then ((temp3.salario_base*0.275)-869.36)::decimal(10,2) end) as irrf	      
					from			
						(select *,(temp2.bruto - temp2.inss - (temp2.dependentes*189.59))::decimal(10,2) as salario_base
							from 
								(select temp1.cpf, temp1.dependentes, temp1.salario, temp1.comissao, temp1.bruto,
									case
										when temp1.bruto <= 1693.72 then (temp1.bruto*8/100)::decimal(10,2)
										when temp1.bruto <= 2822.90 then (temp1.bruto*9/100)::decimal(10,2)
										when temp1.bruto <= 5645.80 then (temp1.bruto*11/100)::decimal(10,2)
										when temp1.bruto <= 5645.80 then (5645.80*11/100)::decimal(10,2) 
										end as inss, temp1.mes, temp1.ano
								from
									(select funcionario.cpf_funcionario cpf,count(dependente.cpf_funcionario) dependentes, funcionario.salario_fixo salario,
										sum(nota_fiscal.quantidade*produto.preco*produto.comissao/100)::decimal(10,2) as comissao,
										(sum(nota_fiscal.quantidade*produto.preco*produto.comissao/100) + funcionario.salario_fixo)::decimal(10,2) as bruto,
									 venda.data,extract('month' from venda.data) as mes, extract('year' from venda.data) as ano
									 from nota_fiscal
										join produto on produto.cod_produto = nota_fiscal.cod_produto
										join venda on nota_fiscal.cod_venda = venda.cod_venda
										join funcionario on funcionario.cpf_funcionario = venda.cpf_funcionario
										join dependente on funcionario.cpf_funcionario = dependente.cpf_funcionario
									where venda.data between '2021-01-01' and '2021-12-31'
									group by 1,3,6,7 order by 1) as temp1)
						as temp2) 
					as temp3) as temp4
group by 1,2) as tmp60) as tmp61			
group by 1,2) as tmp62) as tmp63
group by 1,2,3) as tmp64
order by 1;


--3.15) Reajustar em 3,50% o salário fixo dos vendedores que venderam mais de $10.000,00
--(valor da nota) em cada um dos últimos 3 meses.

update funcionario
set salario_fixo = salario_fixo * 1.035
where cpf_funcionario = (select tmp3.cpf from
(select tmp2.cpf,count(tmp2.cpf)
from
	(select tmp1.cpf as cpf, tmp1.valor_nota as valor_nota, tmp1.mes as mes
	from 
		((select  venda.cpf_funcionario as cpf,(extract('month' from nota_fiscal.data)) as mes,sum(nota_fiscal.valor - (nota_fiscal.valor * venda.desconto_gerente))as valor_nota
		from nota_fiscal
		join venda on nota_fiscal.cod_venda = venda.cod_venda
		where extract('month' from nota_fiscal.data) = extract('month' from now())-1
		group by 1,2
		having sum(nota_fiscal.valor - (nota_fiscal.valor * venda.desconto_gerente)) > 10000)

		union

		(select  venda.cpf_funcionario as cpf,(extract('month' from nota_fiscal.data)) as mes,sum(nota_fiscal.valor - (nota_fiscal.valor * venda.desconto_gerente))as valor_nota
		from nota_fiscal
		join venda on nota_fiscal.cod_venda = venda.cod_venda
		where extract('month' from nota_fiscal.data) = extract('month' from now())-2
		group by 1,2
		having sum(nota_fiscal.valor - (nota_fiscal.valor * venda.desconto_gerente)) > 10000)

		union

		(select  venda.cpf_funcionario as cpf,(extract('month' from nota_fiscal.data)) as mes,sum(nota_fiscal.valor - (nota_fiscal.valor * venda.desconto_gerente))as valor_nota
		from nota_fiscal
		join venda on nota_fiscal.cod_venda = venda.cod_venda
		where extract('month' from nota_fiscal.data) = extract('month' from now())-3
		group by 1,2
		having sum(nota_fiscal.valor - (nota_fiscal.valor * venda.desconto_gerente)) > 10000)
		) as tmp1
	order by 3) as tmp2
group by 1
having count(*) >= 3) as tmp3);

4) Explique porque:

4.1) Não é possível excluir um vendedor demitido.

-- Não é possível porque causaria problemas de integridade referencial, precisamos das 
-- informações do vendedor, como totais de vendas, notas fiscais e etc..., caso o SGBD permitisse a exclusão dos 
-- dados referente ao vendedor, não teriamos informações do vendedor que efetuou a venda ou pior,
-- poderia ocorrer de uma venda atribuida a um outro vendedor.


4.2) É necessário ter um campo preço na tabela produto e outro na tabela item da venda em uma modelagem bem feita.

--É necessário ter um campo preço na tabela produto, porque o preço apresentado na tabela produto, indica um valor sem desconto que 
--por ventura poderá ocorrer por parte da gerência de cada loja. Contudo na nossa modelagem o campo item esta na tabela 
--nota fiscal, existe um campo preço na tabela nota fiscal onde reflete o 
--valor do produto com todos os descontos que foram atribuidos a ele.

