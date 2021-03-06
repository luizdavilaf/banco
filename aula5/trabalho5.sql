
    Lista de exercícios - DQL 3
a) Escreva comandos select, utilizando as tabelas criadas para auto-locadoras na lista de exercícios
de DDL e DML e adequadas nas listas de exercícios de DQL 1 e 2, para responder as perguntas:


1) Qual o grupo de carros com a maior quantidade de locações por filial no último semestre?    
select filial.nome as filial, tabela2.categoria--,maximaotmp.maximo2,
from 
    (select max(maximo.contagem) as maximo2 , maximo.filial as filial 
    from 
        (
            select count(locacao.filialretirada) as contagem, veiculo.categoria as categoria, filial.CNPJ as filial
            from locacao
            join veiculo on veiculo.placa = locacao.veiculo
            join filial on filial.CNPJ = locacao.filialretirada
            where 
                (case 
                    when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                        and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                    when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                        and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                end                    
                )
            group by 2,3
            order by 3,1 desc
        ) as maximo    
    group by 2) as maximaotmp
join filial on filial.CNPJ = maximaotmp.filial
join (
        select count(locacao.filialretirada) as contagem, veiculo.categoria as categoria, filial.CNPJ as filial
        from locacao
        join veiculo on veiculo.placa = locacao.veiculo
        join filial on filial.CNPJ = locacao.filialretirada
        where
        (case 
            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
        end                    
        )
        group by 2,3
        order by 3,1 desc
    )tabela2 on tabela2.contagem = maximaotmp.maximo2
and tabela2.filial = maximaotmp.filial ;


2) Qual o grupo de carros com a maior quantidade de locações por pessoa física por filial no último semestre?   
select filial.nome as filial, tabela2.categoria--,maximaotmp.maximo2,
from 
    (select max(maximo.contagem) as maximo2 , maximo.filial as filial 
    from 
        (
            select count(*) as contagem,todas.categoria as categoria, todas.filial as filial, cliente.nome
            from 
            (
                select veiculo.categoria as categoria, filial.CNPJ as filial, cliente.documento as cliente, locacao.dataretirada
                    from locacao                
                    join veiculo on veiculo.placa = locacao.veiculo
                    join filial on filial.CNPJ = locacao.filialretirada
                    join cliente on cliente.documento = locacao.cliente
                    where (lower(cliente.PFPJ) like '%pf%') 
                    and 
                    (case 
                            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                    end                    
                    )                    
            )as todas            
            join filial on filial.CNPJ = todas.filial
            join cliente on cliente.documento = todas.cliente                          
            group by 2,3,4
            order by 3,1 desc            
        ) as maximo    
        group by 2
    ) as maximaotmp
join filial on filial.CNPJ = maximaotmp.filial
join (
        select count(*) as contagem ,todas.categoria as categoria, todas.filial as filial, cliente.nome
            from 
            (
                select veiculo.categoria as categoria, filial.CNPJ as filial, cliente.documento as cliente, locacao.dataretirada
                    from locacao                
                    join veiculo on veiculo.placa = locacao.veiculo
                    join filial on filial.CNPJ = locacao.filialretirada
                    join cliente on cliente.documento = locacao.cliente
                    where (lower(cliente.PFPJ) like '%pf%') 
                    and 
                    (case 
                            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                    end                    
                    )                   
            )as todas            
            join filial on filial.CNPJ = todas.filial
            join cliente on cliente.documento = todas.cliente                          
            group by 2,3,4
            order by 3,1 desc
    )tabela2 on tabela2.contagem = maximaotmp.maximo2
            and tabela2.filial = maximaotmp.filial ;     




3) Qual o grupo de carros com a maior quantidade de locações por pessoa jurídica por filial no último semestre? 
select filial.nome as filial, tabela2.categoria--,maximaotmp.maximo2,
from 
    (select max(maximo.contagem) as maximo2 , maximo.filial as filial 
    from 
        (
            select count(*) as contagem,todas.categoria as categoria, todas.filial as filial, cliente.nome
            from 
            (
                select veiculo.categoria as categoria, filial.CNPJ as filial, cliente.documento as cliente, locacao.dataretirada
                    from locacao                
                    join veiculo on veiculo.placa = locacao.veiculo
                    join filial on filial.CNPJ = locacao.filialretirada
                    join cliente on cliente.documento = locacao.cliente
                    where (lower(cliente.PFPJ) like '%pj%') 
                    and 
                    (case 
                            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                    end                    
                    )                 
            )as todas  --todas locacoes por pj          
            join filial on filial.CNPJ = todas.filial
            join cliente on cliente.documento = todas.cliente               
            group by 2,3,4
            order by 3,1 desc            
        ) as maximo    --contagem por categoria
        group by 2
    ) as maximaotmp
join filial on filial.CNPJ = maximaotmp.filial
join (
        select count(*) as contagem ,todas.categoria as categoria, todas.filial as filial, cliente.nome
            from 
            (
                select veiculo.categoria as categoria, filial.CNPJ as filial, cliente.documento as cliente, locacao.dataretirada
                    from locacao                
                    join veiculo on veiculo.placa = locacao.veiculo
                    join filial on filial.CNPJ = locacao.filialretirada
                    join cliente on cliente.documento = locacao.cliente
                    where (lower(cliente.PFPJ) like '%pj%') 
                    and 
                    (case 
                            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                    end                    
                    )                  
            )as todas            
            join filial on filial.CNPJ = todas.filial
            join cliente on cliente.documento = todas.cliente                           
            group by 2,3,4
            order by 3,1 desc
    )tabela2 on tabela2.contagem = maximaotmp.maximo2
    and tabela2.filial = maximaotmp.filial ;
      


4) Qual a marca e modelo de carro com a maior quantidade de locações por grupo de carros no último semestre?
--tem que ter os maximos de cada grupo
select tabela2.modelo, tabela2.marca, maximoporgrupo.categoria
from
    (
        select max(contagemporgrupo.contagem) as maximo, contagemporgrupo.categoria as categoria
            FROM 
                (    
                    select count(locacao.veiculo) as contagem, veiculo.modelo as modelo, veiculo.marca as marca, veiculo.categoria as categoria
                        from locacao
                            join veiculo on veiculo.placa = locacao.veiculo
                            join filial on filial.CNPJ =  locacao.filialretirada
                        where 
                        (case 
                            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                        end                    
                        )
                    group by 2,3,4
                ) as contagemporgrupo
        group by 2
    ) as maximoporgrupo
        join (
                select count(locacao.veiculo) as contagem, veiculo.modelo as modelo, veiculo.marca as marca, veiculo.categoria as categoria
                    from locacao
                        join veiculo on veiculo.placa = locacao.veiculo
                        join filial on filial.CNPJ =  locacao.filialretirada
                    where 
                    (case 
                            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                    end                    
                    )
                group by 2,3,4
            ) tabela2
        on tabela2.contagem = maximoporgrupo.maximo
        and tabela2.categoria = maximoporgrupo.categoria   ;

5) Qual a marca e modelo de carro com a maior quantidade de locações por grupo de carros por filial no último semestre?
select tabela2.modelo, tabela2.marca, maximoporgrupo.categoria, filial.nome
from
    (
        select max(contagemporgrupo.contagem) as maximo, contagemporgrupo.categoria as categoria, contagemporgrupo.filial as filial
            FROM 
                (    
                    select count(locacao.veiculo) as contagem, veiculo.modelo as modelo, veiculo.marca as marca, veiculo.categoria as categoria, locacao.filialretirada as filial
                        from locacao
                            join veiculo on veiculo.placa = locacao.veiculo
                            join filial on filial.CNPJ =  locacao.filialretirada
                        where 
                        (case 
                            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                        end                    
                        )
                    group by 2,3,4,5
                ) as contagemporgrupo
        group by 2,3
    ) as maximoporgrupo
        join filial on filial.CNPJ = maximoporgrupo.filial
        join (
                select count(locacao.veiculo) as contagem, veiculo.modelo as modelo, veiculo.marca as marca, veiculo.categoria as categoria, locacao.filialretirada as filial
                    from locacao
                        join veiculo on veiculo.placa = locacao.veiculo
                        join filial on filial.CNPJ =  locacao.filialretirada
                    where 
                    (case 
                        when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                        when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                    end                    
                    )
                group by 2,3,4,5
                order by 5
            ) tabela2
        on tabela2.contagem = maximoporgrupo.maximo
        and tabela2.categoria = maximoporgrupo.categoria
        and tabela2.filial = maximoporgrupo.filial;


6) Qual o grupo de carros que possui a marca e modelo de carro com a maior quantidade de locações no último semestre?
select tabelamaximo.categoria
from
    (
        select count(*), veiculo.marca, veiculo.modelo, veiculo.categoria as categoria
        from locacao
        join veiculo on veiculo.placa = locacao.veiculo
        where 
           (case 
                when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
            end                    
            )
        group by 2,3,4
        having count(*) = 
            (
                select max(tabela.contagem)
                from
                (
                    select count(*) as contagem, veiculo.marca, veiculo.modelo, veiculo.categoria
                        from locacao
                        join veiculo on veiculo.placa = locacao.veiculo
                        where 
                            (case 
                                when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                                when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                            end                    
                            )
                        group by 2,3,4
                ) as tabela
            )
    ) as tabelamaximo;

7) Qual o cliente pessoa física com a maior quantidade de locações no último semestre por filial?  
select  cliente.nome as cliente, filial.nome as filial--,maximo.contagem,
from
    (select max(contagemporcliente.contagem) as contagem, contagemporcliente.filial as filial
    from
        (select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
        from locacao
        join cliente on cliente.documento = locacao.cliente
        where (lower(cliente.PFPJ) like '%pf%') 
        and
        (case 
            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
        end                    
        )
        group by 2,3
        ) as contagemporcliente
    group by 2--,3
    order by 1 desc
    ) as maximo
     
    join filial on filial.CNPJ = maximo.filial 
    join (
            select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
            from locacao
            join cliente on cliente.documento = locacao.cliente
            where (lower(cliente.PFPJ) like '%pf%') 
            and
            (case 
                when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
            end                    
            )
            group by 2,3
        ) tabelatemp
            on maximo.contagem = tabelatemp.contagem
            and maximo.filial = tabelatemp.filial   
    join cliente on cliente.documento = tabelatemp.cliente;


8) Qual o cliente pessoa jurídica com a maior quantidade de locações no último semestre por filial?
select  cliente.nome as cliente, filial.nome as filial--,maximo.contagem,
from
    (select max(contagemporcliente.contagem) as contagem, contagemporcliente.filial as filial
    from
        (select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
        from locacao
        join cliente on cliente.documento = locacao.cliente
        where (lower(cliente.PFPJ) like '%pj%') 
        and
        (case 
            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
        end                    
        )
        group by 2,3
        ) as contagemporcliente
    group by 2--,3
    order by 1 desc
    ) as maximo     
    join filial on filial.CNPJ = maximo.filial 
    join (
            select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
            from locacao
            join cliente on cliente.documento = locacao.cliente
            where (lower(cliente.PFPJ) like '%pj%') 
            and
            (case 
                when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
            end                    
            )
            group by 2,3
        ) tabelatemp
            on maximo.contagem = tabelatemp.contagem
            and maximo.filial = tabelatemp.filial   
    join cliente on cliente.documento = tabelatemp.cliente;


9) Qual o cliente pessoa jurídica com o maior valor total em locações no último semestre por filial?
select  cliente.nome as cliente, filial.nome as filial--,maximo.contagem,
from
    (select max(somaporcliente.soma) as soma, somaporcliente.filial as filial
    from
        (select sum(locacao.valordalocacao) as soma, locacao.cliente as cliente , locacao.filialretirada as filial
        from locacao
        join cliente on cliente.documento = locacao.cliente
        where (lower(cliente.PFPJ) like '%pj%') 
        and
        (case 
            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
        end                    
        )
        group by 2,3
        ) as somaporcliente
    group by 2--,3
    order by 1 desc
    ) as maximo     
    join filial on filial.CNPJ = maximo.filial 
    join (
            select sum(locacao.valordalocacao)as soma, locacao.cliente as cliente , locacao.filialretirada as filial
            from locacao
            join cliente on cliente.documento = locacao.cliente
            where (lower(cliente.PFPJ) like '%pj%') 
            and
            (case 
                when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
            end                    
            )
            group by 2,3
        ) tabelatemp
            on maximo.soma = tabelatemp.soma
            and maximo.filial = tabelatemp.filial   
    join cliente on cliente.documento = tabelatemp.cliente;


10) Quais os clientes pessoa jurídica com a 1a, 2a e 3a maior quantidade de locações nos últimos 12 meses por filial?
--professor fiz com rank(30 linhas) e sem rank dentro das minhas limitações(200 linhas)
select rankeadas.ranking as ranking , cliente.nome  as cliente, filial.nome as filial--, tabelafinal.contagem as locacoes
from
    (select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
        from locacao        
        join filial on filial.CNPJ = locacao.filialretirada
        join cliente on cliente.documento = locacao.cliente        
    where (lower(cliente.PFPJ) like '%pj%')
    and 
    locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
    and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)                   
    group by 2,3
    ) as tabelafinal    
join cliente on cliente.documento = tabelafinal.cliente
join filial on filial.CNPJ = tabelafinal.filial
join (
        select ranking.minimo as minimo, ranking.filial as filial, ranking.ranking as ranking
        from
        ( 
            select minimo.top3 as minimo, minimo.filial as filial, DENSE_RANK() OVER(PARTITION BY minimo.filial ORDER BY minimo.top3 desc,minimo.filial) as ranking
                from
                (
                select distinct conta.contagem as top3, conta.filial as filial
                from
                    (
                            select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
                            from locacao
                            join cliente on cliente.documento = locacao.cliente
                            where (lower(cliente.PFPJ) like '%pj%')
                            and 
                            locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
                            and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)                    
                            group by 2,3
                            order by 3 desc ,1 desc
                    ) as conta
                order by 1 desc            
                ) as minimo        
            group by 1,2
            order by 2,3,1 desc
        ) as ranking
    where ranking.ranking<=3
    ) rankeadas on filial.CNPJ = rankeadas.filial
and tabelafinal.contagem = rankeadas.minimo;


--sem rank
select ultimatabela.posicao, ultimatabela.filial, ultimatabela.cliente
from
(
    select tabelafinal.contagem as locacoes, filial.nome as filial, cliente.nome as cliente, rankeadas.posicao as posicao
    from
    (
        select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
            from locacao        
            join filial on filial.CNPJ = locacao.filialretirada
            join cliente on cliente.documento = locacao.cliente        
        where (lower(cliente.PFPJ) like '%pj%')
        and 
        locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
        and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)                    
        group by 2,3
        order by 1
    ) as tabelafinal
    join cliente on cliente.documento = tabelafinal.cliente
    join filial on filial.CNPJ = tabelafinal.filial
    join --rankeando as quantidades maiores
    (--quantidade posicao 1
    select max(distintos.top3) as contagem, distintos.filial as filial, 1 as posicao
            from
            (select distinct conta2.contagem as top3, conta2.filial as filial
                    from
                        (
                                select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
                                from locacao
                                join cliente on cliente.documento = locacao.cliente
                                where (lower(cliente.PFPJ) like '%pj%')
                                and locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
                                and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)                                        
                                group by 2,3
                                order by 3 desc ,1 desc
                        ) as conta2
                    order by 2 desc, 1 desc
            )as distintos
            group by 2     
    union  --quantidade posicao 2
    select posicoes2.maximo2 as contagem, posicoes2.filial as filial, 2 as posicao
    from
    (select max(distintos2.top3) as maximo2, distintos2.filial as filial
        from
        (
            select distinct conta2.contagem as top3, conta2.filial as filial
                from
                    (
                            select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
                            from locacao
                            join cliente on cliente.documento = locacao.cliente
                            where (lower(cliente.PFPJ) like '%pj%')
                            and locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
                            and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)                                        
                            group by 2,3
                            order by 3 desc ,1 desc
                    ) as conta2
                    except ( --excluindo quantidade posicao 1
            select max(distintos.top3) as maximo, distintos.filial as filial
                    from
                    (select distinct conta2.contagem as top3, conta2.filial as filial
                            from
                                (
                                        select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
                                        from locacao
                                        join cliente on cliente.documento = locacao.cliente
                                        where (lower(cliente.PFPJ) like '%pj%')
                                        and locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
                                        and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)                                        
                                        group by 2,3
                                        order by 3 desc ,1 desc
                                ) as conta2
                            order by 2 desc, 1 desc
                    )as distintos
                    group by 2
            )
                order by 2 desc, 1 desc
        )as distintos2
        group by 2
    ) posicoes2
    union --quantidade posicao 3    
    select posicoes3.maximo3 as contagem, posicoes3.filial as filial, 3 as posicao
    from
    (
        select max(distintos3.top3) as maximo3, distintos3.filial as filial
        from
        (
            select distinct conta3.contagem as top3, conta3.filial as filial
                from
                    (
                            select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
                            from locacao
                            join cliente on cliente.documento = locacao.cliente
                            where (lower(cliente.PFPJ) like '%pj%')
                            and locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
                            and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)                                        
                            group by 2,3
                            order by 3 desc ,1 desc
                    ) as conta3
                except --excluindo quantidade posicao 2
                    (select posicoes2.maximo2, posicoes2.filial
                        from
                        (select max(distintos2.top3) as maximo2, distintos2.filial as filial
                            from
                            (
                                select distinct conta2.contagem as top3, conta2.filial as filial
                                    from
                                        (
                                                select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
                                                from locacao
                                                join cliente on cliente.documento = locacao.cliente
                                                where (lower(cliente.PFPJ) like '%pj%')
                                                and locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
                                                and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)                                        
                                                group by 2,3
                                                order by 3 desc ,1 desc
                                        ) as conta2
                                        except 
                                        (
                                        select max(distintos.top3) as maximo, distintos.filial as filial
                                        from
                                        (select distinct conta2.contagem as top3, conta2.filial as filial
                                                from
                                                    (
                                                            select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
                                                            from locacao
                                                            join cliente on cliente.documento = locacao.cliente
                                                            where (lower(cliente.PFPJ) like '%pj%')
                                                            and locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
                                                            and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)                                        
                                                            group by 2,3
                                                            order by 3 desc ,1 desc
                                                    ) as conta2
                                                order by 2 desc, 1 desc
                                        )as distintos
                                        group by 2
                                        )
                                
                                
                                    order by 2 desc, 1 desc
                            )as distintos2
                            group by 2
                        ) posicoes2
                    )
                    except --excluindo quantidade posicao 1
                    (
                    select max(distintos.top3) as maximo, distintos.filial as filial
                    from
                    (select distinct conta2.contagem as top3, conta2.filial as filial
                            from
                                (
                                        select count(*)as contagem, locacao.cliente as cliente , locacao.filialretirada as filial
                                        from locacao
                                        join cliente on cliente.documento = locacao.cliente
                                        where (lower(cliente.PFPJ) like '%pj%')
                                        and locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
                                        and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)                                        
                                        group by 2,3
                                        order by 3 desc ,1 desc
                                ) as conta2
                            order by 2 desc, 1 desc
                    )as distintos
                    group by 2
                    )                
        ) as distintos3
        group by 2
    ) as posicoes3
    ) as rankeadas on filial.CNPJ = rankeadas.filial --mesmo cnpj
and tabelafinal.contagem = rankeadas.contagem --e mesma quantidade
order by 2, 1 desc) as ultimatabela;



11) Quais os clientes pessoa jurídica ativos nos últimos 12 meses que não locaram nos últimos 3 meses?
select distinct locacao.cliente as cliente 
from locacao
join cliente on cliente.documento = locacao.cliente
where (lower(cliente.PFPJ) like '%pj%')
and locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
and locacao.dataretirada < date_trunc('month', current_date - interval '1' month) 
except
(
    select distinct locacao.cliente as cliente 
    from locacao
    join cliente on cliente.documento = locacao.cliente
    where (lower(cliente.PFPJ) like '%pj%')
    and locacao.dataretirada >= date_trunc('month', current_date - interval '3' month)
    and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)
) ;

12) Qual o carro com a maior quilometragem rodada nos últimos 3 meses por grupo de carros?
select tabelafinal3.veiculo as veiculo, veiculo.categoria as categoria
from
(select tabelafinal2.veiculo as veiculo, veiculo.categoria as categoria, tabelafinal2.kmtotal as kmtotal
    from
    (
        select (tabelafinal.maximo - tabelafinal.minimo) as kmtotal, tabelafinal.veiculo as veiculo
        from 
        (
            select menoreskm.km as minimo, maioreskm.km as maximo, menoreskm.veiculo as veiculo
            from
            (select min(locacao.kmretirada) as km, locacao.veiculo as veiculo
            from locacao
            where dataretirada >=  CURRENT_DATE - INTERVAL '3 months'
            group by 2) as menoreskm
            join 
                (select max(locacao.kmentrega) as km, locacao.veiculo as veiculo
                from locacao 
                where dataretirada >=  CURRENT_DATE - INTERVAL '3 months'
                group by 2) as maioreskm on menoreskm.veiculo = maioreskm.veiculo
        ) as tabelafinal
    )as tabelafinal2
    join veiculo on veiculo.placa = tabelafinal2.veiculo
)as tabelafinal3
join veiculo on veiculo.placa = tabelafinal3.veiculo
join (select max(tab3.kmtotal) as quilometragem, veiculo.categoria as categoria
    from
    (
        select (tabelafinal.maximo - tabelafinal.minimo) as kmtotal, tabelafinal.veiculo as veiculo
        from 
        (
            select menoreskm.km as minimo, maioreskm.km as maximo, menoreskm.veiculo as veiculo
            from
            (select min(locacao.kmretirada) as km, locacao.veiculo as veiculo
            from locacao
            where dataretirada >=  CURRENT_DATE - INTERVAL '3 months'
            group by 2) as menoreskm
            join 
                (select max(locacao.kmentrega) as km, locacao.veiculo as veiculo
                from locacao 
                where dataretirada >=  CURRENT_DATE - INTERVAL '3 months'
                group by 2) as maioreskm on menoreskm.veiculo = maioreskm.veiculo
        ) as tabelafinal
    )as tab3
    join veiculo on veiculo.placa = tab3.veiculo
    group by 2
    ) as tabelamaximosporcat on tabelamaximosporcat.quilometragem = tabelafinal3.kmtotal
    and tabelamaximosporcat.categoria = tabelafinal3.categoria
    ;


13) Qual o cliente da locação de maior duração por grupo de carros por filial no último semestre?
select distinct cliente.nome as cliente, veiculo.categoria as categoria, filial.nome as filial
from
(
    select locacao.cliente as cliente , (locacao.dataentrega - locacao.dataretirada) as duracao , locacao.veiculo as veiculo, locacao.codigolocacao as codigo, veiculo.categoria as categoria, locacao.filialretirada as filial
    from locacao
    join veiculo on veiculo.placa = locacao.veiculo
    where locacao.dataentrega is not null
    and (
        case 
            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
        end
        )    
    order by duracao desc
) as todasduracoes
join cliente on cliente.documento = todasduracoes.cliente
join veiculo on veiculo.placa = todasduracoes.veiculo
join filial on filial.CNPJ = todasduracoes.filial
join (
        select max(maximos.duracao) as maximo,  maximos.categoria as categoria, maximos.filial as filial 
        from
        (
            select locacao.cliente as cliente , (locacao.dataentrega - locacao.dataretirada) as duracao , locacao.veiculo as veiculo, locacao.codigolocacao as codigo, veiculo.categoria as categoria, locacao.filialretirada as filial
            from locacao
            join veiculo on veiculo.placa = locacao.veiculo
            where locacao.dataentrega is not null
            and (
                case 
                    when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                        and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                    when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                        and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                end
                ) 
        ) as maximos 
        group by 2,3
        ) as maximoscatfilial on maximoscatfilial.maximo = todasduracoes.duracao
        and maximoscatfilial.categoria = todasduracoes.categoria
        and maximoscatfilial.filial = todasduracoes.filial
order by filial ;

14) Qual o mês com a maior quantidade de locações por filial nos últimos 5 anos?
select filial.nome as filial, 
(case todaslocacoespormes.mes
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
end) as dia_semana,
todaslocacoespormes.ano
from
(
    select count(todaslocacoes.codigo) as contagem, todaslocacoes.filial as filial, extract(month from todaslocacoes.data) as mes, extract(year from todaslocacoes.data) as ano
    from
    (
        select locacao.filialretirada as filial, locacao.codigolocacao as codigo, locacao.dataretirada as data
        from locacao
        where locacao.dataretirada >= date_trunc('year', current_date - interval '5' year)        
    ) as todaslocacoes
    group by 2,3,4
    order by filial, mes
) as todaslocacoespormes
join filial on filial.CNPJ = todaslocacoespormes.filial
join (
    select max(contagempormes.contagem) as maximo, contagempormes.filial as filial
    from
        (
            select count(todaslocacoes.codigo) as contagem, todaslocacoes.filial as filial, extract(month from todaslocacoes.data) as mes, extract(year from todaslocacoes.data) as ano
            from
            (
                select locacao.filialretirada as filial, locacao.codigolocacao as codigo, locacao.dataretirada as data
                from locacao
                where locacao.dataretirada >= date_trunc('year', current_date - interval '5' year)                
            ) as todaslocacoes
            group by 2,3,4
            order by filial, mes
        ) as contagempormes
    group by 2
) as maximosporfilial on maximosporfilial.maximo = todaslocacoespormes.contagem
and maximosporfilial.filial = todaslocacoespormes.filial;


15) Quais as 3 características de carros mais requisitadas nas locações no último semestre por gênero do condutor?
select todaslocacoes1.caracteristica, 
case 
when todaslocacoes1.genero = 'm' then 'masculino'
else 'feminino'
end
as genero
from
(
    select count(todaslocacoes.caracteristica) as contagem, todaslocacoes.caracteristica as caracteristica, todaslocacoes.genero as genero
    from
    (
        select caracteristica.nome as caracteristica, condutor.genero as genero--, veiculocaracteristica.veiculo as veiculo
        from veiculocaracteristica
        join caracteristica on caracteristica.codigocaracteristica = veiculocaracteristica.codigocaracteristica
        join locacao on locacao.veiculo = veiculocaracteristica.veiculo
        join condutor on condutor.documento = locacao.condutor         
        and (
            case 
                when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
            end
            )           
    ) as todaslocacoes
    group by 2,3
    order by 3,1 desc,2 
) as todaslocacoes1
    join (
            select limitemasc.contagem as contagem, limitemasc.genero as genero
            from
            (
            select distinct distintas.contagem as contagem, 'm' as genero
            from 
            (
                select count(todaslocacoes.caracteristica) as contagem, todaslocacoes.caracteristica as caracteristica, todaslocacoes.genero as genero
                from
                (
                    select caracteristica.nome as caracteristica, condutor.genero as genero--, veiculocaracteristica.veiculo as veiculo
                    from veiculocaracteristica
                    join caracteristica on caracteristica.codigocaracteristica = veiculocaracteristica.codigocaracteristica
                    join locacao on locacao.veiculo = veiculocaracteristica.veiculo
                    join condutor on condutor.documento = locacao.condutor 
                    where condutor.genero = 'm'
                    and (
                        case 
                            when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                            when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                        end
                        )    
                ) as todaslocacoes
                group by 2,3
                order by 1 desc
            ) as distintas 
            order by 1 desc  
            limit 3
            ) as limitemasc 
            union 
            select limitefem.contagem as contagem, limitefem.genero
            from
            (
                select distinct distintasfem.contagem as contagem, 'f' as genero
                from 
                (
                    select count(todaslocacoes.caracteristica) as contagem, todaslocacoes.caracteristica as caracteristica, todaslocacoes.genero as genero
                    from
                    (
                        select caracteristica.nome as caracteristica, condutor.genero as genero--, veiculocaracteristica.veiculo as veiculo
                        from veiculocaracteristica
                        join caracteristica on caracteristica.codigocaracteristica = veiculocaracteristica.codigocaracteristica
                        join locacao on locacao.veiculo = veiculocaracteristica.veiculo
                        join condutor on condutor.documento = locacao.condutor 
                        where condutor.genero = 'f'
                        and (
                            case 
                                when extract(month from current_date) <= 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)    
                                when extract(month from current_date) > 6 then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)                       	
                            end
                            )    
                    ) as todaslocacoes
                    group by 2,3
                    order by 1 desc
                ) as distintasfem
                order by 1 desc
                limit 3 
            ) as limitefem            
        ) as top3generos on top3generos.contagem = todaslocacoes1.contagem
        and top3generos.genero = todaslocacoes1.genero;

16) Quais condutores locaram carros como pessoa física e também como pessoa jurídica nos últimos 12 meses?
select distinct condutor.nome--, cliente.PFPJ
    from condutor
    join locacao on locacao.condutor = condutor.documento
    join cliente on cliente.documento = locacao.cliente
    where cliente.PFPJ = 'pf'
    and locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
    and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date) 
intersect
select distinct condutor.nome--, cliente.PFPJ
    from condutor
    join locacao on locacao.condutor = condutor.documento
    join cliente on cliente.documento = locacao.cliente
    where cliente.PFPJ = 'pj'
    and locacao.dataretirada >= date_trunc('month', current_date - interval '12' month)
    and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date);


17) Quais carros devem ir para revisão (rodaram pelo menos 20000km desde a última revisão ou não fazem revisão há mais de 6 meses) por filial?
select distinct tudo.veiculo, filial.nome as filial
from
(
    select maisde20k2.veiculo as veiculo 
    from
    (
        select maisde20k.diferenca as diferenca, maisde20k.veiculo as veiculo
        from
        (
            select max(locacao.kmentrega)-max(revisao.kmrevisao) as diferenca, locacao.veiculo as veiculo
            from locacao
            join revisao on revisao.veiculo = locacao.veiculo    
            group by 2
        )as maisde20k
        where diferenca > 20000
    ) as maisde20k2
    union 
    select maisde6meses2.veiculo
    from
    (
        select maisde6meses.ultima as ultima, maisde6meses.veiculo as veiculo
        from
        (
        select cast((extract(day from (current_date - max(revisao.datarevisao)))/30) as integer) as ultima , revisao.veiculo as veiculo
        from revisao
        group by 2
        )as maisde6meses
        where maisde6meses.ultima > 6
    )as maisde6meses2
    order by 1
) as tudo
join veiculo on veiculo.placa = tudo.veiculo
join filial on veiculo.filial = filial.CNPJ
order by 2;

18) Qual o percentual do valor total arrecadado em locações por tipo de cliente (pessoa física ou jurídica) por filial nos últimos 3 meses?
select round(cast((total.valor/(select sum(valordalocacao)from locacao)*100)as numeric),2)||'%' as parte, total.tipocliente,  filial.nome as filial
from
(
    select sum(locacao.valordalocacao) as valor, cliente.PFPJ as tipocliente, locacao.filialretirada as filial
    from locacao
        join cliente on cliente.documento = locacao.cliente
    where locacao.dataretirada >= date_trunc('month', current_date - interval '3' month)
    and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)
    group by 2,3
    order by 3
)as total
    join filial on filial.CNPJ = total.filial;



19) Quais filiais tiveram redução de pelo menos 20% na quantidade de locações considerando o último e o penúltimo trimestre?
select filial.nome as filial
from
(
select diferenca.filial as filial, cast((diferenca.contagempenultimomes - diferenca.contagemultimomes)as numeric) as diferenca, cast(diferenca.contagempenultimomes as numeric) as contagempenultimomes

from
(
select filial.CNPJ as filial, contagempen2.contagempen as contagempenultimomes, contagemult.contagemult2 as contagemultimomes
from filial
join 
(select 
case
when tabpen.contagem > 0 then tabpen.contagem
else 0
end as contagempen,
filial.CNPJ as filial
from
(
    select count(locacao.codigolocacao) as contagem, locacao.filialretirada as filial
    from locacao
    where
    (--penultimo trimestre
        case 
            when extract(month from current_date) between 1 and 3 then locacao.dataretirada < make_date(cast(extract(year from current_date)as integer)-1 , 10 , 01)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)
            when extract(month from current_date) between 4 and 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 10 , 01) 
            when extract(month from current_date)  between 7 and 9  then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 04 , 01)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)  
            when extract(month from current_date)  between 10 and 12  then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 04 , 01)                                     	
        end
    ) 
    group by 2
)as tabpen
right join filial on filial.CNPJ = tabpen.filial
)contagempen2 on contagempen2.filial = filial.CNPJ
join 
(select 
case
when tabult.contagem > 0 then tabult.contagem
else 0
end as contagemult2,
filial.CNPJ as filial
from
(
select count(locacao.codigolocacao)as contagem, locacao.filialretirada as filial
from locacao
where
(--ultimo trimestre
    case 
        when extract(month from current_date) between 1 and 3 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 10 , 01) 
        when extract(month from current_date)  between 4 and 6 then   locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 04 , 01)
            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)  
        when extract(month from current_date)  between 7 and 9 then   locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 04 , 01)
        when extract(month from current_date)  between 10 and 12 then   locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 10 , 01)
            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 07 , 01)                               	
    end
) 
group by 2
)as tabult
right join filial on filial.CNPJ = tabult.filial
) as contagemult on contagemult.filial = filial.CNPJ
)as diferenca
where diferenca.contagempenultimomes>0
) as tudo
join filial on filial.CNPJ = tudo.filial
where (tudo.diferenca/tudo.contagempenultimomes)> 0.20;


20) Quais filiais tiveram aumento de pelo menos 20% na quantidade de locações considerando o último e o penúltimo trimestre?
select filial.nome as filial, (tudo.diferenca/tudo.contagepemultimomes)
from
(
select diferenca.filial as filial, cast((diferenca.contagemultimomes - diferenca.contagempenultimomes)as numeric) as diferenca, 
case 
when diferenca.contagempenultimomes = 0 then 0.000000000000001
else cast(diferenca.contagempenultimomes as numeric) 
end as contagepemultimomes
from
(
select filial.CNPJ as filial, contagempen2.contagempen as contagempenultimomes, contagemult.contagemult2 as contagemultimomes
from filial
join 
(select 
case
when tabpen.contagem > 0 then tabpen.contagem
else 0
end as contagempen,
filial.CNPJ as filial
from
(
    select count(locacao.codigolocacao) as contagem, locacao.filialretirada as filial
    from locacao
    where
    (--penultimo trimestre
        case 
            when extract(month from current_date) between 1 and 3 then locacao.dataretirada < make_date(cast(extract(year from current_date)as integer)-1 , 10 , 01)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)
            when extract(month from current_date) between 4 and 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 10 , 01) 
            when extract(month from current_date)  between 7 and 9  then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 04 , 01)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)  
            when extract(month from current_date)  between 10 and 12  then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 04 , 01)                                     	
        end
    ) 
    group by 2
)as tabpen
right join filial on filial.CNPJ = tabpen.filial
)contagempen2 on contagempen2.filial = filial.CNPJ
join 
(select 
case
when tabult.contagem > 0 then tabult.contagem
else 0
end as contagemult2,
filial.CNPJ as filial
from
(
select count(locacao.codigolocacao)as contagem, locacao.filialretirada as filial
from locacao
where
(--ultimo trimestre
    case 
        when extract(month from current_date) between 1 and 3 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 10 , 01) 
        when extract(month from current_date)  between 4 and 6 then   locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 04 , 01)
            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)  
        when extract(month from current_date)  between 7 and 9 then   locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 04 , 01)
        when extract(month from current_date)  between 10 and 12 then   locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 10 , 01)
            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 07 , 01)                               	
    end
) 
group by 2
)as tabult
right join filial on filial.CNPJ = tabult.filial
) as contagemult on contagemult.filial = filial.CNPJ
)as diferenca
where diferenca.contagemultimomes>0
and cast((diferenca.contagemultimomes - diferenca.contagempenultimomes)as numeric) >0
) as tudo
join filial on filial.CNPJ = tudo.filial
where (tudo.diferenca/tudo.contagepemultimomes)> 0.20;


21) Qual o percentual de variação no valor total arrecadado em locações por filial considerando o último e o penúltimo trimestre?
select tudo.filial, round((((tudo.contagemultimomes-tudo.contagempenultimomes)/tudo.contagempenultimomes)*100),2)||'%' as percentual
from
(
    select filial.CNPJ as filial, cast(contagempen2.contagempen as numeric) as contagempenultimomes, cast(contagemult.contagemult2 as numeric) as contagemultimomes
    from filial
    join 
    (
    select 
    case
    when tabpen.contagem > 0 then tabpen.contagem
    else 0
    end as contagempen,
    filial.CNPJ as filial
    from
    (
        select sum(locacao.valordalocacao) as contagem, locacao.filialretirada as filial
        from locacao
        where
        (--penultimo trimestre
            case 
                when extract(month from current_date) between 1 and 3 then locacao.dataretirada < make_date(cast(extract(year from current_date)as integer)-1 , 10 , 01)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 07 , 01)
                when extract(month from current_date) between 4 and 6 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 10 , 01) 
                when extract(month from current_date)  between 7 and 9  then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 04 , 01)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)  
                when extract(month from current_date)  between 10 and 12  then  locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                    and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 04 , 01)                                     	
            end
        ) 
        group by 2
    )as tabpen
    right join filial on filial.CNPJ = tabpen.filial
    )contagempen2 on contagempen2.filial = filial.CNPJ
    join 
    (
        select 
            case
            when tabult.contagem > 0 then tabult.contagem
            else 0
            end as contagemult2,
            filial.CNPJ as filial
            from
            (
                select sum(locacao.valordalocacao)as contagem, locacao.filialretirada as filial
                from locacao
                where
                (--ultimo trimestre
                    case 
                        when extract(month from current_date) between 1 and 3 then locacao.dataretirada <= make_date(cast(extract(year from current_date)as integer)-1 , 12 , 31)
                            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer)-1 , 10 , 01) 
                        when extract(month from current_date)  between 4 and 6 then   locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 04 , 01)
                            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 01 , 01)  
                        when extract(month from current_date)  between 7 and 9 then   locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 07 , 01)
                            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 04 , 01)
                        when extract(month from current_date)  between 10 and 12 then   locacao.dataretirada < make_date(cast(extract(year from current_date)as integer) , 10 , 01)
                            and locacao.dataretirada >= make_date(cast(extract(year from current_date)as integer) , 07 , 01)                               	
                    end
                ) 
                group by 2
            )as tabult
    right join filial on filial.CNPJ = tabult.filial
    ) as contagemult on contagemult.filial = filial.CNPJ
) as tudo;



22) Quais clientes locaram carros em 3 meses consecutivos nos últimos 12 meses?


23) Mostrar o gráfico de barras acumuladas, como no exemplo, da quantidade de carros locados por dia da semana por filial na última semana, sendo cada letra equivalente a 10 carros, A é o
identificador da filial 1, B é o da filial 2 e assim por diante.
dia | quantidade
-----+-------------
seg | AAABCCC
ter | BBC
qua | AC
qui | ABBCC
sex | AABBCCC
sab | AAABBBCCCC
dom | AAAABBBBCCC

select case  ff.dias
                        when 0 then 'domingo'
                        when 1 then 'segunda'
                        when 2 then 'terca'
                        when 3 then 'quarta'
                        when 4 then 'quinta'
                        when 5 then 'sexta'
                        when 6 then 'sabado'
                end as diadasemana,
                ff.string
from
(
select final.dias as dias, string_agg(final.cont,'') as string
from
(
    select repeat(cast(porsemana.filial as VARCHAR),cast(porsemana.contagem as integer)) as cont,  porsemana.diadasemana as dias
    from
    (
        select count(locacao.codigolocacao) as contagem, 
        case 
        when locacao.filialretirada = '12345678911235' then 'A'
        when locacao.filialretirada = '12345678911234' then 'B'
        end as filial, 
        extract(dow from locacao.dataretirada) as diadasemana                       
        from locacao
        --where  extract('week' from locacao.dataretirada) = extract('week' from current_date)-1
        group by 2,3
        order by 3
    )as porsemana
    order by 2
) as final

group by 1
order by 1
)as ff
;

 

======================================================================================================================================================================
b) Descreva e justifique as adequações/alterações que foram realizadas nas tabelas para auto-locadoras da lista de exercícios de DQL 2 para que o exercício acima pudesse ser resolvido.
inseri a entidade condutor para pesquisa de genero e diferenciar quando um condutor aluga como pj ou pf, pois ele pode tanto ser o locador quanto condutor. Assumo que quando o locador por pj obrigatoriamente devera ter um condutor pf na lista de condutores
coloquei o atributo dataultimarevisao em veiculo como not null para que quando der um insert(data de aquisicao) em um veiculo seja obrigado a colocar a data de ultima revisao e todos os veiculos terem pelo menos 1 revisao



======================================================================================================================================================================
c) Utilizando a modelagem da pizzaria trabalhada nas semanas 1 e 2, escreva comandos select
para responder as perguntas:    
    
    1) Qual sabor tem mais ingredientes ?
select
    sabor.nome --count(ingrediente) as sabor,
from
    saboringrediente
    join sabor on sabor.codigo = saboringrediente.sabor
group by
    sabor.nome
having
    count(ingrediente) = (
        select
            max(tabelamaximos.contagem)
        from
            (
                select
                    count(ingrediente) as contagem,
                    sabor
                from
                    saboringrediente
                group by
                    sabor
            ) as tabelamaximos
    );

2) Qual sabor tem menos ingredientes ?
select
    sabor.nome --,count(ingrediente) as sabor,
from
    saboringrediente
    join sabor on sabor.codigo = saboringrediente.sabor
group by
    sabor.nome
having
    count(ingrediente) = (
        select
            min(tabelamaximos.contagem)
        from
            (
                select
                    count(ingrediente) as contagem,
                    sabor
                from
                    saboringrediente
                group by
                    sabor
            ) as tabelamaximos
    );

3) Qual sabor não foi pedido nos últimos 4 domingos ?
select
    distinct sabor.nome
from
    sabor
where
    sabor.codigo not in (
        select
            sabor.codigo
        from
            comanda
            join pizza on pizza.comanda = comanda.numero
            join pizzasabor on pizza.codigo = pizzasabor.pizza
            join sabor on sabor.codigo = pizzasabor.sabor
        where
            extract (dow from comanda.data) = 0
            and comanda.data > now() - cast('4 week' as interval)
    );

4) Qual mesa foi mais utilizada nos últimos 60 dias ?
select
    mesa.nome --,count(mesa) as quantidade
from
    mesa
    join comanda on comanda.mesa = mesa.codigo
where
    comanda.data > now() - cast('60 days' as interval)
group by
    1
having
    count(mesa) = (
        select
            max(tabelamaximos.contagem)
        from
            (
                select
                    count(mesa) as contagem,
                    comanda.mesa
                from
                    comanda
                where
                    comanda.data > now() - cast('60 days' as interval)
                group by
                    2
            ) as tabelamaximos
    );

5) Qual mesa foi menos utilizada nos últimos 60 dias ? 
with tabelanula as (
    select
        mesa.codigo --,count(mesa) as quantidade
    from
        mesa
        join comanda on comanda.mesa = mesa.codigo
    where
        mesa.codigo not in (
            select
                mesa.codigo --nao é usada
            from
                pizzasabor
                join pizza on pizza.codigo = pizzasabor.pizza
                join comanda on comanda.numero = pizza.comanda
                join mesa on mesa.codigo = comanda.mesa
            where
                comanda.data > now() - cast('60 days' as interval)
        )
    group by
        1
    order by
        1
)
select
    mesa.nome --,count(mesa) as quantidade
from
    mesa
    join comanda on comanda.mesa = mesa.codigo
where
    case
        when ( --quando tem alguma mesa que nao foi usada
            select count (*)
            from
                tabelanula
             ) > 0 then mesa.codigo not in 
                (
                    select
                        mesa.codigo --nao é usada
                    from
                        pizzasabor
                        join pizza on pizza.codigo = pizzasabor.pizza
                        join comanda on comanda.numero = pizza.comanda
                        join mesa on mesa.codigo = comanda.mesa
                    where
                        comanda.data > now() - cast('60 days' as interval)
                )
        else mesa.codigo in ( --quando nao tem mesa que nao foi utilizada
            select
                mesa.codigo --minima das usadas
            from
                mesa
                join comanda on comanda.mesa = mesa.codigo
            where
                comanda.data > now() - cast('60 days' as interval)
            group by 1
            having
                count(mesa) = (
                    select
                        min(tabelamaximos.contagem)
                    from
                        (
                            select
                                count(mesa) as contagem,
                                comanda.mesa
                            from
                                comanda
                            where
                                comanda.data > now() - cast('60 days' as interval)
                            group by 2
                        ) as tabelamaximos
                )
        )
    end
group by 1
order by 1;

6) Quais mesas foram utilizadas mais de 2 vezes a média de utilização de todas as mesas nos últimos 60 dias ?
select
    mesa.nome as mesa --,count(comanda.numero) as contagem
from
    comanda
    join mesa on mesa.codigo = comanda.mesa
where
    comanda.data > now() - cast('60 days' as interval)
group by
    mesa.nome
having
    count(comanda.mesa) >(
        select
            avg(tabelacontagem.contagem) * 2 as mediax2
        from
            (
                select
                    count(comanda.numero) as contagem,
                    mesa.nome as mesa
                from
                    comanda
                    join mesa on mesa.codigo = comanda.mesa
                where
                    comanda.data > now() - cast('60 days' as interval)
                group by
                    mesa.nome
            ) as tabelacontagem
    );

7) Quais sabores estão entre os 10 mais pedidos no último mês e também no penúltimo mês ?
select
    sabor.nome --, count(pizzasabor.sabor)
from
    sabor
    join pizzasabor on pizzasabor.sabor = sabor.codigo
    join pizza on pizza.codigo = pizzasabor.pizza
    join comanda on comanda.numero = pizza.comanda
where
    comanda.data >= date_trunc('month', current_date - interval '1' month)
group by
    1
having
    count(pizzasabor.sabor) >= (
        select
            min(tabelaultimo.contagem)
        from
            (
                select
                    distinct tabela.contagem
                from
                    (
                        select
                            count(pizzasabor.sabor) as contagem,
                            pizzasabor.sabor
                        from
                            pizzasabor
                            join pizza on pizza.codigo = pizzasabor.pizza
                            join comanda on comanda.numero = pizza.comanda
                        where
                            comanda.data >= date_trunc('month', current_date - interval '1' month)
                        group by
                            2
                        order by
                            1 desc
                    ) as tabela
                order by
                    tabela.contagem desc
                limit
                    10
            ) as tabelaultimo
    )
intersect
(
    select
        tabelapenultimomes.n1
    from
        (
            --penultimo mes
            select
                sabor.nome as n1,
                count(pizzasabor.sabor) --, comanda.data
            from
                sabor
                join pizzasabor on pizzasabor.sabor = sabor.codigo
                join pizza on pizza.codigo = pizzasabor.pizza
                join comanda on comanda.numero = pizza.comanda
            where
                comanda.data >= date_trunc('month', current_date - interval '2' month)
                and comanda.data < date_trunc('month', current_date - interval '1' month)
            group by
                1 --,3
            having
                count(pizzasabor.sabor) >= (
                    select
                        min(tabelaultimo.contagem)
                    from
                        (
                            select
                                distinct tabela.contagem
                            from
                                (
                                    select
                                        count(pizzasabor.sabor) as contagem,
                                        pizzasabor.sabor --, comanda.data
                                    from
                                        pizzasabor
                                        join pizza on pizza.codigo = pizzasabor.pizza
                                        join comanda on comanda.numero = pizza.comanda
                                    where
                                        comanda.data >= date_trunc('month', current_date - interval '2' month)
                                        and comanda.data < date_trunc('month', current_date - interval '1' month)
                                    group by
                                        2 --,3
                                    order by
                                        1 desc
                                ) as tabela
                            order by
                                tabela.contagem desc
                            limit
                                10
                        ) as tabelaultimo
                )
        ) as tabelapenultimomes
);

8) Quais sabores estão entre os 10 mais pedidos no último mês mas não no penúltimo mês ?
select
    sabor.nome --, count(pizzasabor.sabor)
from
    sabor
    join pizzasabor on pizzasabor.sabor = sabor.codigo
    join pizza on pizza.codigo = pizzasabor.pizza
    join comanda on comanda.numero = pizza.comanda
where
    comanda.data >= date_trunc('month', current_date - interval '1' month)
group by
    1
having
    count(pizzasabor.sabor) >= (
        select
            min(tabelaultimo.contagem)
        from
            (
                select
                    distinct tabela.contagem
                from
                    (
                        select
                            count(pizzasabor.sabor) as contagem,
                            pizzasabor.sabor
                        from
                            pizzasabor
                            join pizza on pizza.codigo = pizzasabor.pizza
                            join comanda on comanda.numero = pizza.comanda
                        where
                            comanda.data >= date_trunc('month', current_date - interval '1' month)
                        group by
                            2
                        order by
                            1 desc
                    ) as tabela
                order by
                    tabela.contagem desc
                limit
                    10
            ) as tabelaultimo
    )
except
    (
        select
            pedidosnopenultimomes.n1
        from
            (
                --penultimo mes
                select
                    sabor.nome as n1,
                    count(pizzasabor.sabor) --, comanda.data
                from
                    sabor
                    join pizzasabor on pizzasabor.sabor = sabor.codigo
                    join pizza on pizza.codigo = pizzasabor.pizza
                    join comanda on comanda.numero = pizza.comanda
                where
                    comanda.data >= date_trunc('month', current_date - interval '2' month)
                    and comanda.data < date_trunc('month', current_date - interval '1' month)
                group by
                    1 --,3
                having
                    count(pizzasabor.sabor) >= (
                        select
                            min(tabelapenultimo.contagem)
                        from
                            (
                                select
                                    distinct tabela.contagem
                                from
                                    (
                                        select
                                            count(pizzasabor.sabor) as contagem,
                                            pizzasabor.sabor --, comanda.data
                                        from
                                            pizzasabor
                                            join pizza on pizza.codigo = pizzasabor.pizza
                                            join comanda on comanda.numero = pizza.comanda
                                        where
                                            comanda.data >= date_trunc('month', current_date - interval '2' month)
                                            and comanda.data < date_trunc('month', current_date - interval '1' month)
                                        group by
                                            2 --,3
                                        order by
                                            1 desc
                                    ) as tabela
                                order by
                                    tabela.contagem desc
                                limit
                                    10
                            ) as tabelapenultimo
                    )
            ) as pedidosnopenultimomes
    );

9) Quais sabores não foram pedidos nos últimos 3 meses ? 
with saborespedidos3meses as
(
    select
        sabor.nome as nome--, count(pizzasabor.sabor)
    from
        sabor
        join pizzasabor on pizzasabor.sabor = sabor.codigo
        join pizza on pizza.codigo = pizzasabor.pizza
        join comanda on comanda.numero = pizza.comanda
    where         
        comanda.data >= date_trunc('month', current_date - interval '3' month)
        and date_trunc('month',comanda.data) != date_trunc('month', current_date)
    group by
        1
)
select DISTINCT
        sabor.nome 
    from
        sabor
        join pizzasabor on pizzasabor.sabor = sabor.codigo
        join pizza on pizza.codigo = pizzasabor.pizza
        join comanda on comanda.numero = pizza.comanda
    where sabor.nome not in 
        (
            select * from saborespedidos3meses
        );


10) Quais foram os 3 sabores mais pedidos na última estação do ano ? 
select
    sabor.nome --, count(pizzasabor.sabor)
from
    sabor
    join pizzasabor on pizzasabor.sabor = sabor.codigo
    join pizza on pizza.codigo = pizzasabor.pizza
    join comanda on comanda.numero = pizza.comanda
where
    case 
        when to_char(CURRENT_DATE,'DDMM') between '2103' and '2006' then 
            (
                comanda.data >= make_date( cast(extract(year from current_date)as integer)-1 , 12 , 21)            
                AND
                comanda.data <= make_date( cast(extract(year from current_date)as integer) , 03 , 20)
            )
        when to_char(CURRENT_DATE,'DDMM') between '2106' and '2209' then 
            (
                comanda.data >= make_date( cast(extract(year from current_date)as integer) , 03 , 21)            
                AND
                comanda.data <= make_date( cast(extract(year from current_date)as integer) , 06 , 20)
            )
        when to_char(CURRENT_DATE,'DDMM') between '2309' and '2012' then 
            (
                comanda.data >= make_date( cast(extract(year from current_date)as integer) , 06 , 21)            
                AND
                comanda.data <= make_date( cast(extract(year from current_date)as integer) , 09 , 22)
            )   
        else
            (
                comanda.data >= make_date( cast(extract(year from current_date)as integer) , 09 , 23)            
                AND
                comanda.data <= make_date( cast(extract(year from current_date)as integer) , 12 , 20)
            )                                                        
    end
group by
    1
having
    count(pizzasabor.sabor) >= (
        select
            min(tabelaultimo.contagem)
        from
            (
                select
                    distinct tabela.contagem
                from
                    (
                        select
                            count(pizzasabor.sabor) as contagem,
                            pizzasabor.sabor
                        from
                            pizzasabor
                            join pizza on pizza.codigo = pizzasabor.pizza
                            join comanda on comanda.numero = pizza.comanda
                        where
                            case 
                                when to_char(CURRENT_DATE,'DDMM') between '2103' and '2006' then 
                                    (
                                        comanda.data >= make_date( cast(extract(year from current_date)as integer)-1 , 12 , 21)            
                                        AND
                                        comanda.data <= make_date( cast(extract(year from current_date)as integer) , 03 , 20)
                                    )
                                when to_char(CURRENT_DATE,'DDMM') between '2106' and '2209' then 
                                    (
                                        comanda.data >= make_date( cast(extract(year from current_date)as integer) , 03 , 21)            
                                        AND
                                        comanda.data <= make_date( cast(extract(year from current_date)as integer) , 06 , 20)
                                    )
                                when to_char(CURRENT_DATE,'DDMM') between '2309' and '2012' then 
                                    (
                                        comanda.data >= make_date( cast(extract(year from current_date)as integer) , 06 , 21)            
                                        AND
                                        comanda.data <= make_date( cast(extract(year from current_date)as integer) , 09 , 22)
                                    )   
                                else
                                    (
                                        comanda.data >= make_date( cast(extract(year from current_date)as integer) , 09 , 23)            
                                        AND
                                        comanda.data <= make_date( cast(extract(year from current_date)as integer) , 12 , 20)
                                    )                                                        
                            end
                        group by
                            2
                        order by
                            1 desc
                    ) as tabela
                order by
                    tabela.contagem desc
                limit
                    3
            ) as tabelaultimo
    );


11) Quais foram os 5 ingredientes mais pedidos na última estação do ano ? 

select
    ingrediente.nome--count(saboringrediente.ingrediente)
from
    ingrediente
    join saboringrediente on saboringrediente.ingrediente = ingrediente.codigo
    join sabor on sabor.codigo = saboringrediente.sabor
    join pizzasabor on pizzasabor.sabor = sabor.codigo
    join pizza on pizza.codigo = pizzasabor.pizza
    join comanda on comanda.numero = pizza.comanda
where
case 
    when to_char(CURRENT_DATE,'DDMM') between '2103' and '2006' then 
        (
            comanda.data >= make_date( cast(extract(year from current_date)as integer)-1 , 12 , 21)            
            AND
            comanda.data <= make_date( cast(extract(year from current_date)as integer) , 03 , 20)
        )
    when to_char(CURRENT_DATE,'DDMM') between '2106' and '2209' then 
        (
            comanda.data >= make_date( cast(extract(year from current_date)as integer) , 03 , 21)            
            AND
            comanda.data <= make_date( cast(extract(year from current_date)as integer) , 06 , 20)
        )
    when to_char(CURRENT_DATE,'DDMM') between '2309' and '2012' then 
        (
            comanda.data >= make_date( cast(extract(year from current_date)as integer) , 06 , 21)            
            AND
            comanda.data <= make_date( cast(extract(year from current_date)as integer) , 09 , 22)
        )   
    else
        (
            comanda.data >= make_date( cast(extract(year from current_date)as integer) , 09 , 23)            
            AND
            comanda.data <= make_date( cast(extract(year from current_date)as integer) , 12 , 20)
        )                                                        
    end                         
group by
    1
having
    count(saboringrediente.ingrediente) >= (
        select
            min(tabelaultimo.contagem)
        from
            (
                select distinct tabela.contagem
                from
                    (
                        select
                            count(saboringrediente.ingrediente) as contagem,
                            saboringrediente.ingrediente
                        from
                            saboringrediente
                            join sabor on sabor.codigo = saboringrediente.sabor
                            join pizzasabor on pizzasabor.sabor = sabor.codigo
                            join pizza on pizza.codigo = pizzasabor.pizza
                            join comanda on comanda.numero = pizza.comanda
                        where
                            case 
                                when to_char(CURRENT_DATE,'DDMM') between '2103' and '2006' then 
                                    (
                                        comanda.data >= make_date( cast(extract(year from current_date)as integer)-1 , 12 , 21)            
                                        AND
                                        comanda.data <= make_date( cast(extract(year from current_date)as integer) , 03 , 20)
                                    )
                                when to_char(CURRENT_DATE,'DDMM') between '2106' and '2209' then 
                                    (
                                        comanda.data >= make_date( cast(extract(year from current_date)as integer) , 03 , 21)            
                                        AND
                                        comanda.data <= make_date( cast(extract(year from current_date)as integer) , 06 , 20)
                                    )
                                when to_char(CURRENT_DATE,'DDMM') between '2309' and '2012' then 
                                    (
                                        comanda.data >= make_date( cast(extract(year from current_date)as integer) , 06 , 21)            
                                        AND
                                        comanda.data <= make_date( cast(extract(year from current_date)as integer) , 09 , 22)
                                    )   
                                else
                                    (
                                        comanda.data >= make_date( cast(extract(year from current_date)as integer) , 09 , 23)            
                                        AND
                                        comanda.data <= make_date( cast(extract(year from current_date)as integer) , 12 , 20)
                                    )                                                        
                            end
                        group by
                            2
                        order by
                            1 desc
                    ) as tabela
                order by
                    tabela.contagem desc
                limit
                    5
            ) as tabelaultimo
    );




12) Qual é o percentual atingido de arrecadação com venda de pizzas no ano atual em comparação com o total arrecadado no ano passado ? 
    with somaanoatual as
    (
        select sum(anoatual.preco) as total
                from (
                        select comanda.numero, pizza.codigo,
                                max(case
                                        when borda.preco is null then 0
                                        else borda.preco
                                    end+precoportamanho.preco) as preco
                            from comanda
                                join pizza on pizza.comanda = comanda.numero
                                join pizzasabor on pizzasabor.pizza = pizza.codigo
                                join sabor on pizzasabor.sabor = sabor.codigo
                                join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
                                left join borda on pizza.borda = borda.codigo
                            where extract(year from comanda.data) = extract(year from CURRENT_DATE)
                            group by comanda.numero, pizza.codigo
                    ) as anoatual
    )
    , somaanoanterior as
    (
        select sum(anoanterior.preco) as total
                from (
                        select comanda.numero as comanda, pizza.codigo as pizza,
                                max(case
                                        when borda.preco is null then 0
                                        else borda.preco
                                    end+precoportamanho.preco) as preco
                            from comanda
                                join pizza on pizza.comanda = comanda.numero
                                join pizzasabor on pizzasabor.pizza = pizza.codigo
                                join sabor on pizzasabor.sabor = sabor.codigo
                                join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
                                left join borda on pizza.borda = borda.codigo
                            where cast(extract(year from comanda.data)as integer) = cast(extract(year from current_date)as integer)-1
                            group by comanda.numero, pizza.codigo
                    ) as anoanterior
    )
select 
trunc( (cast((somaanoatual.total/somaanoanterior.total)as numeric)*100), 2 ) || '%' as porcentagem
from somaanoatual, somaanoanterior;




13) Qual dia da semana teve maior arrecadação em pizzas nos últimos 60 dias ?
with ultimos60 as
(
    select comanda.numero as comanda, pizza.codigo as pizza,
            max(case
                    when borda.preco is null then 0
                    else borda.preco
                end+precoportamanho.preco) as preco,
                comanda.data as data                                   
                
        from comanda
            join pizza on pizza.comanda = comanda.numero
            join pizzasabor on pizzasabor.pizza = pizza.codigo
            join sabor on pizzasabor.sabor = sabor.codigo
            join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
            left join borda on pizza.borda = borda.codigo
        where comanda.data > now() - cast('60 days' as interval)                                                    
        group by comanda.numero, pizza.codigo
),  
totalpordia as
(
    select sum(ultimos60.preco) as total, 
        case extract(dow from ultimos60.data)
                when 0 then 'domingo'
                when 1 then 'segunda'
                when 2 then 'terca'
                when 3 then 'quarta'
                when 4 then 'quinta'
                when 5 then 'sexta'
                when 6 then 'sabado'
        end as diadasemana
                    from ultimos60
    group by 2
), 
maximo as (    
                select MAX(totalpordia.total) as max1 from totalpordia                    
          )
select  diadasemana
    from totalpordia, maximo
    where totalpordia.total = maximo.max1;



14) Qual a combinação de 2 sabores mais pedida na mesma pizza nos últimos 3 meses ? 
with pizzas2sabores as
(
    select pizza, 
    array_to_string(array_agg(sabor.nome order by sabor.nome asc), ', ') as sabores
        from pizzasabor
    join sabor on sabor.codigo = pizzasabor.sabor
    join pizza on pizza.codigo = pizzasabor.pizza
    join comanda on comanda.numero = pizza.comanda
    
    where         
        comanda.data >= date_trunc('month', current_date - interval '3' month)
        and date_trunc('month',comanda.data) != date_trunc('month', current_date)
        group by 1
    having count(sabor)=2
    order by sabores
)
select pizzas2sabores.sabores as sabores--,count(pizzas2sabores.sabores) as contagem
        from pizzas2sabores
        group by 1        
        having count(sabores) = 
        (
            select max(contagem) as maximo
            from(
                select count(sabores) as contagem, sabores as sabores
                from pizzas2sabores
                group by 2
                order by 1 desc
            ) as tabmax
        )
;

15) Qual a combinação de 3 sabores mais pedida na mesma pizza nos últimos 3 meses ? 
with pizzas2sabores as
(
    select pizza, 
    array_to_string(array_agg(sabor.nome order by sabor.nome asc), ', ') as sabores
        from pizzasabor
    join sabor on sabor.codigo = pizzasabor.sabor
    join pizza on pizza.codigo = pizzasabor.pizza
    join comanda on comanda.numero = pizza.comanda
    
    where         
        comanda.data >= date_trunc('month', current_date - interval '3' month)
        and date_trunc('month',comanda.data) != date_trunc('month', current_date)
    group by 1
    having count(sabor)=3
    order by sabores
)
select pizzas2sabores.sabores as sabores--,count(pizzas2sabores.sabores) as contagem
        from pizzas2sabores
        group by 1        
        having count(sabores) = 
        (
            select max(contagem) as maximo
            from(
                select count(sabores) as contagem, sabores as sabores
                from pizzas2sabores
                group by 2
                order by 1 desc
            ) as tabmax
        )
;
  
16) Qual a combinação de sabor e borda mais pedida na mesma pizza nos últimos 3 meses ? 
with combinacoes as
(
    select pizza, 
    array_to_string(array_agg(sabor.nome order by sabor.nome asc), ', ') as sabores,
    case
		when borda.nome is null then 'SEM BORDA'
		else borda.nome
	end as borda
        from pizzasabor
    join sabor on sabor.codigo = pizzasabor.sabor
    join pizza on pizza.codigo = pizzasabor.pizza
    join comanda on comanda.numero = pizza.comanda
    left join borda on borda.codigo = pizza.borda    
    where         
        comanda.data >= date_trunc('month', current_date - interval '3' month)        
        and date_trunc('month',comanda.data) != date_trunc('month', current_date)
    group by 1,3    
    order by sabores
)
select count(combinacoes.sabores), combinacoes.sabores, combinacoes.borda
from combinacoes
group by 2,3
having count(combinacoes.sabores)= 
(    
    (
        select max(contagem) as maximo
        from 
        (
            select count(combinacoes.sabores) as contagem , combinacoes.sabores, combinacoes.borda
            from combinacoes
            group by 2,3
        ) as tabmax
    )
)
order by 1 desc;



