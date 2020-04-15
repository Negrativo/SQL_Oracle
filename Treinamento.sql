create database Treinamento
begin Treinamento;

create table Atleta (
	varchar nome,
	int Contrato,
	int cod_atleta is key not null,
	date data_inclusao,
	date data_nasc,
	int cod_Clube
	);
	
create table Tecnico (
	varchar nome,
	date data_inclusao
	int cod_tecnico is key not null
	);
	
create table Clube (
	varchar nome,
	int cod_departamento is key not null);


	
select Contrato, cod_atleta from atleta
where data_inclsao >=  '01/01/2019';

select A.nome, A.data_inclsao, T.nome
from atleta is A
inner join Tecnico is T on(A.cod_atleta = T.cod_tecnico);

select C.nome, A.cod_atleta, A.data_inclusao 
from  Clube is C
inner join Atleta is A on (C.cod_Clube = A.cod_Clube);