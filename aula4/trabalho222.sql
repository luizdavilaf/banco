1) Escreva comandos select, utilizando as tabelas criadas na lista de exercícios de DDL e DML da semana 2 e adequadas na lista de exercícios de DQL 1 das semanas 3 e 4, para responder as perguntas:
a) auto-locadoras
1) Quais as marcas e modelos em cada grupo de carros?
select categoria, marca, modelo
from veiculo
group by categoria, marca, modelo;

2) Qual o ranking de quantidade de locações em cada grupo de carros no último semestre?
select veiculo.categoria, count(*) as locacoes
from locacao
join veiculo on locacao.veiculo = veiculo.placa
where 
(case 

    when extract(month from current_date) <= 6 then locacao.dataretirada >= date_trunc('year', current_date - interval '2' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =1  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =2  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =3  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =4  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =5  then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =6  then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)
                                                       
                                            end ) 
    when extract(month from current_date) > 6 then 	locacao.dataretirada >= date_trunc('year', current_date - interval '1' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =7  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =8  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =9  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =10  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =11 then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =12 then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)       
                                            end) 	
			end 
)
group by veiculo.categoria
order by count(*) desc;


3) Qual o ranking de quantidade de locações em cada grupo de carros por filial no último semestre?
select filial.nome as filial , veiculo.categoria, count(*) as locacoes
from locacao
join veiculo on locacao.veiculo = veiculo.placa
join filial on filial.cnpj = locacao.filialretirada
where 
(case 

    when extract(month from current_date) <= 6 then locacao.dataretirada >= date_trunc('year', current_date - interval '2' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =1  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =2  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =3  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =4  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =5  then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =6  then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)
                                                       
                                            end ) 
    when extract(month from current_date) > 6 then 	locacao.dataretirada >= date_trunc('year', current_date - interval '1' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =7  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =8  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =9  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =10  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =11 then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =12 then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)       
                                            end) 	
			end 
)
group by filial.nome, veiculo.categoria
order by count(*) desc;

4) Qual o ranking de quantidade de locações por marca e modelo de carro no último semestre?
select veiculo.marca , veiculo.modelo, count(*) as locacoes
from locacao
join veiculo on locacao.veiculo = veiculo.placa
where 
(case 

    when extract(month from current_date) <= 6 then locacao.dataretirada >= date_trunc('year', current_date - interval '2' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =1  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =2  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =3  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =4  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =5  then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =6  then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)
                                                       
                                            end ) 
    when extract(month from current_date) > 6 then 	locacao.dataretirada >= date_trunc('year', current_date - interval '1' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =7  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =8  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =9  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =10  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =11 then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =12 then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)       
                                            end) 	
			end 
)
group by veiculo.marca , veiculo.modelo
order by count(*) desc;

5) Qual o ranking de quantidade de locações por marca e modelo de carro por filial no último semestre?
select filial.nome as filial , veiculo.marca , veiculo.modelo,  count(*) as locacoes
from locacao
join veiculo on locacao.veiculo = veiculo.placa
join filial on filial.cnpj = locacao.filialretirada
where 
(case 

    when extract(month from current_date) <= 6 then locacao.dataretirada >= date_trunc('year', current_date - interval '2' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =1  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =2  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =3  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =4  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =5  then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =6  then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)
                                                       
                                            end ) 
    when extract(month from current_date) > 6 then 	locacao.dataretirada >= date_trunc('year', current_date - interval '1' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =7  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =8  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =9  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =10  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =11 then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =12 then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)       
                                            end) 	
			end 
)
group by veiculo.marca , veiculo.modelo, filial.nome
order by count(*) desc;


6) Qual o ranking da duração das locações em cada grupo de carros no último semestre?
select veiculo.categoria as categoria, sum(dataentrega-dataretirada) as duracao
from locacao
join veiculo on locacao.veiculo = veiculo.placa
where 
(case 

    when extract(month from current_date) <= 6 then locacao.dataretirada >= date_trunc('year', current_date - interval '2' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =1  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =2  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =3  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =4  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =5  then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =6  then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)
                                                       
                                            end ) 
    when extract(month from current_date) > 6 then 	locacao.dataretirada >= date_trunc('year', current_date - interval '1' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =7  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =8  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =9  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =10  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =11 then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =12 then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)       
                                            end) 	
			end 
)
group by categoria
order by categoria, duracao desc;

7) Qual o ranking da duração das locações em cada grupo de carros por filial no último semestre?
select filial.nome as filial ,veiculo.categoria as categoria, sum(dataentrega-dataretirada) as duracao
from locacao
join veiculo on locacao.veiculo = veiculo.placa
join filial on filial.cnpj = locacao.filialretirada
where 
(case 

    when extract(month from current_date) <= 6 then locacao.dataretirada >= date_trunc('year', current_date - interval '2' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =1  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =2  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =3  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =4  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =5  then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =6  then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)
                                                       
                                            end ) 
    when extract(month from current_date) > 6 then 	locacao.dataretirada >= date_trunc('year', current_date - interval '1' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =7  then locacao.dataretirada >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =8  then locacao.dataretirada >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =9  then locacao.dataretirada >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =10  then locacao.dataretirada >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =11 then locacao.dataretirada >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =12 then locacao.dataretirada >= date_trunc('month', current_date - interval '23' month)       
                                            end) 	
			end 
)
group by filial.nome, categoria
order by filial.nome,categoria, duracao desc;

8) Qual o ranking de quantidade de locações em cada grupo de carros por filial para clientes pessoas físicas nos últimos 3 meses?
select veiculo.categoria as categoria, filial.nome as filial , count(codigolocacao) as locacoes
from locacao
join veiculo on locacao.veiculo = veiculo.placa
join filial on filial.cnpj = locacao.filialretirada
join cliente on cliente.documento = locacao.cliente
where lower(cliente.PFPJ) like '%pf%'
and locacao.dataretirada >= date_trunc('month', current_date - interval '3' month)
and locacao.dataretirada < date_trunc('month', current_date)
group by filial.nome, categoria, cliente.pfpj
order by filial.nome, count(*) desc,categoria;

9) Qual o ranking de quantidade de locações em cada grupo de carros por filial para clientes pessoas jurídicas nos últimos 3 meses?
select veiculo.categoria as categoria, filial.nome as filial , count(*) locacoes
from locacao
join veiculo on locacao.veiculo = veiculo.placa
join filial on filial.cnpj = locacao.filialretirada
join cliente on cliente.documento = locacao.cliente
where lower(cliente.PFPJ) like '%pj%'
and locacao.dataretirada >= date_trunc('month', current_date - interval '3' month)
and locacao.dataretirada < date_trunc('month', current_date)
group by filial.nome, categoria, cliente.pfpj
order by filial.nome, count(*) desc,categoria;

10) Qual a quantidade de locações de cada carro nos últimos 3 meses?
select veiculo.placa, count(*) as locacoes
from locacao
join veiculo on locacao.veiculo = veiculo.placa
where locacao.dataretirada >= date_trunc('month', current_date - interval '3' month)
and locacao.dataretirada < date_trunc('month', current_date)
group by 1
order by 2 desc;

11) Qual o valor médio diário das locações em cada grupo de carros?
select 
    sum(valordalocacao)/
    EXTRACT(day FROM sum(dataentrega-dataretirada)) as media,
    veiculo.categoria
from locacao
    join veiculo on locacao.veiculo = veiculo.placa
where dataretirada is not NULL
group by veiculo.categoria;


12) Quais carros disponíveis em cada dada filial possuem 3 das características (câmbio manual,câmbio automático, ar condicionado, direção hidráulica, direção elétrica, vidro elétrico, ...) informadas pelo usuário?
with tabelafinal as (
    select distinct on (veiculo.placa) veiculo.placa as placat1 ,veiculo.modelo as modelot1,  max(locacao.codigolocacao) as ultimalocacao   
    from veiculo    
    full join locacao on veiculo.placa = locacao.veiculo
    join veiculocaracteristica on veiculocaracteristica.veiculo = veiculo.placa
    join caracteristica on caracteristica.codigocaracteristica = veiculocaracteristica.codigocaracteristica
    group by veiculo.placa, veiculo.modelo
    having count(distinct veiculocaracteristica.codigocaracteristica)>3
    except 
        select distinct on (veiculo.placa) veiculo.placa,veiculo.modelo,  max(locacao.codigolocacao) as ultimalocacao       
        from veiculo    
        join locacao on veiculo.placa = locacao.veiculo
        join veiculocaracteristica on veiculocaracteristica.veiculo = veiculo.placa
        join caracteristica on caracteristica.codigocaracteristica = veiculocaracteristica.codigocaracteristica
        where dataentrega is null
        group by veiculo.placa, veiculo.modelo
)
select placat1 as placa, modelot1 as modelo, filial.nome as filial
from tabelafinal
join locacao on locacao.codigolocacao = tabelafinal.ultimalocacao
join filial on filial.cnpj = locacao.filialentrega;


13) Qual o grupo, marca, modelo e placa dos carros disponíveis em cada filial?
with tabelafinal as (
    select distinct on (veiculo.placa) veiculo.placa as placat1 ,veiculo.modelo as modelot1,  max(locacao.codigolocacao) as ultimalocacao   
    from veiculo    
    full join locacao on veiculo.placa = locacao.veiculo
    join veiculocaracteristica on veiculocaracteristica.veiculo = veiculo.placa
    join caracteristica on caracteristica.codigocaracteristica = veiculocaracteristica.codigocaracteristica
    group by veiculo.placa, veiculo.modelo    
    except 
        select distinct on (veiculo.placa) veiculo.placa,veiculo.modelo,  max(locacao.codigolocacao) as ultimalocacao       
        from veiculo    
        join locacao on veiculo.placa = locacao.veiculo
        join veiculocaracteristica on veiculocaracteristica.veiculo = veiculo.placa
        join caracteristica on caracteristica.codigocaracteristica = veiculocaracteristica.codigocaracteristica
        where dataentrega is null
        group by veiculo.placa, veiculo.modelo
)
select veiculo.categoria, veiculo.marca, modelot1 as modelo, placat1 as placa, filial.nome as filial
from tabelafinal
join locacao on locacao.codigolocacao = tabelafinal.ultimalocacao
join filial on filial.cnpj = locacao.filialentrega
join veiculo on veiculo.placa = tabelafinal.placat1
order by 5, 4;

14) Quais grupos de carros possuem mais de 5 carros disponíveis em cada filial?
with tabelafinal as (
    select distinct on (veiculo.placa) veiculo.placa as placat1 ,veiculo.modelo as modelot1,  max(locacao.codigolocacao) as ultimalocacao   
    from veiculo    
    join locacao on veiculo.placa = locacao.veiculo
    join veiculocaracteristica on veiculocaracteristica.veiculo = veiculo.placa
    join caracteristica on caracteristica.codigocaracteristica = veiculocaracteristica.codigocaracteristica
    group by veiculo.placa, veiculo.modelo    
    except 
        select distinct on (veiculo.placa) veiculo.placa,veiculo.modelo,  max(locacao.codigolocacao) as ultimalocacao       
        from veiculo    
        join locacao on veiculo.placa = locacao.veiculo
        join veiculocaracteristica on veiculocaracteristica.veiculo = veiculo.placa
        join caracteristica on caracteristica.codigocaracteristica = veiculocaracteristica.codigocaracteristica
        where dataentrega is null
        group by veiculo.placa, veiculo.modelo
)
select veiculo.categoria, filial.nome as filial
from veiculo
join tabelafinal on veiculo.placa = tabelafinal.placat1
join locacao on locacao.codigolocacao = tabelafinal.ultimalocacao
join filial on filial.cnpj = locacao.filialentrega
group by veiculo.categoria, filial.nome
having count(veiculo.categoria)>5;

15) Quantos carros estão locados (ainda não entregues) em cada grupo de carros em cada filial?
select count(veiculo.categoria) as quantidade,veiculo.categoria, filial.nome as filiallocada
from veiculo
join locacao on locacao.veiculo = veiculo.placa
join filial on filial.cnpj = locacao.filialretirada
where locacao.filialentrega is null
group by veiculo.categoria, filial.nome;


16) Quais grupos de carros tiveram mais de 5 locações por filial nos últimos 90 dias?
select count(veiculo.categoria) as quantidade,veiculo.categoria, filial.nome as filiallocada
from veiculo
join locacao on locacao.veiculo = veiculo.placa
join filial on filial.cnpj = locacao.filialretirada
where locacao.dataretirada >= CURRENT_DATE - 90 
group by veiculo.categoria, filial.nome;


=================================================================================================================================================================================
b) bancos
1) Quais os CPFs e nomes dos clientes que residem em uma cidade mas possuem conta corrente ativa em uma agência de outra cidade?
select  distinct on(cliente.documento)  cliente.documento, cliente.nome
from contacorrente
join cliente on contacorrente.cliente = cliente.documento
join agencia on agencia.codigoagencia = contacorrente.agencia
where contacorrente.datafechamento is null
group by cliente.documento, agencia.cidade,contacorrente.agencia
having agencia.cidade!=cliente.cidade;

2) Quantas contas correntes ativas possuem saldo atual superior a R$10.000,00 em cada agência?
with saldomaior as (
    select    contacorrente.agencia as agencia, contacorrente as contacorrente --count(contacorrente.agencia),,
    from contacorrente
    join lancamento on contacorrente.codconta = lancamento.contacorrente
    group by  contacorrente.agencia, contacorrente
    having sum(valor)>10000
 )
 select count(saldomaior.contacorrente),  saldomaior.agencia
 from saldomaior
 group by agencia;

3) Quais agências contrataram mais de 50 empréstimos com valor superior a R$10.000,00 nos últimos 60 dias?
select agencia
from emprestimo
where valortotal>10000
and datacontratacao >= date_trunc('day', current_date - interval '60' day)
and datacontratacao < date_trunc('day', current_date)
group by agencia
having count(codigoemp)>50;

4) Qual a quantidade de empréstimos contratados por faixa etária (-19, 20-29, 30-39, 40-49, 50-59, 60-69, 70-) por agência nos últimos 36 meses?
select count(emprestimo.codigoemp) as quantidade,
case 
        when extract(year from age(cliente.datanascimento))<=20 then 'até 19'
		when extract(year from age(cliente.datanascimento))between 20 and 29 then '20-29'
		when extract(year from age(cliente.datanascimento))<40 then '30-39'
		when extract(year from age(cliente.datanascimento))<50 then '40-49'
		when extract(year from age(cliente.datanascimento))<60 then '50-59'
		when extract(year from age(cliente.datanascimento))<70 then '60-69'
		when extract(year from age(cliente.datanascimento))>70 then '70 ou mais'
		end as faixaetaria
from cliente
join emprestimo on emprestimo.cliente = cliente.documento
where emprestimo.datacontratacao >= date_trunc('month', current_date - interval '36' month)
and emprestimo.datacontratacao < date_trunc('month', current_date)
group by faixaetaria
order by faixaetaria asc;

5) Qual o valor médio de empréstimos contratados por faixa etária (-19, 20-29, 30-39, 40-49, 50-59,60-69, 70-) por agência nos últimos 36 meses?
select avg(emprestimo.valortotal) as valormedio,
case 
        when extract(year from age(cliente.datanascimento))<=20 then 'até 19'
		when extract(year from age(cliente.datanascimento))between 20 and 29 then '20-29'
		when extract(year from age(cliente.datanascimento))<40 then '30-39'
		when extract(year from age(cliente.datanascimento))<50 then '40-49'
		when extract(year from age(cliente.datanascimento))<60 then '50-59'
		when extract(year from age(cliente.datanascimento))<70 then '60-69'
		when extract(year from age(cliente.datanascimento))>70 then '70 ou mais'
		end as faixaetaria
from cliente
join emprestimo on emprestimo.cliente = cliente.documento
where emprestimo.datacontratacao >= date_trunc('month', current_date - interval '36' month)
and emprestimo.datacontratacao < date_trunc('month', current_date)
group by faixaetaria
order by faixaetaria asc;

6) Quantos clientes atualmente possuem conta corrente ativa e cheque especial em cada agência?
select count(clienteconta.contacorrente) as quantidade, contacorrente.agencia as agencia--clienteconta.contacorrente, chequeespecial.contacorrente
from contacorrente
join clienteconta on clienteconta.contacorrente = contacorrente.codconta
join chequeespecial on chequeespecial.contacorrente = contacorrente.codconta
where contacorrente.datafechamento is not null
group by contacorrente.agencia;

7) Quantos clientes atualmente possuem conta corrente ativa mas não cheque especial em cada agência?

    select count(cliente.nome), cliente.agencia as agencia--clienteconta.contacorrente as conta, cliente.nome as cliente, , chequeespecial.contacorrente
    from clienteconta 
    join contacorrente on contacorrente.codconta = clienteconta.contacorrente
    join chequeespecial on chequeespecial.contacorrente = contacorrente.codconta 
    right join cliente on cliente.documento = clienteconta.cliente
    where chequeespecial.contacorrente is null
    group by cliente.agencia;
   

8) Quantos clientes atualmente possuem conta corrente ativa mas não cartão de crédito em cada agência?

    select count(cliente.nome) as quantidade, cliente.agencia as agencia--clienteconta.contacorrente as conta, cliente.nome as cliente, contacorrente.agencia as agencia, cartaodecredito.cliente
    from clienteconta 
    join contacorrente on contacorrente.codconta = clienteconta.contacorrente
    join cartaodecredito on cartaodecredito.cliente = clienteconta.cliente
    join chequeespecial on chequeespecial.contacorrente = clienteconta.contacorrente 
    right join cliente on cliente.documento = clienteconta.cliente
    where cartaodecredito.numerocartao is null
    group by cliente.agencia;  




9) Quantas contas correntes com 10 ou mais anos de idade foram encerradas no último semestre por agência?
select count(agencia) as quantidade, agencia
from contacorrente
where age(datafechamento, contacorrente.dataaberturacc) > '10 year'
and 
(case 

    when extract(month from current_date) <= 6 then locacao.datafechamento >= date_trunc('year', current_date - interval '2' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =1  then locacao.datafechamento >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =2  then locacao.datafechamento >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =3  then locacao.datafechamento >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =4  then locacao.datafechamento >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =5  then locacao.datafechamento >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =6  then locacao.datafechamento >= date_trunc('month', current_date - interval '23' month)
                                                       
                                            end ) 
    when extract(month from current_date) > 6 then 	locacao.datafechamento >= date_trunc('year', current_date - interval '1' year)
                                            and
                                            (case 
                                                when extract(month from current_date) =7  then locacao.datafechamento >= date_trunc('month', current_date - interval '18' month)
                                                when extract(month from current_date) =8  then locacao.datafechamento >= date_trunc('month', current_date - interval '19' month)
                                                when extract(month from current_date) =9  then locacao.datafechamento >= date_trunc('month', current_date - interval '20' month)
                                                when extract(month from current_date) =10  then locacao.datafechamento >= date_trunc('month', current_date - interval '21' month)
                                                when extract(month from current_date) =11 then locacao.datafechamento >= date_trunc('month', current_date - interval '22' month)
                                                when extract(month from current_date) =12 then locacao.datafechamento >= date_trunc('month', current_date - interval '23' month)       
                                            end) 	
			end 
)
group by agencia;


10) Mostrar o gráfico de barras, como no exemplo, da quantidade média de contas correntes abertas nos últimos 3 meses por cidade onde o cliente reside, sendo cada * equivalente a 10 contas.
cidade        | contas abertas
--------------+----------------
Rio Grande    | **** (43)
Pelotas       | *** (32)
Porto Alegre  | ****** (67)
...
--nao deu tempo
select agencia.cidade as cidade, count(clienteconta.contacorrente) as contasabertas
from agencia
join cliente on agencia.cidade = cliente.cidade
join clienteconta on clienteconta.cliente = cliente.documento
group by agencia.cidade;



=================================================================================================================================================================================
2) Descreva e justifique as adequações/alterações que foram realizadas nas tabelas da lista de
exercícios de DQL 1 das semanas 3 e 4 para que o exercício 1 acima pudesse ser resolvido:
a) auto-locadoras
criei o atributo valordalocacao para separar o valor da forma de pgamento na entidade locacao 
criei a entidade caracteristica para contar as caracteristicas de cada veiculo
considerei o campo filial em veiculos como a filial que o veiculo esta atualmente.
b) bancos
criei o campo datanascimento em cliente




=================================================================================================================================================================================
3) Utilizando a modelagem da pizzaria trabalhada nas semanas 1 e 2, escreva comandos select
para responder as perguntas:
a) Quais ingredientes possui o sabor São Tomé e Príncipe?
select ingrediente.nome as ingrediente
from sabor
	join saboringrediente on saboringrediente.sabor = sabor.codigo
	join ingrediente on saboringrediente.ingrediente = ingrediente.codigo
where lower(sabor.nome) = 'sao tome e principe'
order by 1 asc;


b) Quais sabores contém o ingrediente bacon?
select sabor.nome as sabor
from sabor
    join saboringrediente on saboringrediente.sabor = sabor.codigo
    join ingrediente on saboringrediente.ingrediente = ingrediente.codigo
where lower(ingrediente.nome) = 'bacon'
order by 1 asc;

c) Quais sabores contém os ingredientes bacon e gorgonzola?
select sabor.nome
from sabor
    join saboringrediente as saboringrediente1 on saboringrediente1.sabor = sabor.codigo    
    join ingrediente as ingrediente1 on saboringrediente1.ingrediente = ingrediente1.codigo
    join saboringrediente as saboringrediente2 on saboringrediente2.sabor = sabor.codigo
    join ingrediente as ingrediente2 on saboringrediente2.ingrediente = ingrediente2.codigo
where lower(ingrediente1.nome) = 'bacon'
and lower(ingrediente2.nome) = 'gorgonzola';


d) Quais sabores salgados possuem mais de 8 ingredientes?
select sabor.nome, count(*) as quantidade
from sabor
    join saboringrediente on saboringrediente.sabor = sabor.codigo
    join ingrediente on saboringrediente.ingrediente = ingrediente.codigo
    join tipo on tipo.codigo = sabor.tipo
where lower(tipo.nome) like '%salgadas%'
group by sabor.nome
having count(*)>8;

e) Quais sabores doces possuem mais de 8 ingredientes?
select sabor.nome, count(*) as quantidade
from sabor
    join saboringrediente on saboringrediente.sabor = sabor.codigo
    join ingrediente on saboringrediente.ingrediente = ingrediente.codigo
    join tipo on tipo.codigo = sabor.tipo
where lower(tipo.nome) like '%doces%'
group by sabor.nome
having count(*)>8;

f) Quais sabores foram pedidos mais de 20 vezes no mês passado?
select sabor.nome, count(*) as quantidade
from pizzasabor
    join pizza on pizzasabor.pizza = pizza.codigo
    join sabor on sabor.codigo = pizzasabor.sabor
    join comanda on pizza.comanda = comanda.numero
where data >= date_trunc('month', current_date - interval '1' month)
and data < date_trunc('month', current_date)
group by sabor.nome
having count(*)>20;

g) Quais sabores salgados foram pedidos mais de 20 vezes no mês passado?
select sabor.nome, count(*) as quantidade
from pizzasabor
    join pizza on pizzasabor.pizza = pizza.codigo
    join sabor on sabor.codigo = pizzasabor.sabor
    join comanda on pizza.comanda = comanda.numero
    join tipo on tipo.codigo = sabor.tipo
where data >= date_trunc('month', current_date - interval '1' month)
and data < date_trunc('month', current_date)
and lower(tipo.nome) like '%salgadas%'
group by sabor.nome
having count(*)>20;

h) Quais sabores doces foram pedidos mais de 20 vezes no mês passado?
select sabor.nome, count(*) as quantidade
from pizzasabor
    join pizza on pizzasabor.pizza = pizza.codigo
    join sabor on sabor.codigo = pizzasabor.sabor
    join comanda on pizza.comanda = comanda.numero
    join tipo on tipo.codigo = sabor.tipo
where data >= date_trunc('month', current_date - interval '1' month)
and data < date_trunc('month', current_date)
and lower(tipo.nome) like '%doces%'
group by sabor.nome
having count(*)>20;

i) Qual o ranking dos ingredientes mais pedidos nos últimos 12 meses?
select ingrediente.nome, count(saboringrediente.ingrediente) as quantidade
from pizzasabor
    join pizza on pizzasabor.pizza = pizza.codigo
    join sabor on sabor.codigo = pizzasabor.sabor
    join comanda on pizza.comanda = comanda.numero
    join tipo on tipo.codigo = sabor.tipo
    join saboringrediente on saboringrediente.sabor = sabor.codigo
    join ingrediente on ingrediente.codigo = saboringrediente.ingrediente
where data >= date_trunc('month', current_date - interval '12' month)
and data < date_trunc('month', current_date)
group by ingrediente.nome
order by 2 desc;

j) Qual o ranking dos sabores salgados mais pedidos nos últimos 12 meses por mês?
select (count(sabor.nome)),
       DATE_part('year', comanda.data) AS ano,
       DATE_part('month', comanda.data) AS mes,            
           sabor.nome 
    from pizzasabor
    join pizza on pizzasabor.pizza = pizza.codigo
    join sabor on sabor.codigo = pizzasabor.sabor
    join comanda on pizza.comanda = comanda.numero
    join tipo on tipo.codigo = sabor.tipo
    join saboringrediente on saboringrediente.sabor = sabor.codigo
    join ingrediente on ingrediente.codigo = saboringrediente.ingrediente
    WHERE comanda.data between (current_date - cast('12 month' as interval)) and current_date
    and lower(tipo.nome) like '%salgadas%'
    group by  DATE_part('month', comanda.data), date_part('year', comanda.data), sabor.nome
    order by  date_part('year', comanda.data) desc,DATE_part('month', comanda.data) desc , count(sabor.nome) desc;

k) Qual o ranking dos sabores doces mais pedidos nos últimos 12 meses por mês?
select (count(sabor.nome)),
       DATE_part('year', comanda.data) AS ano,
       DATE_part('month', comanda.data) AS mes,            
           sabor.nome 
    from pizzasabor
    join pizza on pizzasabor.pizza = pizza.codigo
    join sabor on sabor.codigo = pizzasabor.sabor
    join comanda on pizza.comanda = comanda.numero
    join tipo on tipo.codigo = sabor.tipo
    join saboringrediente on saboringrediente.sabor = sabor.codigo
    join ingrediente on ingrediente.codigo = saboringrediente.ingrediente
WHERE comanda.data between (current_date - cast('12 month' as interval)) and current_date
and lower(tipo.nome) like '%doces%'
group by  DATE_part('month', comanda.data), date_part('year', comanda.data), sabor.nome
order by  date_part('year', comanda.data) desc,DATE_part('month', comanda.data) desc , count(sabor.nome) desc;

l) Qual a quantidade de pizzas pedidas por tipo por tamanho nos últimos 6 meses?
select count(*) as quantidade, tipo.nome as tipo , tamanho
from pizza
join pizzasabor on pizza.codigo = pizzasabor.pizza
join tamanho on tamanho.codigo=pizza.tamanho
join sabor on sabor.codigo = pizzasabor.sabor
join tipo on sabor.tipo = tipo.codigo
join comanda on pizza.comanda = comanda.numero
where comanda.data >= date_trunc('month', current_date - interval '6' month)
and comanda.data < date_trunc('month', current_date)
group by tipo.nome, tamanho
order by tamanho desc, tipo.nome ;

m) Qual o ranking dos ingredientes mais pedidos acompanhando cada borda nos últimos 6 meses?
select count(pizza) as quantidade, ingrediente.nome,
case
		when borda.nome is null then 'SEM BORDA'
		else borda.nome
	end as borda
    
from pizza
left join borda on pizza.borda = borda.codigo
join pizzasabor on pizza.codigo = pizzasabor.pizza
join sabor on pizzasabor.sabor = sabor.codigo
join saboringrediente on sabor.codigo = saboringrediente.sabor
join ingrediente on saboringrediente.ingrediente = ingrediente.codigo
join comanda on pizza.comanda = comanda.numero
where comanda.data >= date_trunc('month', current_date - interval '6' month)
and comanda.data < date_trunc('month', current_date)
group by ingrediente.nome, borda.nome
order by quantidade desc;




