/*
IFPB - SISTEMAS PARA INTERNET
Banco de Dados I - NILTON FREIRE
Projeto de Banco de Dados
Aluno:	Pedro Henrique de Sales Xavier
*/

-- Exclus�es 

DELETE FROM pessoa
WHERE cidade = 'London'

DELETE FROM projeto
WHERE codigo_projeto > 502