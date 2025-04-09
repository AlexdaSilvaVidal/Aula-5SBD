-- =============================================
-- PARTE 1 - RECUPERANDO DADOS (Seção 1)
-- =============================================

-- 1. Exibir todos os dados da tabela de clientes
SELECT * FROM cliente;

-- 2. Exibir apenas nomes e cidades dos clientes
SELECT nome, cidade FROM cliente;

-- 3. Listar todas as contas com número e saldo
SELECT numero_conta, saldo FROM conta;


-- =============================================
-- PARTE 2 - FILTROS, PROJEÇÕES E CONCATENAÇÃO (Seção 2)
-- =============================================

-- 4. Clientes da cidade de Macaé
SELECT nome FROM cliente WHERE cidade = 'Macaé';

-- 5. Clientes com código entre 5 e 15
SELECT id_cliente, nome 
FROM cliente 
WHERE id_cliente BETWEEN 5 AND 15;

-- 6. Clientes de Niterói, Volta Redonda ou Itaboraí
SELECT nome, cidade 
FROM cliente 
WHERE cidade IN ('Niterói', 'Volta Redonda', 'Itaboraí');

-- 7. Clientes com nomes começando com "F"
SELECT nome 
FROM cliente 
WHERE nome LIKE 'F%';

-- 8. Frase concatenada sobre os clientes
SELECT nome || ' mora em ' || cidade || '.' AS "Frase"
FROM cliente;


-- =============================================
-- PARTE 3 - ORDENAÇÕES, OPERADORES LÓGICOS E FUNÇÕES (Seção 3)
-- =============================================

-- 9. Contas com saldo > 9000 ordenadas decrescentemente
SELECT * 
FROM conta 
WHERE saldo > 9000
ORDER BY saldo DESC;

-- 10. Clientes de Nova Iguaçu ou com "Silva" no nome
SELECT nome, cidade
FROM cliente
WHERE cidade = 'Nova Iguaçu' OR nome LIKE '%Silva%';

-- 11. Saldo das contas arredondado
SELECT numero_conta, ROUND(saldo) AS saldo_arredondado
FROM conta;

-- 12. Nomes dos clientes em maiúsculas
SELECT UPPER(nome) AS nome_maiusculo
FROM cliente;

-- 13. Clientes que NÃO são de Teresópolis nem Campos dos Goytacazes
SELECT nome, cidade
FROM cliente
WHERE cidade NOT IN ('Teresópolis', 'Campos dos Goytacazes');
