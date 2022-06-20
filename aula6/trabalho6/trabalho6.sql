1) Escreva comandos update e delete, utilizando as tabelas criadas e adequadas para auto-locadoras nas listas de exercícios anteriores, para:
a) Excluir a última revisão do Renault Duster 1.6 de placas XYZ 1A34.
delete 
from revisao
where 
veiculo = 'XYZ1A34'
and datarevisao = 
(
    select max(datarevisao)
    from revisao
    where veiculo = 'XYZ1A34'    
)

b) Reajustar o valor da diária dos grupos de carros da filial Rio Grande, dando desconto proporcional à quantidade de locações, nos últimos 6 meses, 
dos carros de cada grupo nesta filial conforme a tabela:
--tive que ajustar a modelagem da locadora,pois nao tinha valor especifico por grupo e filial, os valores estavam apenas na locacao, sendo assim o update seria em dados de locações passadas e finalizadas. O que nao teria sentido.
quantidade
de locações         desconto
100-                1%
60-99               2%
30-59               4%
15-29               8%
0-14                16%

update precocategoriafilial
set valordadiaria = tabdescontos.desconto
from
(
    select cont.categoria as categoria, cont.filial as filial, (
        case
        when cont.contagem < 15 then precocategoriafilial.valordadiaria * 0.84
        when cont.contagem between 15 and 29  then precocategoriafilial.valordadiaria * 0.92
        when cont.contagem between 30 and 59  then precocategoriafilial.valordadiaria * 0.96
        when cont.contagem between 60 and 99  then precocategoriafilial.valordadiaria * 0.98
        when cont.contagem > 100  then precocategoriafilial.valordadiaria * 0.99
        end 
    ) as desconto   
    from
    (
        select count(locacao.veiculo) as contagem, categoriaveiculo.codigocat as categoria, locacao.filialretirada as filial--, categoriaveiculo.valordadiaria as valordadiaria
        from locacao
        join veiculo on veiculo.placa = locacao.veiculo
        join categoriaveiculo on categoriaveiculo.codigocat = veiculo.categoria 
        where locacao.dataretirada >= date_trunc('month', current_date - interval '6' month)
        and date_trunc('month',locacao.dataretirada) != date_trunc('month', current_date)
        and locacao.filialretirada = '12345678911235'
        group by 2,3
    ) cont    
    join precocategoriafilial on precocategoriafilial.filial = cont.filial and precocategoriafilial.categoria = cont.categoria
)tabdescontos
where precocategoriafilial.filial = '12345678911235' and precocategoriafilial.categoria = tabdescontos.categoria;




2) Explique porque:
a) Não é possível excluir os dados de um cliente que faleceu.
Colocaria em risco a integridade referencial do banco. Pois se o cliente tivesse vários registros em tabelas diferentes elas ficariam com o dado cliente em branco.

b) É necessário ter um campo de custo (por dia, por km, etc) na tabela grupo e também na tabela locação em uma modelagem bem feita.
Pois facilitaria a consulta de preços praticados por grupo e filial e consulta de preços de determinadas locacoes. Alem de reforçar a integridade e consistencia dos dados, os valores das locacoes podem ser condicionados e diferentes dos valores padrao da categoria.

c) Não é possível 2 pessoas locarem o mesmo carro ao mesmo tempo utilizando controle de concorrência.
Pois o controle de concorrência evita este tipo de situação. A partir do momento em que um veiculo está selecionado para um update na tabela locacao(por exemplo), outro update com o mesmo veiculo não poderá ser feito.



