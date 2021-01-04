-- QUESTAO 1

CREATE TABLE CURSO(
	cod_curso INT PRIMARY KEY,
	nome_curso VARCHAR(80) NOT NULL,
	duracao INT NOT NULL
);
	
CREATE TABLE ALUNO(
	mat_aluno INT PRIMARY KEY,
	nome VARCHAR(150) NOT NULL,
	data_nasc DATE NOT NULL,
	cidade_nasc VARCHAR(50) NOT NULL,
	uf_nasc CHAR(2) NOT NULL
			CHECK(uf_nasc IN ('AC', 'AL', 'AP', 'AM', 'BA','CE', 'DF', 'ES',
							  'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR',
							  'PE', 'PI', 'RJ', 'RN', 'RS','RO', 'RR', 'SC',
							  'SP', 'SE', 'TO')),
	cod_curso INT NOT NULL,
	FOREIGN KEY(cod_curso) REFERENCES CURSO(cod_curso)
);

CREATE TABLE PROFESSOR(
	nome VARCHAR(150) NOT NULL,
	titulacao CHAR(2) NOT NULL
			  CHECK(titulacao IN ('GR', 'ES', 'ME', 'DR')),
	salario DECIMAL(8,2) NOT NULL,
	mat_prof INT PRIMARY KEY
);

CREATE TABLE DISCIPLINA(
	cod_disc VARCHAR(10) PRIMARY KEY,
	nome VARCHAR(80) NOT NULL UNIQUE,
	qtd_creditos INT NOT NULL
);

CREATE TABLE PRE_REQUISITO(
	cod_disc VARCHAR(10),
	cod_disc_pre_req VARCHAR(10),
	PRIMARY KEY(cod_disc, cod_disc_pre_req),
	FOREIGN KEY(cod_disc) REFERENCES DISCIPLINA(cod_disc),
	FOREIGN KEY(cod_disc_pre_req) REFERENCES DISCIPLINA(cod_disc)
);

CREATE TABLE TURMA(
	cod_turma INT,
	cod_disc VARCHAR(10),
	mat_prof INT NOT NULL,
	ano INT NOT NULL,
	semestre INT NOT NULL
			 CHECK(semestre IN (1,2)),
	PRIMARY KEY(cod_turma, cod_disc),
	FOREIGN KEY(cod_disc) REFERENCES DISCIPLINA(cod_disc),
	FOREIGN KEY(mat_prof) REFERENCES PROFESSOR(mat_prof)
);

CREATE TABLE HISTORICO(
	mat_aluno INT,
	cod_turma INT,
	cod_disc VARCHAR(10),
	nota DECIMAL(4,2),
	PRIMARY KEY(mat_aluno, cod_turma, cod_disc),
	FOREIGN KEY(mat_aluno) REFERENCES ALUNO(mat_aluno),
	FOREIGN KEY(cod_turma, cod_disc) REFERENCES TURMA(cod_turma, cod_disc)
);
