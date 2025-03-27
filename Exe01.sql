SELECT a.aluno_id, a.nome, a.email 
FROM aluno a
JOIN matricula m ON a.aluno_id = m.aluno_id  
JOIN curso c ON m.curso_id = c.curso_id       
WHERE c.titulo = 'Banco de Dados';

SELECT curso_id, titulo, carga_horaria 
FROM curso
WHERE carga_horaria > 40;

SELECT a.aluno_id, a.nome, a.email 
FROM aluno a
JOIN matricula m ON a.aluno_id = m.aluno_id
WHERE m.nota IS NULL;

SELECT aluno_id, curso_id, data_matricula, nota
FROM matricula
WHERE data_matricula > TO_DATE('2024-01-01', 'YYYY-MM-DD');

SELECT curso_id, titulo, carga_horaria
FROM curso
WHERE carga_horaria BETWEEN 30 AND 60;

SELECT aluno_id, nome, email
FROM aluno
WHERE email LIKE '%@gmail.com';

