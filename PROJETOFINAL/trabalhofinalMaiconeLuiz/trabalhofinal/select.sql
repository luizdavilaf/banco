3) Escreva uma instrução SQL para responder cada pergunta:

3.1) Mostrar o total de vendas (valor da nota) por dia em um dado período de datas.
select tabelatemp.data, to_char(sum(tabelatemp.totalitem),'$999g999g999d99') as valor_nota
from
(
    select nota_fiscal.numeronf as NF, cast(nota_fiscal.data as date) as data, item.quantidade, item.precoun, 
    (item.quantidade*item.precoun*(1-(nota_fiscal.desconto))) as totalitem
        from nota_fiscal
        join item on item.nota_fiscal = nota_fiscal.numeronf
    where nota_fiscal.data between cast('2021-09-01' as date) and cast('2021-09-30' as date)
) as tabelatemp
group by 1
order by 1;

3.2) Mostrar o valor total autorizado em descontos por gerente por mês nos últimos 6 meses.
select 
(
    case tabelafinal.data
		when 1 then 'Janeiro'
		when 2 then 'Fevereiro'
		when 3 then 'Marco'
		when 4 then 'Abril'
		when 5 then 'Maio'
		when 6 then 'Junho'
		when 7 then 'Julho'
		when 8 then 'Agosto'
		when 9 then 'Setembro'
		when 10 then 'Outubro'
		when 11 then 'Novembro'
		when 12 then 'Dezembro'
    end
) as data,
tabelafinal.gerente, to_char(tabelafinal.desconto,'$999g999g999d99') as desconto
    from
    (   select tabela2.data as data,    
        tabela2.gerente as gerente, sum(tabela2.valor_nota*tabela2.desconto) as desconto
        from
        (
            select tabelatemp.data as data, sum(tabelatemp.totalitem) as valor_nota, tabelatemp.gerente as gerente, tabelatemp.desconto as desconto
            from
            (
                select nota_fiscal.numeronf as NF, extract(month from nota_fiscal.data) as data, item.quantidade, item.precoun, (item.quantidade*item.precoun) as totalitem, 
                nota_fiscal.nome_gerente as gerente, nota_fiscal.desconto as desconto
                from nota_fiscal
                join item on item.nota_fiscal = nota_fiscal.numeronf
                where nota_fiscal.data between (NOW() - interval '6 MONTH') AND NOW()
                and nota_fiscal.nome_gerente is not null
            ) as tabelatemp
            group by 1,3,4
            order by 1
        )as tabela2
        group by 1,2
        order by 2,1
    ) as tabelafinal;

3.3) Mostrar os vendedores que venderam mais de $1.000,00 em produtos que não tem comissão em um dado mês e ano. --sem considerar desconto
select  tabelatemp.vendedor--,sum(tabelatemp.totalitem) as total_vendedor
from
(
    select  (item.quantidade*item.precoun) as totalitem, vendedores.nome as vendedor
        from nota_fiscal
        join item on item.nota_fiscal = nota_fiscal.numeronf
        join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor  
    where item.comissao = 0
    and nota_fiscal.data BETWEEN cast('2021-07-01' as date) AND cast('2021-07-31' as date)
) as tabelatemp
group by 1
having sum(tabelatemp.totalitem)>1000;   
     
3.4) Mostrar o faturamento líquido quinzenal em um dado mês e ano.
select to_char(sum(tmp1.total),'$999g999g999d99') as total_primeira_quinzena, to_char(tmp3.total ,'$999g999g999d99') as total_segunda_quinzena
	from 
		(select
		(item.precoun * item.quantidade) - --faturamento total
        ((nota_fiscal.desconto ) * sum(item.precoun * item.quantidade)) -- desconto(valordanota)
			- ((item.comissao ) * (item.precoun * item.quantidade)) as total -- comissao
            from nota_fiscal
            join item on item.nota_fiscal = nota_fiscal.numeronf               
		where nota_fiscal.data between cast('2021-09-01' as date) and cast('2021-09-15' as date)
		group by item.precoun, item.quantidade, nota_fiscal.desconto, item.comissao) as tmp1
		 ,
(select sum (tmp2.total) as total from
	(select
		((item.precoun * item.quantidade) - --faturamento
        ((nota_fiscal.desconto ) * sum(item.precoun * item.quantidade))) --desconto
			- ((item.comissao ) * (item.precoun * item.quantidade)) as total --comissao
            from nota_fiscal
            join item on item.nota_fiscal = nota_fiscal.numeronf              
		where nota_fiscal.data between cast('2021-09-16' as date) and cast('2021-09-30' as date)
		group by item.precoun, item.quantidade, nota_fiscal.desconto, item.comissao) as tmp2) as tmp3
group by 2;


3.5) Mostrar os clientes que realizaram mais de 1 compra em cada um dos 3 últimos meses.
select ultimos3meses.cliente
from
(
    --ultimo mes
    (
        select ultimomes.cliente
        from
        (
            select clientes.nome as cliente, count(numeronf) as quantidade , extract(month from nota_fiscal.data) as mes
                from nota_fiscal
                join clientes on clientes.cpfcliente = nota_fiscal.cliente
            where nota_fiscal.cliente is not null
            and extract(month from nota_fiscal.data) = (extract(month from current_date)-1)
            and extract(year from nota_fiscal.data) = extract(year from current_date)
            group by 1,3
            having count(numeronf) > 1
        ) as ultimomes
    )
    intersect--segundo mes
    (
        select penultimomes.cliente
        from
        (
            select clientes.nome as cliente, count(numeronf) as quantidade , extract(month from nota_fiscal.data) as mes
                from nota_fiscal
                join clientes on clientes.cpfcliente = nota_fiscal.cliente
            where nota_fiscal.cliente is not null
            and extract(month from nota_fiscal.data) = (extract(month from current_date)-2)
            and extract(year from nota_fiscal.data) = extract(year from current_date)
            group by 1,3
            having count(numeronf) > 1
        ) as penultimomes
    )
    intersect--terceiro mes
    (
        select antepenultimomes.cliente
        from
        (
            select clientes.nome as cliente, count(numeronf) as quantidade , extract(month from nota_fiscal.data) as mes
                from nota_fiscal
                join clientes on clientes.cpfcliente = nota_fiscal.cliente
            where nota_fiscal.cliente is not null
            and extract(month from nota_fiscal.data) = (extract(month from current_date)-3)
            and extract(year from nota_fiscal.data) = extract(year from current_date)
            group by 1,3
            having count(numeronf) > 1
        ) as antepenultimomes
    )
) as ultimos3meses;

3.6) Mostrar o ranking dos produtos mais vendidos por faixa etária e por gênero em um dado período de datas. Considerar as faixas etárias 18-25, 26-35, 36-45, 46-55, 56-65, 66-75 e 76-.
select sum(item.quantidade) as quantidade, produto.nome as produto,  
    case
        when extract(year from age(clientes.data_nascimento)) between 18 and 25 then '18-25'
        when extract(year from age(clientes.data_nascimento)) between 26 and 35 then '26-35'
        when extract(year from age(clientes.data_nascimento)) between 36 and 45 then '36-45'
        when extract(year from age(clientes.data_nascimento)) between 46 and 55 then '46-55'
        when extract(year from age(clientes.data_nascimento)) between 56 and 65 then '56-65'
        when extract(year from age(clientes.data_nascimento)) between 66 and 75 then '66-75'
        when extract(year from age(clientes.data_nascimento)) > 75 then '76+'
    end as faixa_etaria,
clientes.genero as genero
        from nota_fiscal
        join item on item.nota_fiscal = nota_fiscal.numeronf 
        join clientes on clientes.cpfcliente = nota_fiscal.cliente  
        join produto on produto.codigo_produto=item.codigo_produto
    where nota_fiscal.data BETWEEN cast('2021-09-01' as date) AND cast('2021-09-30' as date)
	group by 2,3,4
order by 1 desc;


3.7) Mostrar o total em vendas (valor da nota) por faixa etária e por gênero dos clientes em um dado período de datas. 
Considerar as faixas etárias 18-25, 26-35, 36-45, 46-55, 56-65, 66-75 e 76-.
select to_char(sum(tabelatemp.totalitem),'$999g999g999d99')  as total_vendas, tabelatemp.faixa_etaria, tabelatemp.genero
from
(
    select (item.quantidade*item.precoun*(1-(nota_fiscal.desconto))) as totalitem,     
    nota_fiscal.numeronf as NF,
        case
            when extract(year from age(clientes.data_nascimento)) between 18 and 25 then '18-25'
            when extract(year from age(clientes.data_nascimento)) between 26 and 35 then '26-35'
            when extract(year from age(clientes.data_nascimento)) between 36 and 45 then '36-45'
            when extract(year from age(clientes.data_nascimento)) between 46 and 55 then '46-55'
            when extract(year from age(clientes.data_nascimento)) between 56 and 65 then '56-65'
            when extract(year from age(clientes.data_nascimento)) between 66 and 75 then '66-75'
            when extract(year from age(clientes.data_nascimento)) > 75 then '75+'
        end as faixa_etaria,
        clientes.genero as genero
            from nota_fiscal
            join item on item.nota_fiscal = nota_fiscal.numeronf
            join clientes on clientes.cpfcliente = nota_fiscal.cliente
        where nota_fiscal.data between cast('2021-09-01' as date) and cast('2021-09-30' as date)
) as tabelatemp
group by 2,3
order by 3,2;


3.8) Mostrar as 5 vendas de maior valor (valor da nota) em um dado período de datas.
select to_char(sum(tabelatemp.totalitem),'$999g999g999d99')  as total_nota, tabelatemp.nf 
from
(
    select (item.quantidade*item.precoun*(1-(nota_fiscal.desconto))) as totalitem , nota_fiscal.numeronf as nf
        from nota_fiscal
        join item on item.nota_fiscal = nota_fiscal.numeronf
        where nota_fiscal.data between cast('2021-09-01' as date) and cast('2021-09-30' as date)
	group by 1,2
	order by 1 desc
)tabelatemp
group by 2
having sum(tabelatemp.totalitem) >=   --a partir daqui um select com o menor numero dentro os 5tops distintos
(
    select min(tabelaminimo.minimo)
    from
    (
        select distinct tabela2.total_nota as minimo
        from
        (
            select sum(tabelatemp.totalitem) as total_nota, tabelatemp.nf 
            from
            (
                select   (item.quantidade*item.precoun*(1-(nota_fiscal.desconto))) as totalitem , nota_fiscal.numeronf as nf
                    from nota_fiscal
                    join item on item.nota_fiscal = nota_fiscal.numeronf
                    where nota_fiscal.data between cast('2021-09-01' as date) and cast('2021-09-30' as date)
                    group by 1,2
                    order by 1 desc
            )tabelatemp
            group by 2
            order by 1 desc
        )as tabela2
        order by 1 desc
        limit 5
    )as tabelaminimo
)
order by 1 desc;

3.9) Mostrar os vendedores que venderam (valor da nota) mais no penúltimo mês do que no último mês.
select distinct tab2ultimosmeses.vendedor
from
(
    select ultimomes.valornota as valornota_ultimo, penultimomes.valornota as valornota_penultimo, penultimomes.vendedor as vendedor --valor dos dois ultimos meses por vendedor
    from
    (
    select sum(valor_nota.total_nota*valor_nota.desconto) as valornota, valor_nota.vendedor as vendedor -- valores do ultimo mes
        from
        (
            select sum(tabelatemp.totalitem) as total_nota, tabelatemp.vendedor, tabelatemp.nf, (1-tabelatemp.desconto) as desconto
            from
            (
                select (item.quantidade*item.precoun) as totalitem , vendedores.nome as vendedor ,nota_fiscal.numeronf as nf, nota_fiscal.desconto as desconto            
                from nota_fiscal
                join item on item.nota_fiscal = nota_fiscal.numeronf
                join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor
                where extract(month from nota_fiscal.data) = (extract(month from current_date)-1) --ULTIMO MES
                and extract(year from nota_fiscal.data) = extract(year from current_date)
                group by 1,2,3
                order by 1 desc
            )tabelatemp
            group by 2,3,4
            order by 2
        ) as valor_nota
        group by 2
    ) as ultimomes
    right join --todos os vendedores e quantidade notas do penultimo mes(independente de intersecção)
        (select sum(valor_nota.total_nota*valor_nota.desconto) as valornota, valor_nota.vendedor as vendedor
        from
        (
            select sum(tabelatemp.totalitem) as total_nota, tabelatemp.vendedor, tabelatemp.nf, (1-tabelatemp.desconto) as desconto
            from
            (
                select (item.quantidade*item.precoun) as totalitem , vendedores.nome as vendedor ,nota_fiscal.numeronf as nf, nota_fiscal.desconto as desconto            
                    from nota_fiscal
                    join item on item.nota_fiscal = nota_fiscal.numeronf
                    join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor
                    where extract(month from nota_fiscal.data) = (extract(month from current_date)-2) --PENULTIMO MES
                    and extract(year from nota_fiscal.data) = extract(year from current_date)
                group by 1,2,3
                order by 1 desc
            )tabelatemp
            group by 2,3,4
            order by 2
        ) as valor_nota
        group by 2) as penultimomes on penultimomes.valornota > ultimomes.valornota
        and penultimomes.vendedor = ultimomes.vendedor
) as tab2ultimosmeses;

3.10) Mostrar os vendedores por faixa de vendas (valor da nota) nos últimos 3 meses. 
Considerar as faixas de venda -$999,99, $1.000,00-$4.999,99, $5.000,00-$9.999,99, $10.000,00-$49.999,99, $50.000,00-$99.999,99 e $100.000,00-.
select liquidos.vendedor,
        case
            when liquidos.valornota <=999.99 then '-$999,99'
            when liquidos.valornota between 1000 and 4999.99 then '$1.000,00-$4.999,99'
            when liquidos.valornota between 5000 and 9999.99 then '$5.000,00-$9.999,99'
            when liquidos.valornota between 10000 and 49999.99 then '$10.000,00-$49.999,99'
            when liquidos.valornota between 50000 and 99999.99 then '$50.000,00-$99.999,99'
            when liquidos.valornota >=100000 then '-$100.000,00'           
        end as faixa_de_vendas 
from
(
    select sum(valor_nota.total_nota*valor_nota.desconto) as valornota, valor_nota.vendedor as vendedor
    from
    (
        select sum(tabelatemp.totalitem) as total_nota, tabelatemp.vendedor, tabelatemp.nf, (1-tabelatemp.desconto) as desconto
        from
        (
            select (item.quantidade*item.precoun) as totalitem , vendedores.nome as vendedor ,nota_fiscal.numeronf as nf, nota_fiscal.desconto as desconto                      
            from nota_fiscal
                join item on item.nota_fiscal = nota_fiscal.numeronf
                join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor
                where nota_fiscal.data between (NOW() - interval '3 MONTH') AND NOW()
            group by 1,2,3
            order by 1 desc
        )tabelatemp
        group by 2,3,4
        order by 2
    ) as valor_nota
    group by 2
) as liquidos;

3.11) Mostrar um valor sugerido de desconto para uma dada venda, com base na quantidade de compras do cliente nos 6 meses anteriores. 
Considerar 0,00% de desconto para 0-2 compras, 5,00% para 3-5 compras, 10,00% para 6-10 compras e 15% para 10- compras.
select clientes.nome as cliente,
    case
        when count(*) between 0 and 2 then '0,00%'
        when count(*) between 3 and 5 then '5,00%'
        when count(*) between 6 and 10 then '10,00%'
        else '15,00%'
    end as desconto_sugerido
from nota_fiscal
    join clientes on nota_fiscal.cliente = clientes.cpfcliente
where nota_fiscal.data between 
    now() - cast('6 months' as interval) and date_trunc('month', now()) - cast('1 day' as interval)
group by clientes.nome
order by count(*) desc;

3.12) Mostrar o contracheque dos vendedores em um dado mês e ano.
with comissao as 
(
    select sum(item.quantidade*item.precoun*item.comissao) as comissao, nota_fiscal.cpf_vendedor as vendedor
        from item
        join nota_fiscal on nota_fiscal.numeronf = item.nota_fiscal
    where nota_fiscal.data between cast('2021-09-01' as date) and cast('2021-09-30' as date)
    group by 2
), 
inss as
(
    select contracheque.vendedor as vendedor, 
    case
        when (contracheque.salario+comissao.comissao) between 0 and 1693.72 then (contracheque.salario+comissao.comissao)*0.08
        when (contracheque.salario+comissao.comissao) between 1693.73 and 2822.90 then (contracheque.salario+comissao.comissao)*0.09
        when (contracheque.salario+comissao.comissao) between 2822.91 and 5645.80 then (contracheque.salario+comissao.comissao)*0.11
        when (contracheque.salario+comissao.comissao) > 5645.80 then 5645.80*0.11
    end as inss
    from contracheque
    join comissao on comissao.vendedor = contracheque.vendedor
    where contracheque.data_ref between cast('2021-09-01' as date) and cast('2021-09-30' as date)
)
select
substr(contracheque.vendedor, 1, 3) || '.' ||
substr(contracheque.vendedor, 4, 3) || '.' ||
substr(contracheque.vendedor, 7, 3) || '-' ||
substr(contracheque.vendedor, 10) 
as vendedor, 
contracheque.qtd_dependentes as dependentes, to_char(contracheque.salario,'$999g999g999d99') as fixo, to_char(comissao.comissao,'$999g999g999d99') as comissao, 
to_char((contracheque.salario+comissao.comissao),'$999g999g999d99') as bruto,
to_char(inss.inss,'$999g999g999d99') as inss, to_char(irrf.irrf,'$999g999g999d99') as irrf, to_char(((contracheque.salario+comissao.comissao)-inss.inss-irrf.irrf),'$999g999g999d99') as liquido
    from contracheque
    join comissao on comissao.vendedor = contracheque.vendedor
    join inss on inss.vendedor = contracheque.vendedor
    join 
    (
        select 
            case
                when ((contracheque.salario+comissao.comissao)-inss.inss-(contracheque.qtd_dependentes*189.59)) between 0 and 1903.98 then 0
                when ((contracheque.salario+comissao.comissao)-inss.inss-(contracheque.qtd_dependentes*189.59)) between 1903.99 and 2826.65 then ((contracheque.salario+comissao.comissao)-inss.inss
                -(contracheque.qtd_dependentes*189.59))*0.075-142.80
                when ((contracheque.salario+comissao.comissao)-inss.inss-(contracheque.qtd_dependentes*189.59)) between 2826.66 and 3751.05 then ((contracheque.salario+comissao.comissao)-inss.inss
                -(contracheque.qtd_dependentes*189.59))*0.15-354.80
                when ((contracheque.salario+comissao.comissao)-inss.inss-(contracheque.qtd_dependentes*189.59)) between 3751.06 and 4664.68 then ((contracheque.salario+comissao.comissao)-inss.inss
                -(contracheque.qtd_dependentes*189.59))*0.225-636.13
                when ((contracheque.salario+comissao.comissao)-inss.inss-(contracheque.qtd_dependentes*189.59)) >4664.68 then ((contracheque.salario+comissao.comissao)-inss.inss
                -(contracheque.qtd_dependentes*189.59))*0.275-869.36
            end as irrf, contracheque.vendedor
            from contracheque
            join comissao on comissao.vendedor = contracheque.vendedor
            join inss on inss.vendedor = contracheque.vendedor
        where contracheque.data_ref between cast('2021-09-01' as date) and cast('2021-09-30' as date)
    ) as irrf on irrf.vendedor = contracheque.vendedor
where contracheque.data_ref between cast('2021-09-01' as date) and cast('2021-09-30' as date) ;

3.13) Mostrar o lucro líquido obtido em um dado mês e ano. Considerar o lucro líquido de um mês como sendo o somatório do valor das notas naquele mês subtraído dos gastos 
em contracheque de vendedores naquele mês.
--total vendas do mes(valor da nota)
select to_char
(
    (
        select sum(item.quantidade*item.precoun*(1-(nota_fiscal.desconto))) as totalvendas                   
            from nota_fiscal
            join item on item.nota_fiscal = nota_fiscal.numeronf            
         where nota_fiscal.data between cast('2021-09-01' as date) and cast('2021-09-30' as date)     
    )- --menos o salario fixo
    (
        select sum(contracheque.salario)
            from contracheque
        where data_ref between cast('2021-09-01' as date) and cast('2021-09-30' as date)
    )-   -- menos a comissao
    (
        select sum(item.quantidade*item.precoun*item.comissao)
            from item
            join nota_fiscal on nota_fiscal.numeronf = item.nota_fiscal
         where nota_fiscal.data between cast('2021-09-01' as date) and cast('2021-09-30' as date)       
    )
,'$999g999g999d99'
)  as Lucro_liquido_Setembro_2021;

3.14) Mostrar o gráfico do lucro líquido por mês para um dado ano conforme o exemplo. Considerar cada * proporcional à quantidade de dígitos na parte inteira do maior 
lucro líquido mensal naquele ano. Se o maior lucro líquido possuir 1 dígitos na parte inteira, cada * equivale a $1; 2 dígitos, a $10; 3 dígitos, a $100; e assim por diante.

 mes       | lucro     | grafico
-----------+-----------+---------
 janeiro   | $4.351,13 | ****
 fevereiro | $3.278,20 | ***
 marco     | $6.703,88 | ******
...
WITH lucroliquido as
(
    select todosmeses.mes, --TODOS OS MESES
    ( 
        case --TODAS AS VENDAS
            when total.vendas is null then 0
            else total.vendas
        end
    )
        -   -- MENOS OS SALARIOS
    (
        case
            when total.salario is null then 0
            else total.salario
        end) as lucroliquido
    from
    (
        select * from generate_series(1,12) as mes --FUNCAO PRA GERAR OS NUMEROS DOS MESES DE 1 A 12
    ) as todosmeses
            left join --TODAS os meses mesmo que nao tenha venda no mes
        (
            select vendas.mes as mes,  
                    case
                        when vendas.totalvendas is null then 0
                        else vendas.totalvendas
                    end as vendas, 
                    case
                        when salario.salariobruto is null then 0
                        else salario.salariobruto
                    end as salario
                from
                    (--todas vendas
                        select sum(item.quantidade*item.precoun*(1-(nota_fiscal.desconto))) as totalvendas, extract(month from nota_fiscal.data) as mes                    
                            from nota_fiscal
                            join item on item.nota_fiscal = nota_fiscal.numeronf            
                        where nota_fiscal.data between cast('2021-01-01' as date) and cast('2021-12-31' as date)
                        group by 2
                    ) as vendas
                full outer join --TODOS OS SALARIOS mesmo que em branco
                (
                    select (salariofixo.salario+comissao.comissao) as salariobruto, salariofixo.mes as mes
                        from
                        (
                            select sum(contracheque.salario) as salario, extract(month from data_ref) as mes
                                from contracheque
                            where data_ref between cast('2021-01-01' as date) and cast('2021-12-31' as date)
                            group by 2
                        ) as salariofixo
                        join 
                        (--todas comissoes
                            select sum(item.quantidade*item.precoun*item.comissao) as comissao ,extract(month from cast(nota_fiscal.data as date)) as mes
                                from item
                                join nota_fiscal on nota_fiscal.numeronf = item.nota_fiscal
                            where nota_fiscal.data between cast('2021-01-01' as date) and cast('2021-12-31' as date)
                            group by 2
                        ) as comissao on comissao.mes = salariofixo.mes    
                ) as salario on salario.mes = vendas.mes
        ) as total on total.mes = todosmeses.mes
),
tamanhollmax as
(
    select 10^(cast(length(cast(cast(max(lucroliquido) as integer) as varchar)) as integer)-1) as tamanho
    from lucroliquido
)
select  
    (case lucroliquido.mes
		when 1 then 'Janeiro'
		when 2 then 'Fevereiro'
		when 3 then 'Marco'
		when 4 then 'Abril'
		when 5 then 'Maio'
		when 6 then 'Junho'
		when 7 then 'Julho'
		when 8 then 'Agosto'
		when 9 then 'Setembro'
		when 10 then 'Outubro'
		when 11 then 'Novembro'
		when 12 then 'Dezembro'
    end) as mes,    to_char(lucroliquido.lucroliquido ,'$999g999g999d99') as lucro,
repeat('*',cast((trunc(lucroliquido.lucroliquido/tamanhollmax.tamanho))as integer)) as grafico
from lucroliquido,tamanhollmax;

3.15) Reajustar em 3,50% o salário fixo dos vendedores que venderam mais de $10.000,00 (valor da nota) em cada um dos últimos 3 meses.
update vendedores
set salario = salario*1.035
where cpf in
(
    select tabultimomes.vendedor --VENDAS MAIORES QUE 10K NO ULTIMO MES
        from
        (
            select sum(valor_nota.total_nota*valor_nota.desconto) as valornota, valor_nota.vendedor as vendedor 
                from
                (
                    select sum(tabelatemp.totalitem) as total_nota, tabelatemp.vendedor, tabelatemp.nf, (1-tabelatemp.desconto) as desconto
                    from
                    (
                        select (item.quantidade*item.precoun) as totalitem , vendedores.cpf as vendedor ,nota_fiscal.numeronf as nf, nota_fiscal.desconto as desconto            
                            from nota_fiscal
                            join item on item.nota_fiscal = nota_fiscal.numeronf
                            join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor
                        where extract(month from nota_fiscal.data) = (extract(month from current_date)-1)
                        and extract(year from nota_fiscal.data) = extract(year from current_date)
                        group by 1,2,3
                        order by 1 desc
                    )tabelatemp
                    group by 2,3,4
                    order by 2
                ) as valor_nota
                group by 2
        ) as tabultimomes
    intersect
        select tabelapenultimo.vendedor --VENDAS MAIORES QUE 10K NO PENULTIMO MES
            from
            (
                select sum(valor_nota.total_nota*valor_nota.desconto) as valornota, valor_nota.vendedor as vendedor
                    from
                    (
                        select sum(tabelatemp.totalitem) as total_nota, tabelatemp.vendedor, tabelatemp.nf, (1-tabelatemp.desconto) as desconto
                        from
                        (
                            select (item.quantidade*item.precoun) as totalitem , vendedores.cpf as vendedor ,nota_fiscal.numeronf as nf, nota_fiscal.desconto as desconto            
                                from nota_fiscal
                                join item on item.nota_fiscal = nota_fiscal.numeronf
                                join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor
                            where extract(month from nota_fiscal.data) = (extract(month from current_date)-2)
                            and extract(year from nota_fiscal.data) = extract(year from current_date)
                            group by 1,2,3
                            order by 1 desc
                        )tabelatemp
                        group by 2,3,4
                        order by 2
                    ) as valor_nota
                    group by 2
            ) as tabelapenultimo
    intersect
        select tabelantipenultimo.vendedor --VENDAS MAIORES QUE 10K NO ANTIPENULTIMO MES
            from
            (
                select sum(valor_nota.total_nota*valor_nota.desconto) as valornota, valor_nota.vendedor as vendedor
                    from
                    (
                        select sum(tabelatemp.totalitem) as total_nota, tabelatemp.vendedor, tabelatemp.nf, (1-tabelatemp.desconto) as desconto
                        from
                        (
                            select (item.quantidade*item.precoun) as totalitem , vendedores.cpf as vendedor ,nota_fiscal.numeronf as nf, nota_fiscal.desconto as desconto            
                                from nota_fiscal
                                join item on item.nota_fiscal = nota_fiscal.numeronf
                                join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor
                            where extract(month from nota_fiscal.data) = (extract(month from current_date)-3)
                            and extract(year from nota_fiscal.data) = extract(year from current_date)
                            group by 1,2,3
                            order by 1 desc
                        )tabelatemp
                        group by 2,3,4
                        order by 2
                    ) as valor_nota
                    group by 2
            )as tabelantipenultimo
) ;


4) Explique porque:

4.1) Não é possível excluir um vendedor demitido.
Colocaria em risco a integridade referencial do banco. Pois se o vendedor fosse referenciado em outra tabela como FK não seria possível.

4.2) É necessário ter um campo preço na tabela produto e outro na tabela item da venda em uma modelagem bem feita.
Para não misturar os dados do produto de uma venda específica. Essa ação faz com que no caso de uma atualização de preço no produto as vendas anteriores não sejam afetadas por essa atualização.
No nosso trabalho além do preço, separamos também:
- a quantidade de dependentes da tabela vendedores da tabela de contracheque para que no caso de uma mudança na quantidade de dependentes os contracheques anteriores não sejam afetados
- a comissão da tabela produto e colocamos como atributo também na tabela item, para caso seja alterada a porcentagem de comissão do produto, a comissão das vendas anteriores não sejam afetadas.






