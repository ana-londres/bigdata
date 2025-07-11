-- Atividade 3 - Ana Luísa Londres - 20220060649

-- a)
SELECT E.ssn, E.pnome || ' ' || E.unome AS nome_completo
FROM EMPREGADO E
JOIN EMPREGADO S ON E.superssn = S.ssn
WHERE E.dno <> S.dno;

-- b)
SELECT essn AS ssn, nomedep, parentesco
FROM DEPENDENTE
ORDER BY essn ASC, parentesco DESC;

-- c)
SELECT pnome, unome
FROM EMPREGADO
WHERE superssn = (
  SELECT ssn
  FROM EMPREGADO
  WHERE pnome = 'Joaquim' AND inicialm = 'E' AND unome = 'Brito'
);

-- d)
SELECT DISTINCT P.pnumero, P.pjnome
FROM PROJETO P
JOIN TRABALHA T ON P.pnumero = T.pno
JOIN EMPREGADO E ON T.essn = E.ssn
WHERE E.unome = 'Will'

-- e)
SELECT DISTINCT E.pnome, E.unome
FROM EMPREGADO E
JOIN TRABALHA T ON E.ssn = T.essn
JOIN PROJETO P ON T.pno = P.pnumero
WHERE P.dnum = '5';

-- f)
SELECT DISTINCT E.pnome, E.unome, E.endereco
FROM EMPREGADO E
JOIN TRABALHA T ON E.ssn = T.essn
JOIN PROJETO P ON T.pno = P.pnumero
JOIN DEPARTAMENTO D ON E.dno = D.dnumero
WHERE P.plocal = 'Curitiba'
  AND D.dnumero NOT IN (
    SELECT dnum
    FROM LOCALIZACAO
    WHERE dlocalizacao = 'Curitiba'
  );