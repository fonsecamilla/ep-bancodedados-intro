-- 	QUESTAO 2

-- item A
-- Listar o nome dos alunos, o codigo da turma e a nota de todos os alunos do 
-- curso ’Estatistica’ que foram aprovados na disciplina de codigo ’MAC0110’.

SELECT nome, cod_turma, nota
FROM ALUNO NATURAL JOIN HISTORICO
WHERE cod_curso IN (SELECT cod_curso
				   FROM CURSO
				   WHERE nome_curso = 'Estatística')
	  AND cod_disc = 'MAC0110' AND nota >= 5
ORDER BY cod_turma, nome

-- item B
-- Listar o nome da disciplina, codigo da disciplina, codigo da turma,
-- ano e semestre de todas as turmas com 3 ou mais alunos.

SELECT nome, cod_disc, cod_turma, ano, semestre
FROM DISCIPLINA NATURAL JOIN TURMA NATURAL JOIN HISTORICO
GROUP BY nome, cod_disc, cod_turma, ano, semestre
HAVING COUNT(mat_aluno)>=3
ORDER BY ano, semestre, nome

-- item C
-- Listar o nome do professor, nome da disciplina, codigo da disciplina,
-- codigo da turma e media das notas de todas as turmas ofertadas no
-- 2o semestre de 2020.

SELECT nome_prof, nome, cod_disc, cod_turma, AVG(nota)
FROM (SELECT nome AS nome_prof, cod_disc, cod_turma
	  FROM PROFESSOR NATURAL JOIN TURMA
	  WHERE semestre = 2 AND ano = 2020) AS SEGSEM2020
	  NATURAL JOIN DISCIPLINA NATURAL JOIN HISTORICO
GROUP BY nome_prof, nome, cod_disc, cod_turma
ORDER BY nome_prof, nome

-- item D
-- Listar o nome e número de matricula de todos os alunos que já cursaram
-- alguma disciplina que possui pelo menos um pre-requisito.

SELECT DISTINCT nome, mat_aluno
FROM (SELECT cod_disc
	  FROM PRE_REQUISITO NATURAL JOIN DISCIPLINA
	  GROUP BY cod_disc, nome
	  HAVING COUNT(cod_disc_pre_req) >= 1) AS COM_PREREQ
	  NATURAL JOIN HISTORICO NATURAL JOIN ALUNO
ORDER BY nome
