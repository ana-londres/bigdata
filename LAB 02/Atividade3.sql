-- Usando o código de empresa_dump_pg.sql

-- 3 - SUBCONSULTAS


-- a) OK
SELECT pnome, unome
FROM Empregado e
WHERE EXISTS (
    SELECT 1
    FROM Dependente d
    WHERE d.essn = e.ssn
      AND d.nomedep = e.pnome
      AND d.sexodep = e.sexo
);


-- b) OK
SELECT pnome, unome
FROM Empregado
WHERE salario > (
    SELECT AVG(salario)
    FROM Empregado
    WHERE dno = '5'
);


-- c) OK
SELECT DISTINCT essn
FROM Trabalha t1
WHERE (t1.pno, t1.horas) IN (
    SELECT t2.pno, t2.horas
    FROM Trabalha t2
    WHERE t2.essn = '333445555'
);


-- d) OK
SELECT DISTINCT essn
FROM Trabalha t1
WHERE (t1.pno, t1.horas) IN (
    SELECT t2.pno, t2.horas
    FROM Trabalha t2
    WHERE t2.essn = '333445555'
);


-- e) OK
SELECT e.pnome, e.unome
FROM Empregado e
LEFT JOIN Trabalha t ON e.ssn = t.essn
WHERE t.essn IS NULL;


-- f) OK
SELECT unome
FROM Empregado
WHERE ssn IN (
    SELECT gerssn
    FROM Departamento
)
AND ssn NOT IN (
    SELECT essn
    FROM Dependente
);


-- g) OK
SELECT pnome
FROM Empregado
WHERE ssn IN (
    SELECT gerssn
    FROM Departamento
)
AND ssn IN (
    SELECT essn
    FROM Dependente
);