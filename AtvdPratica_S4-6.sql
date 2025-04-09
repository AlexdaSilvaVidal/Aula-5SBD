-- =============================================
-- PARTE 1 - FUNÇÕES DE CARACTERES, NÚMEROS E DATAS
-- =============================================

-- 1. Exiba os nomes dos clientes com todas as letras em maiúsculas
SELECT UPPER(nome) AS nome_maiusculo 
FROM cliente;

-- 2. Exiba os nomes dos clientes formatados com apenas a primeira letra maiúscula
SELECT INITCAP(nome) AS nome_formatado 
FROM cliente;

-- 3. Mostre as três primeiras letras do nome de cada cliente
SELECT SUBSTR(nome, 1, 3) AS tres_primeiras_letras 
FROM cliente;

-- 4. Exiba o número de caracteres do nome de cada cliente
SELECT nome, LENGTH(nome) AS tamanho_nome 
FROM cliente;

-- 5. Apresente o saldo de todas as contas, arredondado para o inteiro mais próximo
SELECT numero_conta, ROUND(saldo) AS saldo_arredondado 
FROM conta;

-- 6. Exiba o saldo truncado, sem casas decimais
SELECT numero_conta, TRUNC(saldo) AS saldo_truncado 
FROM conta;

-- 7. Mostre o resto da divisão do saldo da conta por 1000
SELECT numero_conta, MOD(saldo, 1000) AS resto_divisao 
FROM conta;

-- 8. Exiba a data atual do servidor do banco
SELECT SYSDATE AS data_atual 
FROM dual;

-- 9. Adicione 30 dias à data atual e exiba como "Data de vencimento simulada"
SELECT SYSDATE AS data_atual, 
       SYSDATE + 30 AS "Data de vencimento simulada" 
FROM dual;

-- 10. Exiba o número de dias entre a data de abertura da conta e a data atual
SELECT numero_conta, data_abertura, 
       SYSDATE - data_abertura AS dias_desde_abertura 
FROM conta;


-- =============================================
-- PARTE 2 - CONVERSÃO DE DADOS E TRATAMENTO DE NULOS
-- =============================================

-- 11. Apresente o saldo de cada conta formatado como moeda local
SELECT numero_conta, TO_CHAR(saldo, 'L999G999D99') AS saldo_formatado 
FROM conta;

-- 12. Converta a data de abertura da conta para o formato 'dd/mm/yyyy'
SELECT numero_conta, TO_CHAR(data_abertura, 'dd/mm/yyyy') AS data_formatada 
FROM conta;

-- 13. Exiba o saldo da conta e substitua valores nulos por 0
SELECT numero_conta, NVL(saldo, 0) AS saldo_ajustado 
FROM conta;

-- 14. Exiba os nomes dos clientes e substitua valores nulos na cidade por 'Sem cidade'
SELECT nome, NVL(cidade, 'Sem cidade') AS cidade 
FROM cliente;

-- 15. Classifique os clientes em grupos com base em sua cidade
SELECT nome, cidade,
       CASE 
         WHEN cidade = 'Niterói' THEN 'Região Metropolitana'
         WHEN cidade = 'Resende' THEN 'Interior'
         ELSE 'Outra Região'
       END AS regiao
FROM cliente;


-- =============================================
-- PARTE 3 - JUNÇÕES ENTRE TABELAS
-- =============================================

-- 16. Exiba o nome de cada cliente, o número da conta e o saldo correspondente
SELECT c.nome, co.numero_conta, co.saldo
FROM cliente c
JOIN conta co ON c.id_cliente = co.id_cliente;

-- 17. Liste os nomes dos clientes e os nomes das agências onde mantêm conta
SELECT c.nome AS cliente, a.nome AS agencia
FROM cliente c
JOIN conta co ON c.id_cliente = co.id_cliente
JOIN agencia a ON co.id_agencia = a.id_agencia;

-- 18. Mostre todas as agências, mesmo aquelas que não possuem clientes vinculados
SELECT a.nome AS agencia, c.nome AS cliente
FROM agencia a
LEFT JOIN conta co ON a.id_agencia = co.id_agencia
LEFT JOIN cliente c ON co.id_cliente = c.id_cliente;

