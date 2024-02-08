#Nome: Ana Laura Angelieri BP3038262

create database if not exists ESCOLAR;
use ESCOLAR;


create table ALUNO(
Nome varchar (50),
Numero_aluno int, 
Tipo_aluno int, 
Curso char(3), 
primary key (Numero_aluno)
);

create table DISCIPLINA(
Nome_disciplina varchar (70), 
Numero_disciplina varchar(10),
Creditos int,
Departamento char(3), 
primary key (Numero_disciplina)
);

create table TURMA(
Identificacao_turma int, 
Numero_disciplina varchar(10),
Semestre varchar(11),
Ano int, 
Professor varchar (20), 
primary key (Identificacao_turma),
foreign key (Numero_disciplina) references DISCIPLINA (Numero_disciplina)
);

create table HISTORICO_ESCOLAR(
Numero_aluno int, 
Identificacao_turma int, 
Nota char(1), 
foreign key (Numero_aluno) references ALUNO (Numero_aluno), 
foreign key (Identificacao_turma) references TURMA (Identificacao_turma)
);

create table PRE_REQUISITO(
Numero_disciplina varchar(10),
Numero_pre_requisito varchar (10),
primary key (Numero_pre_requisito), 
foreign key (Numero_disciplina) references DISCIPLINA (Numero_disciplina)
);

insert into ALUNO 
values ('Silva', 17, 1, 'CC'), 
		('Braga', 8, 2, 'CC');

select * from ALUNO;

insert into DISCIPLINA
values ('Introd. à ciência da computação', 'CC1310', 4, 'CC'), 
		('Estruturas de dados', 'CC3320', 4, 'CC'), 
        ('Matemática discreta', 'MAT2410', 3, 'MAT'), 
        ('Banco de dados', 'CC3380', 3, 'CC');
        
insert into TURMA
values (85, 'MAT2410', 'Segundo', 07, 'Kleber'), 
		(92, 'CC1310', 'Segundo', 07, 'Anderson'), 
        (102, 'CC3380', 'Primeiro', 08, 'Carlos'), 
        (112, 'MAT2410', 'Segundo', 08, 'Chang'),
        (119, 'CC1310', 'Segundo', 08, 'Anderson'), 
        (135, 'CC3380', 'Segundo', 08, 'Santos');
        
select * from TURMA;

insert into HISTORICO_ESCOLAR
values (17, 112, 'B'), 
		(17, 119, 'C'), 
        (8, 85, 'A'), 
        (8, 92, 'A'), 
        (8, 102, 'B'), 
        (8, 135, 'A');
        
select * from HISTORICO_ESCOLAR;

insert into PRE_REQUISITO
values ('CC3380', 'CC3320'), 
		('CC3380', 'MAT2410'), 
        ('CC3320', 'CC1310');
        
select * from PRE_REQUISITO;

#a. Recupere os nomes de todos os alunos sênior se formando em ‘CC’ (Ciência da computação).
select Nome from ALUNO where Curso = 'CC';

#b. Recupere os nomes de todas as disciplinas lecionadas pelo Professor Kleber em 2007 e 2008.
select D.Nome_disciplina, T.Professor from DISCIPLINA D inner join TURMA T on D.Numero_disciplina = T.Numero_disciplina where Professor = 'Kleber' and T.Ano between 07 and 08;

#c. Para cada matéria lecionada pelo Professor Kleber, recupere o número da disciplina,
# semestre, ano e número de alunos que realizaram a matéria.
select T.Numero_disciplina, T.Semestre, T.Ano, count(H.Numero_aluno) from TURMA T inner join HISTORICO_ESCOLAR H on T.Identificacao_turma = H.Identificacao_turma where T.Professor = 'Kleber' group by 1, 2, 3;

#d. Recupere o nome e o histórico de cada aluno sênior (Tipo_aluno = 4) formando em CC.
# Um histórico inclui nome da disciplina, número da disciplina, crédito, semestre, ano e nota para cada disciplina concluída pelo aluno.
select A.Nome, A.Tipo_aluno, D.Nome_disciplina, D.Numero_disciplina, D.Creditos, T.Semestre, T.Ano, H.Nota from ALUNO A 
inner join HISTORICO_ESCOLAR H on A.Numero_aluno = H.Numero_aluno 
inner join TURMA T on H.Identificacao_turma = T.Identificacao_turma
inner join DISCIPLINA D on T.Numero_disciplina = D.Numero_disciplina
where A.Tipo_aluno = 4 and A.Curso = 'CC';

#a. Inserir um novo aluno <‘Alves, 25, 1, ‘MAT’>, no banco de dados.
insert into ALUNO
values ('Alves', 25, 1, 'MAT');

#b. Alterar a turma 112 do aluno ‘Silva’ para 135.
update HISTORICO_ESCOLAR H
inner join ALUNO A on H.Numero_aluno = A.Numero_aluno
set H.Identificacao_turma = 135
where A.Nome = 'Silva' and A.Numero_aluno = 17;

#c. Inserir uma nova disciplina, <‘Engenharia do conhecimento’, ‘CC4390’, 3, ‘CC’>.
insert into DISCIPLINA 
values ('Engenharia do conhecimento', 'CC4390', 3, 'CC');

#d.  Excluir registro do aluno 8 da turma 85.
delete from HISTORICO_ESCOLAR where Numero_aluno = 8 and Identificacao_turma = 85;


        