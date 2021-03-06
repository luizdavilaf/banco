Com base no exemplo de venda abaixo:

--venda 12345 as 15:30:00 de 01/01/2000 -- timestamp e colocado check para n ser futuro
--vendedor 123.456.789-01 Joao Silva -- feito
--cliente 234.567.890-12 Maria Brasil --feito criado codigo_cliente
 item | produto | descricao  | preco  | quantidade | valor  | comissao | bonus
------+---------+------------+--------+------------+--------+----------+-------
    1 |      10 | produto 10 |  $2,00 |          3 |  $6,00 |    0,00% | $0,00
    2 |      20 | produto 20 |  $5,00 |          2 | $10,00 |    2,00% | $0,20
    3 |      30 | produto 30 | $10,00 |          2 | $20,00 |    5,00% | $1,00
    4 |      40 | produto 40 | $45,00 |          2 | $90,00 |   10,00% | $9,00
valor em produtos = $126,00
desconto de 5,00% = $6,30 autorizado pelo gerente 345.678.901-23 Pedro Silva
valor da nota = $119,70
bonus em comissao = $10,20
valor liquido = $109,50

Considerando que:
-- A comissão em vendas máxima de um produto é 30%. -- colocado check
-- O desconto máximo em uma venda é 20%.-- colocado check
-- O cliente pode não se identificar em uma venda. ---colocado codigo_cliente
-- Não são realizadas vendas para menores de 18 anos. --colocado check

Com base no exemplo de contracheque de um vendedor abaixo:

 funcionario    | dependentes | fixo      | comissao | bruto     | inss    | irrf   | liquido
----------------+-------------+-----------+----------+-----------+---------+--------+-----------
 123.456.789-01 |           2 | $2.500,00 |  $500,00 | $3.000,00 | $330,00 | $29,01 | $2.640,99

Considerando que:

a) Cálculo do valor da contribuição para o INSS:
Salário bruto				Contribuição para o INSS
Até $1.693,72				8,00%
De $1.693,73 até $2.822,90	9,00%
De $2.822,91 até $5.645,80	11,00%
Acima de $5.645,80			11,00% (sobre $5.645,80)

b) Cálculo da base de cálculo:
Salário bruto subtraído do valor da contribuição para o INSS e da dedução de R$189,59 por dependente.

c) Cálculo do valor do imposto de renda retido na fonte:
Base de cálculo				Alíquota	Parcela a deduzir
Até $1.903,98				-			-
De $1.903,99 até $2.826,65	7,50%		$142,80
De $2.826,66 até $3.751,05	15,00%		$354,80
De $3.751,06 até $4.664,68	22,50%		$636,13
Acima de $4.664,68			27,50%		$869,36

1) Faça a modelagem mínima necessária e suficiente, no nível mais detalhado, 
para armazenar os dados donegócio descrito acima e responder as questões 3 e 4.
Qualquer pressuposição ou convenção feita deve ser explicitamente detalhada em texto.

--2) Escreva comandos create table, considerando tipos de dados, campos que podem ou não ser nulos, 
--valores padrão, validações, chaves primárias e chaves estrangeiras, para implementar a modelagem da questão 1.

3) Escreva uma instrução SQL para responder cada pergunta:

--3.1) Mostrar o total de vendas (valor da nota) por dia em um dado período de datas.

--3.2) Mostrar o valor total autorizado em descontos por gerente por mês nos últimos 6 meses.

--3.3) Mostrar os vendedores que venderam mais de $1.000,00 em produtos que não tem comissão em um dado mês e ano.

--3.4) Mostrar o faturamento líquido quinzenal em um dado mês e ano.

--3.5) Mostrar os clientes que realizaram mais de 1 compra em cada um dos 3 últimos meses.

--3.6) Mostrar o ranking dos produtos mais vendidos por faixa etária e por gênero em um dado período de datas. 
--Considerar as faixas etárias 18-25, 26-35, 36-45, 46-55, 56-65, 66-75 e 76-.

--3.7) Mostrar o total em vendas (valor da nota) por faixa etária e por gênero dos clientes em um dado período 
--de datas. Considerar as faixas etárias 18-25, 26-35, 36-45, 46-55, 56-65, 66-75 e 76-.

--3.8) Mostrar as 5 vendas de maior valor (valor da nota) em um dado período de datas.

--3.9) Mostrar os vendedores que venderam (valor da nota) mais no penúltimo mês do que no último mês.

--3.10) Mostrar os vendedores por faixa de vendas (valor da nota) nos últimos 3 meses. 
--Considerar as faixas de venda
---$999,99, $1.000,00-$4.999,99, $5.000,00-$9.999,99, $10.000,00-$49.999,99, $50.000,00-$99.999,99 e $100.000,00-.

--3.11) Mostrar um valor sugerido de desconto para uma dada venda, com base na quantidade de compras do cliente 
--nos 6 meses anteriores. Considerar 0,00% de desconto para 0-2 compras, 5,00% para 3-5 compras, 10,00% para 6-10
--compras e 15% para 10- compras.

3.12) Mostrar o contracheque dos vendedores em um dado mês e ano.

3.13) Mostrar o lucro líquido obtido em um dado mês e ano. Considerar o lucro líquido de 
um mês como sendo o somatório do valor das notas naquele mês subtraído dos gastos em 
contracheque de vendedores naquele mês.

3.14) Mostrar o gráfico do lucro líquido por mês para um dado ano conforme o exemplo. 
Considerar cada * proporcional à quantidade de dígitos na parte inteira do maior lucro
líquido mensal naquele ano. Se o maior lucro líquido possuir 1 dígitos na parte inteira,
cada * equivale a $1; 2 dígitos, a $10; 3 dígitos, a $100; e assim por diante.

 mes       | lucro     | grafico
-----------+-----------+---------
 janeiro   | $4.351,13 | ****
 fevereiro | $3.278,20 | ***
 marco     | $6.703,88 | ******
...

3.15) Reajustar em 3,50% o salário fixo dos vendedores que venderam mais de $10.000,00
(valor da nota) em cada um dos últimos 3 meses.

4) Explique porque:

4.1) Não é possível excluir um vendedor demitido.

4.2) É necessário ter um campo preço na tabela produto e outro na tabela item da venda em uma modelagem bem feita.

