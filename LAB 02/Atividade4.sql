-- Usando o código de empresa_dump_pg.sql

-- 4 - VISÕES


-- a) OK
CREATE VIEW TRABALHA_EM AS
SELECT e.pnome, e.unome, p.pjnome, t.horas
FROM EMPREGADO e
JOIN TRABALHA t ON e.ssn = t.essn
JOIN PROJETO p ON t.pno = p.pnumero;


-- b) OK
-- -> b.1: consulta na visão de a)
SELECT pnome, unome
FROM TRABALHA_EM
WHERE pjnome = 'ProdutoX';

-- -> b.2: alteração na tabela + impacto na visão
UPDATE EMPREGADO
SET unome = 'Silva'
WHERE pnome = 'Joao' AND unome = 'Souza';


-- c) OK
DROP VIEW TRABALHA_EM;


-- d) OK
CREATE MATERIALIZED VIEW DEPTO_INFO AS
SELECT d.dnome, COUNT(e.ssn) AS total_empregados, SUM(e.salario) AS soma_salarios
FROM DEPARTAMENTO d
JOIN EMPREGADO e ON d.dnumero = e.dno
GROUP BY d.dnome;


-- e) OK
-- -> e.1: criação de consulta na visão do item d)
SELECT *
FROM DEPTO_INFO
ORDER BY soma_salarios DESC;

-- -> e.2: alterações na tabela
UPDATE EMPREGADO
SET salario = 60000
WHERE ssn = '333445555';

-- -> e.3: demonstração do uso de refresh
REFRESH MATERIALIZED VIEW DEPTO_INFO;


-- f) OK
-- obs: criando novamente a visão TRABALHA_EM
CREATE VIEW TRABALHA_EM AS
SELECT e.pnome, e.unome, p.pjnome, t.horas
FROM EMPREGADO e
JOIN TRABALHA t ON e.ssn = t.essn
JOIN PROJETO p ON t.pno = p.pnumero;

-- f.1: UPDATE na visão TRABALHA_EM
--      ERRO: a view TRABALHA_EM é baseada em múltiplas tabelas com JOIN e não é atualizável diretamente.
UPDATE TRABALHA_EM
SET horas = 40
WHERE pnome = 'Jussara' AND pjnome = 'ProdutoY';

-- f.2: DELETE na visão TRABALHA_EM
--      ERRO: não é possível deletar diretamente de views com múltiplos JOINs.
DELETE FROM TRABALHA_EM
WHERE pnome = 'Ricardo' AND pjnome = 'ProdutoZ';

-- f.3: INSERT na visão TRABALHA_EM
--      ERRO: a view é complexa e não permite inserções diretas, além de os dados não existirem nas tabelas base.
INSERT INTO TRABALHA_EM (pnome, unome, pjnome, horas)
VALUES ('Marina', 'Costa', 'Automatizacao', 15);

-- f.4: UPDATE na visão DEPTO_INFO
--      ERRO: a view DEPTO_INFO é uma MATERIALIZED VIEW com colunas agregadas e não pode ser atualizada diretamente.
UPDATE DEPTO_INFO
SET total_empregados = 10
WHERE dnome = 'Sede Administrativa';

-- f.5: DELETE na visão DEPTO_INFO
--      ERRO: views materializadas com agregações não permitem deleções diretas.
DELETE FROM DEPTO_INFO
WHERE dnome = 'Pesquisa';

-- f.6: INSERT na visão DEPTO_INFO
--      ERRO: não é possível inserir diretamente em uma MATERIALIZED VIEW com agregações.
INSERT INTO DEPTO_INFO (dnome, total_empregados, soma_salarios)
VALUES ('Comercial', 3, 75000);

-- f.7: REFRESH MATERIALIZED VIEW na visão DEPTO_INFO
-- Atualiza os dados armazenados da view com base nas tabelas EMPREGADO e DEPARTAMENTO.
REFRESH MATERIALIZED VIEW DEPTO_INFO;

-- Conclusão:
-- A visão TRABALHA_EM é uma VIEW comum baseada em múltiplos JOINs entre tabelas, o que a torna não atualizável
-- automaticamente. O PostgreSQL não consegue determinar, por si só, como aplicar comandos INSERT, UPDATE ou DELETE
-- em uma estrutura que envolve várias tabelas e, por isso, todas essas operações falham nessa view.
-- 
-- Já DEPTO_INFO é uma MATERIALIZED VIEW baseada em funções de agregação com GROUP BY. Ela também não permite os mesmos
-- comandos diretamente, mas por conta de seus dados serem agregados e representarem resumos, e não tuplas diretamente modificáveis.
-- No entanto, como é uma materialized view, ela pode ser atualizada indiretamente com o comando REFRESH MATERIALIZED VIEW, o que não é possível em TRABALHA_EM.


-- g) OK
DROP VIEW IF EXISTS TRABALHA_EM;
DROP MATERIALIZED VIEW IF EXISTS DEPTO_INFO;