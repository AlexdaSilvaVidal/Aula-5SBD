-- =============================================
-- PARTE 1 - JUNÇÕES E PRODUTO CARTESIANO (Seção 7)
-- =============================================

-- 1. Nome do cliente com número da conta (sintaxe Oracle)
SELECT c.nome, co.numero_conta
FROM cliente c, conta co
WHERE c.id_cliente = co.id_cliente;

-- 2. Produto cartesiano de clientes e agências
SELECT c.nome AS cliente, a.nome AS agencia
FROM cliente c, agencia a;

-- 3. Nome dos clientes e cidade da agência (com aliases)
SELECT c.nome AS cliente, a.cidade AS cidade_agencia
FROM cliente c
JOIN conta co ON c.id_cliente = co.id_cliente
JOIN agencia a ON co.id_agencia = a.id_agencia;


-- =============================================
-- PARTE 2 - FUNÇÕES DE GRUPO (Seção 8)
-- =============================================

-- 4. Saldo total de todas as contas
SELECT SUM(saldo) AS saldo_total
FROM conta;

-- 5. Maior saldo e média de saldos
SELECT MAX(saldo) AS maior_saldo, AVG(saldo) AS media_saldos
FROM conta;

-- 6. Quantidade total de contas
SELECT COUNT(*) AS total_contas
FROM conta;

-- 7. Cidades distintas dos clientes
SELECT COUNT(DISTINCT cidade) AS cidades_distintas
FROM cliente;

-- 8. Número da conta e saldo (tratando nulos)
SELECT numero_conta, NVL(saldo, 0) AS saldo
FROM conta;


-- =============================================
-- PARTE 3 - GROUP BY, HAVING E OPERADORES (Seção 9)
-- =============================================

-- 9. Média de saldo por cidade dos clientes
SELECT c.cidade, AVG(co.saldo) AS media_saldo
FROM cliente c
JOIN conta co ON c.id_cliente = co.id_cliente
GROUP BY c.cidade;

-- 10. Cidades com mais de 3 contas
SELECT c.cidade, COUNT(co.numero_conta) AS total_contas
FROM cliente c
JOIN conta co ON c.id_cliente = co.id_cliente
GROUP BY c.cidade
HAVING COUNT(co.numero_conta) > 3;

-- 11. ROLLUP - Total de saldos por cidade da agência e geral
SELECT a.cidade, SUM(co.saldo) AS total_saldo
FROM agencia a
LEFT JOIN conta co ON a.id_agencia = co.id_agencia
GROUP BY ROLLUP(a.cidade);

-- 12. UNION de cidades de clientes e agências (sem repetições)
SELECT cidade FROM cliente
UNION
SELECT cidade FROM agencia;


-- =============================================
-- SEÇÃO 10 - SUBCONSULTAS
-- =============================================

-- PARTE 1 - SUBCONSULTAS DE LINHA ÚNICA

-- 1. Clientes com saldo acima da média
SELECT nome
FROM cliente
WHERE id_cliente IN (
    SELECT id_cliente 
    FROM conta 
    WHERE saldo > (SELECT AVG(saldo) FROM conta)
);

-- 2. Clientes com maior saldo
SELECT nome
FROM cliente
WHERE id_cliente IN (
    SELECT id_cliente 
    FROM conta 
    WHERE saldo = (SELECT MAX(saldo) FROM conta)
);

-- 3. Cidades com mais clientes que a média
SELECT cidade, COUNT(*) AS qtd_clientes
FROM cliente
GROUP BY cidade
HAVING COUNT(*) > (
    SELECT AVG(COUNT(*)) 
    FROM cliente 
    GROUP BY cidade
);


-- PARTE 2 - SUBCONSULTAS MULTILINHA

-- 4. Clientes com saldo entre os 10 maiores
SELECT nome
FROM cliente
WHERE id_cliente IN (
    SELECT id_cliente 
    FROM conta 
    WHERE saldo IN (
        SELECT saldo 
        FROM (
            SELECT saldo 
            FROM conta 
            ORDER BY saldo DESC
        ) WHERE ROWNUM <= 10
    )
);

-- 5. Clientes com saldo menor que todos de Niterói
SELECT nome
FROM cliente
WHERE id_cliente IN (
    SELECT id_cliente 
    FROM conta 
    WHERE saldo < ALL (
        SELECT saldo 
        FROM conta 
        WHERE id_cliente IN (
            SELECT id_cliente 
            FROM cliente 
            WHERE cidade = 'Niterói'
        )
    )
);

-- 6. Clientes com saldo entre os de Volta Redonda
SELECT nome
FROM cliente
WHERE id_cliente IN (
    SELECT id_cliente 
    FROM conta 
    WHERE saldo BETWEEN (
        SELECT MIN(saldo) 
        FROM conta 
        WHERE id_cliente IN (
            SELECT id_cliente 
            FROM cliente 
            WHERE cidade = 'Volta Redonda'
        )
    ) AND (
        SELECT MAX(saldo) 
        FROM conta 
        WHERE id_cliente IN (
            SELECT id_cliente 
            FROM cliente 
            WHERE cidade = 'Volta Redonda'
        )
    )
);


-- PARTE 3 - SUBCONSULTAS CORRELACIONADAS

-- 7. Clientes com saldo acima da média da agência
SELECT c.nome
FROM cliente c
JOIN conta co ON c.id_cliente = co.id_cliente
WHERE co.saldo > (
    SELECT AVG(saldo) 
    FROM conta 
    WHERE id_agencia = co.id_agencia
);

-- 8. Clientes com saldo abaixo da média da cidade
SELECT c.nome, c.cidade
FROM cliente c
JOIN conta co ON c.id_cliente = co.id_cliente
WHERE co.saldo < (
    SELECT AVG(saldo) 
    FROM conta 
    WHERE id_cliente IN (
        SELECT id_cliente 
        FROM cliente 
        WHERE cidade = c.cidade
    )
);


-- PARTE 4 - EXISTS E NOT EXISTS

-- 9. Clientes com pelo menos uma conta
SELECT nome
FROM cliente c
WHERE EXISTS (
    SELECT 1 
    FROM conta 
    WHERE id_cliente = c.id_cliente
);

-- 10. Clientes sem conta
SELECT nome
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1 
    FROM conta 
    WHERE id_cliente = c.id_cliente
);


-- PARTE 5 - CLAUSULA WITH

-- 11. Clientes com saldo acima da média da cidade (usando WITH)
WITH media_cidade AS (
    SELECT c.cidade, AVG(co.saldo) AS media
    FROM cliente c
    JOIN conta co ON c.id_cliente = co.id_cliente
    GROUP BY c.cidade
)
SELECT c.nome, c.cidade, co.saldo, mc.media
FROM cliente c
JOIN conta co ON c.id_cliente = co.id_cliente
JOIN media_cidade mc ON c.cidade = mc.cidade
WHERE co.saldo > mc.media;
