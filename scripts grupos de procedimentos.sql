--Grupo contrato
SELECT * FROM HSSGCOBE
 WHERE NNUMECOBER = :Cobertura

--Procedimento contrato
SELECT * FROM HSSPCOBE
WHERE NNUMECOBER = :Cobertura
ORDER BY CCODIPMED

--Dos planos e contratos são as mesmas tabelas de proced e grupo

/*
Vincular o HSSCOBER  (coberturas) e HSSGRCOB (grupo de coberturas) a tabela HSSGCOBE (grupos dentro das coberturas) que vincula os grupos aos contratos/planos
*/


--Tabelas de BACKUP
--bkp_hssgcobe_444354
--bkp_HSSPCOBE_444354
--bkp_hsscobertitu_444354



--BKP Grupo contrato
create table bkp_hssgcobe_444354 as (
 SELECT * FROM HSSGCOBE)

--BKP Procedimento contrato
create table bkp_HSSPCOBE_444354(NNUMECOBER number,
                                 CCODIPMED varchar2(9), 
                                 NOPERUSUA number,
                                 CCOBCPCOBE varchar2(1),
                                 CFTUSPCOBE varchar2(1))

declare
  v_contador number;
begin
  v_contador := 0;                          
for reg in ( SELECT NNUMECOBER, CCODIPMED, NOPERUSUA, CCOBCPCOBE, CFTUSPCOBE
               FROM HSSPCOBE ) loop
         
insert into bkp_HSSPCOBE_444354 (NNUMECOBER, CCODIPMED, NOPERUSUA, CCOBCPCOBE, CFTUSPCOBE)
  values (reg.NNUMECOBER, reg.CCODIPMED, reg.NOPERUSUA, reg.CCOBCPCOBE, reg.CFTUSPCOBE);
   
    v_contador := nvl(v_contador,0) + 1;  
    if mod(v_contador,500) = 0 then
      commit;
      v_contador := 0;
    end if;  
    end loop;
  commit;        
end;

----------------------------------------------------
-- Script aplicação
----------------------------------------------------

begin
  for cobertura in (  select NNUMECOBER, cdesccober
                        from hsscober
                       where nnumetitu is not null  )  -- is null para PLANOS
  loop
    for grupo in (select NNUMEGRCOB
                    from hssgrcob)
    loop
       insert into HSSGCOBE ( NNUMEGRCOB , NNUMECOBER )
                     values (grupo.NNUMEGRCOB , cobertura.NNUMECOBER);
      -- dbms_output.put_line(grupo.NNUMEGRCOB || ' - ' || cobertura.NNUMECOBER);
    end loop;
  end loop;
end;

SELECT * FROM HSSGCOBE
 WHERE NNUMECOBER = 2887320
delete from HSSGCOBE