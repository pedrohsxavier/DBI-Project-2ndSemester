/*
IFPB - SISTEMAS PARA INTERNET
Banco de Dados I - NILTON FREIRE
Projeto de Banco de Dados
Aluno:	Pedro Henrique de Sales Xavier
*/

CREATE DATABASE DB_Project
GO

USE DB_Project
GO

-- Criação da Tabela Curso
CREATE TABLE curso
(
	codigo_curso	int				NOT NULL,
	nome			varchar(50)		NOT NULL,
	descricao		varchar(500),
	CONSTRAINT curso_pk PRIMARY KEY (codigo_curso)
);

-- Criação da Tabela Projeto
CREATE TABLE projeto
(
	codigo_projeto		int				NOT NULL,
	titulo				varchar(100)	NOT NULL,
	descricao			varchar(300),
	CONSTRAINT projeto_pk PRIMARY KEY (codigo_projeto)
);

-- Criação da Tabela Histórico
CREATE TABLE historico
(
	codigo_historico	smallint		NOT NULL,
	carga_horaria		int				NOT NULL,
	situacao			varchar(20)		NOT NULL,
	codigo_projeto		int				NOT NULL,
	CONSTRAINT	historico_codigo_pk			PRIMARY KEY (codigo_historico),
	CONSTRAINT	historico_carga_horaria_ck	CHECK (carga_horaria > 0),
	CONSTRAINT	historico_codigo_projeto_fk	FOREIGN KEY (codigo_projeto) REFERENCES Projeto (codigo_projeto)
)

-- Criação da Tabela Pessoa
CREATE TABLE pessoa
(
	matricula_pessoa	int				NOT NULL,
	nome				varchar(50)		NOT NULL,
	cpf					varchar(11)		NOT NULL UNIQUE,
	sexo				char(1)			NOT NULL,
	rua					varchar(50)		NOT NULL,
	bairro				varchar(50)		NOT NULL,
	cidade				varchar(50)		NOT NULL,
	cep					varchar(8)		NOT NULL,
	email				varchar(50),
	celular				varchar(9)		NOT NULL,
	telefone			varchar(8),
	
	CONSTRAINT pessoa_pk			PRIMARY KEY (matricula_pessoa),
	CONSTRAINT pessoa_cpf_ck		CHECK (cpf LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CONSTRAINT pessoa_sexo_ck		CHECK (UPPER(sexo) IN ('F','M')),
	CONSTRAINT pessoa_celular_ck	CHECK (LEN(celular) = 9),
	CONSTRAINT pessoa_telefone_ck	CHECK (LEN(telefone) = 8),
	CONSTRAINT pessoa_cep_ck		CHECK (cep LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

-- Criação da Tabela Professor
CREATE TABLE professor
(
	matricula_professor	int			NOT NULL,
	data_admissao		DATE		NOT NULL,
	salario				smallmoney	NOT NULL,
	matricula_lider		int,
	CONSTRAINT matricula_pk					PRIMARY KEY (matricula_professor),
	CONSTRAINT professor_matricula_prof_fk	FOREIGN KEY (matricula_professor) REFERENCES pessoa (matricula_pessoa),
	CONSTRAINT professor_matricula_lider_fk FOREIGN KEY (matricula_lider) REFERENCES professor (matricula_professor)
);

-- Criação da Tabela Disciplina
CREATE TABLE disciplina
(
	codigo_disciplina		varchar(2)	NOT NULL,
	nome					varchar(50) NOT NULL,
	matricula_professor		int			NOT NULL,
	CONSTRAINT disciplina_pk				PRIMARY KEY (codigo_disciplina),
	CONSTRAINT disciplina_ck				CHECK (codigo_disciplina LIKE '[A-Z][A-Z]'),
	CONSTRAINT disciplina_matricula_prof_fk FOREIGN KEY (matricula_professor) REFERENCES professor (matricula_professor)
);

-- Criação da Tabela Turma
CREATE TABLE turma
(
	codigo_disciplina	varchar(2)		NOT NULL,
	codigo_curso		int				NOT NULL,
	ano_semestre		varchar(6)		NOT NULL,
	CONSTRAINT turma_pk						PRIMARY KEY (codigo_disciplina, codigo_curso, ano_semestre),
	CONSTRAINT turma_codigo_disciplina_fk	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina (codigo_disciplina),
	CONSTRAINT turma_codigo_curso_fk		FOREIGN KEY (codigo_curso) REFERENCES curso (codigo_curso),
	CONSTRAINT turma_ano_semestre_ck		CHECK (ano_semestre LIKE '20[1-9][1-9]-[1-2]')
);

-- Criação da Tabela de Relacionamento Ministra
CREATE TABLE ministra
(
	codigo_disciplina	varchar(2),
	codigo_curso		int,
	ano_semestre		varchar(6),
	matricula_professor int,
	CONSTRAINT ministra_pk					PRIMARY KEY (codigo_disciplina, codigo_curso, ano_semestre, matricula_professor),
	CONSTRAINT ministra_turma_fk			FOREIGN KEY (codigo_disciplina, codigo_curso, ano_semestre) REFERENCES turma (codigo_disciplina, codigo_curso, ano_semestre),
	CONSTRAINT ministra_matricula_prof_fk	FOREIGN KEY (matricula_professor) REFERENCES professor (matricula_professor)
);

-- Criação da Tabela Aluno
CREATE TABLE aluno
(
	matricula_aluno int	NOT NULL,
	nota_vestibular int NOT NULL,
	codigo_curso	int NOT NULL,
	CONSTRAINT aluno_pk					PRIMARY KEY (matricula_aluno),
	CONSTRAINT aluno_matricula_aluno_fk FOREIGN KEY (matricula_aluno) REFERENCES pessoa (matricula_pessoa),
	CONSTRAINT aluno_codigo_curso_fk	FOREIGN KEY (codigo_curso) REFERENCES curso (codigo_curso),
	CONSTRAINT nota_vestibular_ck		CHECK (nota_vestibular BETWEEN 500 and 1000)
);

-- Criação da Tabela Associativa Aluno Turma
CREATE TABLE aluno_turma
(
	codigo_disciplina varchar(2)	NOT NULL,
	codigo_curso	  int			NOT NULL,
	ano_semestre	  varchar(6)	NOT NULL,
	matricula_aluno	  int			NOT NULL,
	codigo_projeto	  int			NOT NULL,
	CONSTRAINT aluno_turma_pk					PRIMARY KEY (codigo_disciplina, codigo_curso, ano_semestre, matricula_aluno),
	CONSTRAINT aluno_turma_ta_fk				FOREIGN KEY (codigo_disciplina, codigo_curso, ano_semestre) REFERENCES turma (codigo_disciplina, codigo_curso, ano_semestre),
	CONSTRAINT aluno_turma_matricula_aluno_fk	FOREIGN KEY (matricula_aluno) REFERENCES aluno (matricula_aluno),
	CONSTRAINT aluno_turma_codigo_projeto_fk	FOREIGN KEY (codigo_projeto) REFERENCES projeto (codigo_projeto)
);

-- Criação da Tabela Nota
CREATE TABLE nota
(
	codigo_disciplina	varchar(2)		NOT NULL,
	codigo_curso		int				NOT NULL,
	ano_semestre		varchar(6)		NOT NULL,
	matricula_aluno		int				NOT NULL,
	nota				int DEFAULT 0,
	CONSTRAINT prova_pk				PRIMARY KEY (codigo_disciplina, codigo_curso, ano_semestre, matricula_aluno),
	CONSTRAINT prova_aluno_turma_fk FOREIGN KEY (codigo_disciplina, codigo_curso, ano_semestre, matricula_aluno) REFERENCES aluno_turma (codigo_disciplina, codigo_curso, ano_semestre, matricula_aluno),
	CONSTRAINT prova_nota_ck		CHECK (nota BETWEEN 0 and 100)
);

-- Criação da Tabela de Relacionamento Monitoria
CREATE TABLE monitoria
(
	codigo_disciplina		varchar(2)	NOT NULL,
	codigo_curso			int			NOT NULL,
	ano_semestre			varchar(6)  NOT NULL,
	matricula_aluno			int			NOT NULL,
	matricula_professor		int			NOT NULL,
	CONSTRAINT monitoria_pk					PRIMARY KEY (codigo_disciplina, codigo_curso, ano_semestre, matricula_aluno, matricula_professor),
	CONSTRAINT monitoria_turma_fk			FOREIGN KEY (codigo_disciplina, codigo_curso, ano_semestre) REFERENCES turma (codigo_disciplina, codigo_curso, ano_semestre),
	CONSTRAINT monitoria_matricula_aluno_fk FOREIGN KEY (matricula_aluno) REFERENCES aluno (matricula_aluno),
	CONSTRAINT monitoria_matricula_prof_fk	FOREIGN KEY (matricula_professor) REFERENCES professor (matricula_professor)
);