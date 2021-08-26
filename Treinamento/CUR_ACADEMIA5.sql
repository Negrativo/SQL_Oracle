create table curalun5 (
	ncodialun number,
	cnomealun varchar2,
	dnascalun date,
	ddatacada date
	primary key (ncodialun));
	
create table curaula5 (
	ncodiaula number,
	cdescaula varchar2,
	ddatacada date,
	nvalomens number
	primary key (ncodiaula));
	
create table curalau5 (
	ddatainic number
	foreign key ncodialun ref curalun5 (ncodialun),
	foreign key ncodiaula ref curaula5 (ncodiaula));
	
create table curmens5 (
	ncodimens number,
	ddatagera date,
	ddatapaga date,
	foreign key ncodialun ref curalun5 (ncodialun),
	foreign key ncodiaula ref curaula5 (ncodiaula),
	foreign key nvalomens ref curaula5 (nvalomens));
	
create sequence seq_ncodialun 
start with 1
nocache;

create sequence seq_ncodiaula
start with 1
nocache;

create sequence seq_ncodimensa
start with 1
nocache;

create trigger tri_ncodialun
before insert into curalun5
for each row
begin
	if new.ncodialun is null then
	select seq_ncodialun.nextval into: new.ncodialun
	end if;
end;

create trigger tri_ncodiaula
before insert into curaula5
for each row
begin
	if new.ncodiaula is null then
	select seq_ncodiaula.nextval into: new.ncodiaula
	end if;
end;

create trigger tri_ncodimens
before insert into curmens5
for each row
begin
	if new.ncodimens is null then
	select seq_ncodimensa.nextval into: new.ncodimens
	end if;
end;

create procedure stp_cadaalun (
	p_cnomealun in number,
	p_ddatanasc in date) as
begin
	insert into curalun5 (
	cnomealun,
	dnascalun,
	ddatacada)
	values(
	p_cnomealun,
	p_ddatanasc,
	sysdate);
end;

create view vw_cadaalun as
select curalun5.cnomealun , curaula5.cdescaula , curalau5.ddatainic
from  curalau5 , curalun5 , curaula5
where curalun5.ncodialun = curalau5.ncodialun(+)
and   curaula5.ncodiaula = curalau5.ncodiaula(+)

create procedure stp_geramens5 (
	p_datagera in date) as
begin
	for geramens5 is (
	select curalun5.cnomealun , curaula5.ncodiaula , curaula5.cdescaula,
	curalau5.nvalomens
	from  curalau5 , curalun5 , curaula5
	where curalun5.ncodialun = curalau5.ncodialun(+)
	and   curaula5.ncodiaula = curalau5.ncodiaula(+)) loop
	
	insert into curmens5 (
	nvalomens , ncodialun , ncodiaula , cdescaula
	
	
	