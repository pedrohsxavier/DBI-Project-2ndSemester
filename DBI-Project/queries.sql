/*
IFPB - SISTEMAS PARA INTERNET
Banco de Dados I - NILTON FREIRE
Projeto de Banco de Dados
Aluno:	Pedro Henrique de Sales Xavier
*/

-- Consultas

/* Pessoas que moram em João Pessoa ou Campina Grande */
SELECT * FROM pessoa WHERE cidade in ('João Pessoa', 'Campina Grande')

/* Pessoas que não moram em João Pessoa nem em Campina Grande */
SELECT * FROM pessoa WHERE cidade not in ('João Pessoa', 'Campina Grande')

/* Professores com o salário entre 6000 e 10000 */
SELECT * FROM professor WHERE salario between 6000 and 10000

/* Pessoas que não têm e-mail */
SELECT * FROM pessoa WHERE email is null

/* Pessoas que tenham telefone fixo */
SELECT * FROM pessoa WHERE telefone is not null

/* Pessoas em que o nome comece por M */
SELECT * FROM pessoa WHERE nome like ('M%')

/* Pessoas que não são do sexo feminino */
SELECT * FROM pessoa WHERE sexo not like ('F')

/* Professores ordenados pelo salário */
SELECT * FROM professor order by salario

/* Quantidade de pessoas do sexo feminino */
SELECT count(sexo) as Quantidade FROM pessoa WHERE sexo = 'F'

/* Soma dos salarios dos professores */
SELECT sum(salario) as Soma FROM professor

/* Media de todas as notas dos alunos */
SELECT avg(nota) as Media FROM nota

/* Maior salario entre os professores */
SELECT max(salario) as [Maior salário] FROM professor

/* Menor de todas as notas registradas */
SELECT min(nota) as [Menor nota] FROM nota

/* Quantidade de pessoas por cidade*/
SELECT count(matricula_pessoa) as Quantidade, cidade  FROM pessoa group by cidade

/* Quantidade de pessoas por cidade, onde tenha mais de uma pessoa registrada*/
SELECT count(matricula_pessoa) as Quantidade, cidade FROM pessoa group by cidade having count(matricula_pessoa) > 1


/* Professores e seus respectivos nomes */

select pr.matricula_professor, pe.nome
from professor [pr] join pessoa [pe]
on pr.matricula_professor = pe.matricula_pessoa

select pr.matricula_professor, pe.nome
from professor [pr] left join pessoa [pe]
on pr.matricula_professor = pe.matricula_pessoa
order by pe.nome


/* Todas as pessoas, sendo professores ou não, ordenadas pelo nome*/
select pr.matricula_professor, pe.nome
from professor [pr] right join pessoa [pe]
on pr.matricula_professor = pe.matricula_pessoa
order by pe.nome

 
/* Todas as pessoas, sendo alunos ou não */

select *
from aluno [al] full outer join pessoa [pe]
on al.matricula_aluno = pe.matricula_pessoa
order by pe.nome


/* Matricula e nome dos alunos com nota superior a media de todas as  notas */

select no.matricula_aluno, pe.nome, no.nota
from nota [no] join pessoa [pe]
on no.matricula_aluno = pe.matricula_pessoa
where no.nota > (select avg(nota) from nota)