-- Atividade 1 -Ana Luísa Londres - 20220060649 - LAB 03


-- tabela "aluno"
CREATE TABLE aluno (
    matricula SERIAL PRIMARY KEY,
    curso VARCHAR(100) NOT NULL,
    idade INT NOT NULL,
    cre NUMERIC(4,2),
    disciplinas JSONB,
    data_ingresso TIMESTAMP NOT NULL DEFAULT now(),
    localizacao GEOMETRY(Point, 4326)
);

-- exemplo no campo disciplinas:
--    { "codigo": "MAT101", "nome": "Matemática", "nota": 8.5 },
--    { "codigo": "FIS102", "nome": "Física", "nota": 7.2 }


-- a) 
-- B-tree em 'cre', já que é indicado para comparações de igualdade em campos numéricos
CREATE INDEX idx_aluno_cre ON aluno(cre);


-- b)
-- B-tree em 'idade', já que é indicado para buscas com operadores relacionais (<, >, <=, >=)
CREATE INDEX idx_aluno_idade ON aluno(idade);


-- c) 
-- B-tree composto em 'idade' e 'cre', pois melhora o desempenho de filtros combinados em +1 coluna numérica
CREATE INDEX idx_aluno_idade_cre ON aluno(idade, cre);


-- d) 
-- nenhum índice é necessário, já que operações de agregação (AVG) precisam ler toda a tabela


-- e) 
-- B-tree composto em 'curso' e 'idade', pois otimiza o filtro por curso e agrupamento por idade
CREATE INDEX idx_aluno_curso_idade ON aluno(curso, idade);


-- f)
-- GIN em 'disciplinas', que é um campo JSONB. Ele é necessário para melhorar buscas com operador contém em JSONB
CREATE INDEX idx_aluno_disciplinas_gin ON aluno USING GIN (disciplinas);


-- g)
-- B-tree em 'data_ingresso', por ser indicado para buscas por intervalo de datas, que tendem a ser sequenciais
CREATE INDEX idx_aluno_data_ingresso ON aluno(data_ingresso);


-- h)
-- GiST em 'localizacao', no campo GEOMETRY, pois é necessário para operações espaciais com ST_DWithin
CREATE INDEX idx_aluno_localizacao_gist ON aluno USING GIST (localizacao);