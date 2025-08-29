TAREFA 09

ANA LUÍSA LONDRES GOMES LINS - 20220060649




EXERCÍCIO 1:

CREATE KEYSPACE IF NOT EXISTS universidade 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE universidade;



EXERCÍCIO 2:

CREATE TABLE IF NOT EXISTS professores (
    id UUID PRIMARY KEY,
    nome TEXT,
    departamento TEXT,
    -- TIPOS DE COLEÇÃO:
    disciplinas SET<TEXT>,                    -- CONJUNTO
    horarios MAP<TEXT, TEXT>,                 -- MAPA  
    coordenadas TUPLE<DOUBLE, DOUBLE>,        -- TUPLA
    telefones LIST<TEXT>                      -- LISTA
);

CREATE TABLE IF NOT EXISTS alunos (
    id UUID PRIMARY KEY,
    nome TEXT,
    curso TEXT,
    -- TIPOS DE COLEÇÃO:
    habilidades SET<TEXT>,                    -- CONJUNTO
    notas MAP<TEXT, INT>,                     -- MAPA
    endereco TUPLE<TEXT, TEXT, TEXT>,         -- TUPLA
    disciplinas_cursadas LIST<TEXT>           -- LISTA
);


-- inserir 5 linhas em cada tabela:

INSERT INTO professores (id, nome, departamento, disciplinas, horarios, coordenadas, telefones) 
VALUES (uuid(), 'Ana Silva', 'Computação', {'BD', 'IA'}, {'segunda': '8-10', 'quarta': '14-16'}, (-23.5505, -46.6333), ['11-9999-8888', '11-7777-6666']);

INSERT INTO professores (id, nome, departamento, disciplinas, horarios, coordenadas, telefones) 
VALUES (uuid(), 'Carlos Santos', 'Matemática', {'Cálculo', 'Álgebra'}, {'terça': '10-12', 'quinta': '16-18'}, (-23.551, -46.634), ['11-1111-2222']);

INSERT INTO professores (id, nome, departamento, disciplinas, horarios, coordenadas, telefones) 
VALUES (uuid(), 'Maria Oliveira', 'Física', {'Física I', 'Lab Física'}, {'segunda': '14-16', 'sexta': '8-10'}, (-23.552, -46.635), ['11-3333-4444', '11-5555-6666']);

INSERT INTO professores (id, nome, departamento, disciplinas, horarios, coordenadas, telefones) 
VALUES (uuid(), 'João Pereira', 'Química', {'Orgânica', 'Inorgânica'}, {'quarta': '10-12', 'sexta': '14-16'}, (-23.553, -46.636), ['11-7777-8888']);

INSERT INTO professores (id, nome, departamento, disciplinas, horarios, coordenadas, telefones) 
VALUES (uuid(), 'Juliana Costa', 'Biologia', {'Genética', 'Bioquímica'}, {'terça': '14-16', 'quinta': '8-10'}, (-23.554, -46.637), ['11-9999-0000']);

INSERT INTO alunos (id, nome, curso, habilidades, notas, endereco, disciplinas_cursadas) 
VALUES (uuid(), 'Pedro Alves', 'Engenharia', {'Python', 'Java'}, {'BD': 90, 'IA': 85}, ('Rua A', 'São Paulo', 'SP'), ['BD', 'IA', 'Cálculo']);

INSERT INTO alunos (id, nome, curso, habilidades, notas, endereco, disciplinas_cursadas) 
VALUES (uuid(), 'Mariana Lima', 'Medicina', {'Anatomia', 'Bioquímica'}, {'Anatomia': 95, 'Bioquímica': 88}, ('Rua B', 'Rio', 'RJ'), ['Anatomia', 'Bioquímica']);

INSERT INTO alunos (id, nome, curso, habilidades, notas, endereco, disciplinas_cursadas) 
VALUES (uuid(), 'Lucas Souza', 'Direito', {'Direito Civil', 'Constitucional'}, {'Civil': 92, 'Constitucional': 87}, ('Rua C', 'Belo Horizonte', 'MG'), ['Civil', 'Constitucional']);

INSERT INTO alunos (id, nome, curso, habilidades, notas, endereco, disciplinas_cursadas) 
VALUES (uuid(), 'Carla Mendes', 'Administração', {'Gestão', 'Marketing'}, {'Gestão': 89, 'Marketing': 91}, ('Rua D', 'Porto Alegre', 'RS'), ['Gestão', 'Marketing']);

INSERT INTO alunos (id, nome, curso, habilidades, notas, endereco, disciplinas_cursadas) 
VALUES (uuid(), 'Ricardo Oliveira', 'Computação', {'Java', 'Python', 'SQL'}, {'BD': 94, 'IA': 90}, ('Rua E', 'Salvador', 'BA'), ['BD', 'IA', 'Redes']);








EXERCÍCIO 3:

-- SET:

UPDATE professores SET disciplinas = disciplinas + {'Redes'} WHERE nome = 'Ana Silva';
UPDATE professores SET disciplinas = disciplinas - {'IA'} WHERE nome = 'Ana Silva';

-- LIST: 

UPDATE alunos SET disciplinas_cursadas = disciplinas_cursadas + ['SO'] WHERE nome = 'Pedro Alves';
UPDATE alunos SET disciplinas_cursadas[0] = 'Banco de Dados' WHERE nome = 'Pedro Alves';
UPDATE alunos SET disciplinas_cursadas = disciplinas_cursadas - ['Cálculo'] WHERE nome = 'Pedro Alves';

-- MAP:

UPDATE professores SET horarios['sexta'] = '10-12' WHERE nome = 'Ana Silva';
UPDATE professores SET horarios = horarios - ['segunda'] WHERE nome = 'Ana Silva';
UPDATE professores SET horarios['quarta'] = '15-17' WHERE nome = 'Ana Silva';

-- TUPLE:
UPDATE professores SET coordenadas = (-23.5600, -46.6400) WHERE nome = 'Ana Silva';






EXERCÍCIO 4:

-- 1:

SELECT * FROM professores WHERE departamento = 'Computação' ALLOW FILTERING;


-- 2:

CREATE TABLE alunos_por_curso (
    curso TEXT,
    id UUID,
    nome TEXT,
    nota_media DOUBLE,
    PRIMARY KEY (curso, nota_meida)
) WITH CLUSTERING ORDER BY (nota_media DESC);

INSERT INTO alunos_por_curso (curso, id, nome, nota_media) VALUES ('Engenharia', uuid(), 'Pedro', 8.5);
INSERT INTO alunos_por_curso (curso, id, nome, nota_media) VALUES ('Engenharia', uuid(), 'Ana', 9.2);
INSERT INTO alunos_por_curso (curso, id, nome, nota_media) VALUES ('Medicina', uuid(), 'Carlos', 8.8);

SELECT * FROM alunos_por_curso WHERE curso = 'Engenharia' ORDER BY nota_media DESC;

-- 3.

SELECT nome, habilidades FROM alunos WHERE nome = 'Pedro Alves' ALLOW FILTERING;







EXERCÍCIO 5:

CREATE INDEX IF NOT EXISTS idx_professor_depto ON professores (departamento);
CREATE INDEX IF NOT EXISTS idx_aluno_curso ON alunos (curso);

SELECT * FROM professores WHERE departamento = 'Computação';







VERIFICAÇÕES:

DESCRIBE TABLES;

SELECT * FROM professores;

SELECT * FROM alunos;

SELECT * FROM professores WHERE departamento = 'Computação';
SELECT * FROM alunos WHERE curso = 'Engenharia';