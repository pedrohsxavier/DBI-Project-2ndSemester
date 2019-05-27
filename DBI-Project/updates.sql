/*
IFPB - SISTEMAS PARA INTERNET
Banco de Dados I - NILTON FREIRE
Projeto de Banco de Dados
Aluno:	Pedro Henrique de Sales Xavier
*/

-- Atualizações

UPDATE professor
SET matricula_lider = 1015
WHERE matricula_professor = 9657

UPDATE professor
SET salario = salario * 1.10
WHERE SALARIO < 6000

UPDATE nota
SET nota = nota + 5
WHERE nota = 85

UPDATE nota
SET nota = nota + 10
WHERE NOTA < 5