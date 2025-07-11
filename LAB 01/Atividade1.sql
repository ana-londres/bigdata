-- Atividade 1 - Ana Luísa Londres - 20220060649

-- a) OK
INSERT INTO EMPREGADO
VALUES ('943775543', 'Roberto', 'F', 'Silva', 'M', 'Rua X, 22 – Araucária – PR', '1952-06-21', '888665555', 1, 58000);

-- b) ERRO 23503: Não existe um departamento com dnum = 2. Logo, viola a chave estrangeira dnum REFERENCES DEPARTAMENTO(dnumero) da tabela projeto.
INSERT INTO PROJETO
VALUES ('4', 'ProdutoA', 'Araucaria', '2');

-- c) ERRO 23505: Já existe a chave primária dnumero = 4, pois ela já existe, violando a restrição do departamento_pkey
INSERT INTO DEPARTAMENTO
VALUES ('4', 'Produção', '943775543', '1998-10-01');

-- d) ERRO 23502: O valor de pno não pode ser NULL por ser uma chave primária (), então não deve violar a restrição de integridade. Além disso, o valor do essn não existe na tabela, violando a chave estrangeira essn que referencia EMPREGADO(ssn)
INSERT INTO TRABALHA
VALUES ('677678989', NULL, 40.0);

-- e) OK
INSERT INTO DEPENDENTE
VALUES ('453453453', 'Joao', 'M', '1970-12-12', 'CONJUGE');

-- f) OK
DELETE FROM TRABALHA
WHERE essn = '333445555';

-- g) ERRO 23503: viola a chave estrangeira superssn e gerssn, a qual referenciam EMPREGADO(ssn), e essn também é violada nos casos que é chave estrangeira em TRABALHA e DEPENDENTE. Logo, há múltiplos erros que violam a integridade referencial
DELETE FROM EMPREGADO
WHERE ssn = '987654321';

-- h) ERRO 23503: pnumero está sendo referenciado em TRABALHA e deletar o projeto viola a restrição de integridade referencial de fk_trabalha_projeto
DELETE FROM PROJETO
WHERE pjnome = 'ProdutoX';

-- i) OK
UPDATE DEPARTAMENTO
SET gerssn = '123456789', gerdatainicio = '1999-01-10'
WHERE dnumero = '5';

-- j) OK
UPDATE EMPREGADO
SET superssn = '943775543'
WHERE ssn = '999887777';

-- l) OK
UPDATE TRABALHA
SET horas = 5.0
WHERE essn = '999887777' AND pno = '10';