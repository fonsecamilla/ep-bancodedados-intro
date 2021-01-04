-- 	QUESTAO 2

-- item A

SELECT nome, cod_turma, nota
FROM ALUNO NATURAL JOIN HISTORICO
WHERE cod_curso IN (SELECT cod_curso
				   FROM CURSO
				   WHERE nome_curso = 'Estatística')
	  AND cod_disc = 'MAC0110' AND nota >= 5
ORDER BY cod_turma, nome

-- item B

SELECT nome, cod_disc, cod_turma, ano, semestre
FROM DISCIPLINA NATURAL JOIN TURMA NATURAL JOIN HISTORICO
GROUP BY nome, cod_disc, cod_turma, ano, semestre
HAVING COUNT(mat_aluno)>=3
ORDER BY ano, semestre, nome

-- item C

SELECT nome_prof, nome, cod_disc, cod_turma, AVG(nota)
FROM (SELECT nome AS nome_prof, cod_disc, cod_turma
	  FROM PROFESSOR NATURAL JOIN TURMA
	  WHERE semestre = 2 AND ano = 2020) AS SEGSEM2020
	  NATURAL JOIN DISCIPLINA NATURAL JOIN HISTORICO
GROUP BY nome_prof, nome, cod_disc, cod_turma
ORDER BY nome_prof, nome

-- item D

SELECT DISTINCT nome, mat_aluno
FROM (SELECT cod_disc
	  FROM PRE_REQUISITO NATURAL JOIN DISCIPLINA
	  GROUP BY cod_disc, nome
	  HAVING COUNT(cod_disc_pre_req) >= 1) AS COM_PREREQ
	  NATURAL JOIN HISTORICO NATURAL JOIN ALUNO
ORDER BY nome
