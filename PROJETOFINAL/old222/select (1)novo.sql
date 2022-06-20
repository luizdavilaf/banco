3) Escreva uma instrução SQL para responder cada pergunta:

3.1) Mostrar o total de vendas (valor da nota) por dia em um dado período de datas.
select tabelatemp.data, '$ '||round(cast(sum(tabelatemp.totalitem)as numeric),2) as valor_nota
from
(
    select nota_fiscal.numeronf as NF, cast(nota_fiscal.data as date) as data, item.quantidade, item.precoun, 
    (item.quantidade*item.precoun*(1-(
        case
            when nota_fiscal.desconto is null then 0
            else nota_fiscal.desconto
        end))) as totalitem
    from nota_fiscal
    join item on item.nota_fiscal = nota_fiscal.numeronf
    where nota_fiscal.data between '2021-09-01' and '2021-09-30'
) as tabelatemp
group by 1;

3.2) Mostrar o valor total autorizado em descontos por gerente por mês nos últimos 6 meses.
select tabelafinal.data as mes, tabelafinal.gerente, '$ '||round(cast((tabelafinal.desconto)as numeric),2) as desconto
from
(   
    select  
    (case tabela2.data
		when 1 then 'janeiro'
		when 2 then 'fevereiro'
		when 3 then 'marco'
		when 4 then 'abril'
		when 5 then 'maio'
		when 6 then 'junho'
		when 7 then 'julho'
		when 8 then 'agosto'
		when 9 then 'setembro'
		when 10 then 'outubro'
		when 11 then 'novembro'
		when 12 then 'dezembro'
end) as data,    
    tabela2.gerente as gerente, sum(tabela2.valor_nota*tabela2.desconto) as desconto
    from
    (
        select tabelatemp.data as data, sum(tabelatemp.totalitem) as valor_nota, tabelatemp.gerente as gerente, tabelatemp.desconto as desconto
        from
        (
            select nota_fiscal.numeronf as NF, extract(month from nota_fiscal.data) as data, item.quantidade, item.precoun, (item.quantidade*item.precoun) as totalitem, nota_fiscal.nome_gerente as gerente, nota_fiscal.desconto as desconto
            from nota_fiscal
            join item on item.nota_fiscal = nota_fiscal.numeronf
            where nota_fiscal.data between (NOW() - interval '6 MONTH') AND NOW()
            and nota_fiscal.nome_gerente is not null
        ) as tabelatemp
        group by 1,3,4
    )tabela2
    group by 1,2
) as tabelafinal;

3.3) Mostrar os vendedores que venderam mais de $1.000,00 em produtos que não tem comissão em um dado mês e ano.
select sum(tabelatemp.totalitem) as total_vendedor, tabelatemp.vendedor
from
(
    select  (item.quantidade*item.precoun) as totalitem, vendedores.nome as vendedor
    from nota_fiscal
    join item on item.nota_fiscal = nota_fiscal.numeronf
    join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor            
    join produto on item.codigo_produto = produto.codigo_produto
    where produto.comissao = 0
    and nota_fiscal.data BETWEEN '2021-07-01' AND '2021-07-31'
) as tabelatemp
group by 2;            
       
3.4) Mostrar o faturamento líquido quinzenal em um dado mês e ano.

3.5) Mostrar os clientes que realizaram mais de 1 compra em cada um dos 3 últimos meses.
select ultimos3meses.cliente, ultimos3meses.mes
from
(
    --ultimo mes
    select clientes.nome as cliente, count(numeronf) as quantidade , extract(month from nota_fiscal.data) as mes
    from nota_fiscal
    join clientes on clientes.cpfcliente = nota_fiscal.cliente
    where nota_fiscal.cliente is not null
    and extract(month from nota_fiscal.data) = (extract(month from current_date)-1)
    group by 1,3
    having count(numeronf) > 1
    union--segundo mes
    select clientes.nome as cliente, count(numeronf) as quantidade , extract(month from nota_fiscal.data) as mes
    from nota_fiscal
    join clientes on clientes.cpfcliente = nota_fiscal.cliente
    where nota_fiscal.cliente is not null
    and extract(month from nota_fiscal.data) = (extract(month from current_date)-2)
    group by 1,3
    having count(numeronf) > 1
    union--terceiro mes
    select clientes.nome as cliente, count(numeronf) as quantidade , extract(month from nota_fiscal.data) as mes
    from nota_fiscal
    join clientes on clientes.cpfcliente = nota_fiscal.cliente
    where nota_fiscal.cliente is not null
    and extract(month from nota_fiscal.data) = (extract(month from current_date)-3)
    group by 1,3
    having count(numeronf) > 1
) as ultimos3meses
order by 2;


3.6) Mostrar o ranking dos produtos mais vendidos por faixa etária e por gênero em um dado período de datas. 
Considerar as faixas etárias 18-25, 26-35, 36-45, 46-55, 56-65, 66-75 e 76-.
select sum(item.quantidade) as quantidade, produto.nome as produto,  
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
    join produto on produto.codigo_produto=item.codigo_produto
    where nota_fiscal.data BETWEEN '2021-09-01' AND '2021-09-30'
	group by 2,3,4
order by 1 desc;


3.7) Mostrar o total em vendas (valor da nota) por faixa etária e por gênero dos clientes em um dado período de datas. 
Considerar as faixas etárias 18-25, 26-35, 36-45, 46-55, 56-65, 66-75 e 76-.
select '$ '||round(cast(sum(tabelatemp.totalitem)as numeric),2) as total_vendas, tabelatemp.faixa_etaria, tabelatemp.genero
from
(
    select (item.quantidade*item.precoun*(1-(
        case
            when nota_fiscal.desconto is null then 0
            else nota_fiscal.desconto
        end))) as totalitem, 
    
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
        where nota_fiscal.data between '2021-09-01' and '2021-09-30'
) as tabelatemp
group by 2,3
order by 3,2;


3.8) Mostrar as 5 vendas de maior valor (valor da nota) em um dado período de datas.
select '$ '||round(cast(sum(tabelatemp.totalitem)as numeric),2) as total_nota, tabelatemp.nf 
from
(
    select (item.quantidade*item.precoun*(1-(
        case
            when nota_fiscal.desconto is null then 0
            else nota_fiscal.desconto
        end))) as totalitem , nota_fiscal.numeronf as nf
    from nota_fiscal
    join item on item.nota_fiscal = nota_fiscal.numeronf
	 where nota_fiscal.data between '2021-09-01' and '2021-09-30'
	group by 1,2
	order by 1 desc
)tabelatemp
group by 2
having sum(tabelatemp.totalitem) >=
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
                select   (item.quantidade*item.precoun) as totalitem , nota_fiscal.numeronf as nf
                    from nota_fiscal
                    join item on item.nota_fiscal = nota_fiscal.numeronf
                    where nota_fiscal.data between '2021-09-01' and '2021-09-30'
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
select ultimomes.valornota as valornota_ultimo, penultimomes.valornota as valornota_penultimo, penultimomes.vendedor as vendedor
from
(
select sum(valor_nota.total_nota*valor_nota.desconto) as valornota, valor_nota.vendedor as vendedor
    from
    (
        select sum(tabelatemp.totalitem) as total_nota, tabelatemp.vendedor, tabelatemp.nf, (1-tabelatemp.desconto) as desconto
        from
        (
            select (item.quantidade*item.precoun) as totalitem , vendedores.nome as vendedor ,nota_fiscal.numeronf as nf, 
            case
            when nota_fiscal.desconto is null then 0
            else nota_fiscal.desconto
            end as desconto            
            from nota_fiscal
            join item on item.nota_fiscal = nota_fiscal.numeronf
            join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor
            where extract(month from nota_fiscal.data) = (extract(month from current_date)-1) --ULTIMO MES
            group by 1,2,3
            order by 1 desc
        )tabelatemp
        group by 2,3,4
        order by 2
    ) as valor_nota
    group by 2
) as ultimomes
right join 
    (select sum(valor_nota.total_nota*valor_nota.desconto) as valornota, valor_nota.vendedor as vendedor
    from
    (
        select sum(tabelatemp.totalitem) as total_nota, tabelatemp.vendedor, tabelatemp.nf, (1-tabelatemp.desconto) as desconto
        from
        (
            select (item.quantidade*item.precoun) as totalitem , vendedores.nome as vendedor ,nota_fiscal.numeronf as nf, 
            case
            when nota_fiscal.desconto is null then 0
            else nota_fiscal.desconto
            end as desconto            
            from nota_fiscal
            join item on item.nota_fiscal = nota_fiscal.numeronf
            join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor
            where extract(month from nota_fiscal.data) = (extract(month from current_date)-2) --PENULTIMO MES
            group by 1,2,3
            order by 1 desc
        )tabelatemp
        group by 2,3,4
        order by 2
    ) as valor_nota
    group by 2) as penultimomes on penultimomes.valornota > ultimomes.valornota
    and penultimomes.vendedor = ultimomes.vendedor;

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
            select (item.quantidade*item.precoun) as totalitem , vendedores.nome as vendedor ,nota_fiscal.numeronf as nf, 
            case
            when nota_fiscal.desconto is null then 0
            else nota_fiscal.desconto
            end as desconto            
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

3.13) Mostrar o lucro líquido obtido em um dado mês e ano. Considerar o lucro líquido de um mês como sendo o somatório do valor das notas naquele mês subtraído dos gastos 
em contracheque de vendedores naquele mês.

3.14) Mostrar o gráfico do lucro líquido por mês para um dado ano conforme o exemplo. Considerar cada * proporcional à quantidade de dígitos na parte inteira do maior 
lucro líquido mensal naquele ano. Se o maior lucro líquido possuir 1 dígitos na parte inteira, cada * equivale a $1; 2 dígitos, a $10; 3 dígitos, a $100; e assim por diante.

 mes       | lucro     | grafico
-----------+-----------+---------
 janeiro   | $4.351,13 | ****
 fevereiro | $3.278,20 | ***
 marco     | $6.703,88 | ******
...

3.15) Reajustar em 3,50% o salário fixo dos vendedores que venderam mais de $10.000,00 (valor da nota) em cada um dos últimos 3 meses.
--select * from vendedores;
update vendedores
set salario = salario*1.035
where cpf =
(
select tabultimomes.vendedor
from
(
    select sum(valor_nota.total_nota*valor_nota.desconto) as valornota, valor_nota.vendedor as vendedor
        from
        (
            select sum(tabelatemp.totalitem) as total_nota, tabelatemp.vendedor, tabelatemp.nf, (1-tabelatemp.desconto) as desconto
            from
            (
                select (item.quantidade*item.precoun) as totalitem , vendedores.cpf as vendedor ,nota_fiscal.numeronf as nf, 
                case
                when nota_fiscal.desconto is null then 0
                else nota_fiscal.desconto
                end as desconto            
                from nota_fiscal
                join item on item.nota_fiscal = nota_fiscal.numeronf
                join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor
                where extract(month from nota_fiscal.data) = (extract(month from current_date)-1)
                group by 1,2,3
                order by 1 desc
            )tabelatemp
            group by 2,3,4
            order by 2
        ) as valor_nota
        group by 2
) as tabultimomes
intersect
select tabelapenultimo.vendedor
from
(
    select sum(valor_nota.total_nota*valor_nota.desconto) as valornota, valor_nota.vendedor as vendedor
        from
        (
            select sum(tabelatemp.totalitem) as total_nota, tabelatemp.vendedor, tabelatemp.nf, (1-tabelatemp.desconto) as desconto
            from
            (
                select (item.quantidade*item.precoun) as totalitem , vendedores.cpf as vendedor ,nota_fiscal.numeronf as nf, 
                case
                when nota_fiscal.desconto is null then 0
                else nota_fiscal.desconto
                end as desconto            
                from nota_fiscal
                join item on item.nota_fiscal = nota_fiscal.numeronf
                join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor
                where extract(month from nota_fiscal.data) = (extract(month from current_date)-2)
                group by 1,2,3
                order by 1 desc
            )tabelatemp
            group by 2,3,4
            order by 2
        ) as valor_nota
        group by 2
) as tabelapenultimo
intersect
select tabelantipenultimo.vendedor
from
(
    select sum(valor_nota.total_nota*valor_nota.desconto) as valornota, valor_nota.vendedor as vendedor
        from
        (
            select sum(tabelatemp.totalitem) as total_nota, tabelatemp.vendedor, tabelatemp.nf, (1-tabelatemp.desconto) as desconto
            from
            (
                select (item.quantidade*item.precoun) as totalitem , vendedores.cpf as vendedor ,nota_fiscal.numeronf as nf, 
                case
                when nota_fiscal.desconto is null then 0
                else nota_fiscal.desconto
                end as desconto            
                from nota_fiscal
                join item on item.nota_fiscal = nota_fiscal.numeronf
                join vendedores on vendedores.cpf = nota_fiscal.cpf_vendedor
                where extract(month from nota_fiscal.data) = (extract(month from current_date)-3)
                group by 1,2,3
                order by 1 desc
            )tabelatemp
            group by 2,3,4
            order by 2
        ) as valor_nota
        group by 2
)as tabelantipenultimo
) 







4) Explique porque:

4.1) Não é possível excluir um vendedor demitido.
    Não posso excluir funcionarios demitidos, pois suas vendas  tambem serão excluidas.
    Desta forma os valores de caixa não se justificariam, assim como o balancete da loja.
    Exemplo: Exemplo da video-aula de DELETE e UPDATE, tem que ter cuidado com a integridade refencial do banco.

4.2) É necessário ter um campo preço na tabela produto e outro na tabela item da venda em uma modelagem bem feita.

    Sim pois ,esses campos justificam-se para que seja possível contabilizar os lucros por vendas ,bem como a cobrança 
    adequada a cada nota fiscal emitida para o cliente.
