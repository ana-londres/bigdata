-- Atividade 2 - Lab 02 - Ana Luísa Londres - 20220060649

-- Usando o código de empresa_dump_pg.sql

-- 2 - FUNÇÕES AGREGADAS E NATIVAS

-- a) OK
SELECT AVG(salario) AS media_salarial_feminino
FROM Empregado
WHERE sexo = 'F';


-- b) OK
SELECT superssn, COUNT(*) AS numero_empregados
FROM Empregado
WHERE superssn IS NOT NULL
GROUP BY superssn;


-- c) OK
SELECT MAX(horas) AS maior_horas
FROM trabalha;


-- d) OK
SELECT 
    p.pjnome AS nome_projeto,
    SUM(t.horas) AS total_horas
FROM 
    trabalha t
JOIN 
    projeto p ON t.pno = p.pnumero
GROUP BY 
    p.pjnome;


-- e) OK
SELECT 
    d.dnome AS nome_departamento,
    AVG(e.salario) AS media_salarial
FROM 
    empregado e
JOIN 
    departamento d ON e.dno = d.dnumero
GROUP BY 
    d.dnome;


-- f) OK
SELECT 
    e.pnome || ' ' || e.inicialm || '. ' || e.unome AS nome_completo
FROM 
    empregado e
JOIN (
    SELECT 
        essn
    FROM 
        dependente
    GROUP BY 
        essn
    HAVING 
        COUNT(*) >= 2
) d ON e.ssn = d.essn;


-- g) OK
SELECT 
    d.dnome AS nome_departamento
FROM 
    departamento d
JOIN 
    projeto p ON d.dnumero = p.dnum
GROUP BY 
    d.dnome
ORDER BY 
    COUNT(p.pnumero) ASC
LIMIT 1;


-- h) OK
SELECT 
    pnome || ' ' || unome AS nome,
    SUBSTR(endereco, 10, 13) AS trecho_endereco
FROM 
    empregado;


-- i) OK
SELECT 
    pnome || ' ' || unome AS nome,
    EXTRACT(MONTH FROM datanasc) AS mes_nascimento
FROM 
    empregado;


-- j) OK
SELECT 
    e.pnome || ' ' || e.unome AS nome_empregado,
    d.nomedep,
    d.parentesco,
    EXTRACT(YEAR FROM d.datanascdep) - EXTRACT(YEAR FROM e.datanasc) AS idade_na_epoca
FROM 
    empregado e
JOIN 
    dependente d ON e.ssn = d.essn
WHERE 
    LOWER(d.parentesco) IN ('filho', 'filha');


-- k) OK
SELECT 
    EXTRACT(YEAR FROM datanascdep) AS ano_nascimento,
    COUNT(*) AS quantidade_dependentes
FROM 
    dependente
GROUP BY 
    EXTRACT(YEAR FROM datanascdep)
ORDER BY 
    ano_nascimento;


-- l) OK
SELECT 
    s.pnome || ' ' || s.unome AS nome_supervisor,
    COUNT(e.ssn) AS quantidade_supervisionados
FROM 
    empregado e
JOIN 
    empregado s ON e.superssn = s.ssn
GROUP BY 
    s.pnome, s.unome
HAVING 
    COUNT(e.ssn) >= 2;


-- m) OK
SELECT t.pno AS numero_projeto,
       SUM(e.salario * t.horas / 40) AS valor_mensal
FROM Trabalha t
JOIN Empregado e ON t.essn = e.ssn
GROUP BY t.pno;