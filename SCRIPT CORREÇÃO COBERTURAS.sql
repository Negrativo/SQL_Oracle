----------------------------------------------------
-- Script aplicação  - EXAMES
----------------------------------------------------
declare

vExiste number;

cursor existe (p_nnumecober in number) is
 SELECT count(1)
   FROM HSSGCOBE
  where nnumecober =  p_nnumecober;


begin
  for cobertura in (  select NNUMECOBER
                        from hsscober
                       where nnumetitu is NOT null
                        and cdesccober like 'EXAMES%'  ) loop
                        
    open existe(cobertura.NNUMECOBER);
    fetch existe into vExiste;
    
    if (vExiste > 0) then
      DBMS_OUTPUT.put_line('Ja existe na cobertura: '||cobertura.NNUMECOBER);
    else
       insert into HSSGCOBE (NNUMEGRCOB,          NNUMECOBER)
                     values (19908380  ,cobertura.NNUMECOBER);
    end if;
    
    close existe;  
  end loop;
end;

----------------------------------------------------
-- Script aplicação  - CONSULTAS
----------------------------------------------------
declare

vExiste number;

cursor existe (p_nnumecober in number) is
 SELECT count(1)
   FROM HSSGCOBE
  where nnumecober =  p_nnumecober;


begin
  for cobertura in (  select NNUMECOBER
                        from hsscober
                       where nnumetitu is NOT null
                        and cdesccober like 'CONSULTAS%'  ) loop
                        
    open existe(cobertura.NNUMECOBER);
    fetch existe into vExiste;
    
    if (vExiste > 0) then
      DBMS_OUTPUT.put_line('Ja existe na cobertura: '||cobertura.NNUMECOBER);
    else
       insert into HSSGCOBE (NNUMEGRCOB,          NNUMECOBER)
                     values (19955608  ,cobertura.NNUMECOBER);
    end if;
    
    close existe;  
  end loop;
end;

----------------------------------------------------
-- Script aplicação  - INTERNACAO
----------------------------------------------------

declare

vExiste number;

cursor existe (p_nnumecober in number) is
 SELECT count(1)
   FROM HSSGCOBE
  where nnumecober =  p_nnumecober;


begin
  for cobertura in (  select NNUMECOBER
                        from hsscober
                       where nnumetitu is NOT null
                        and cdesccober like 'DIARIAS E INTERNA%'  ) loop
                        
    open existe(cobertura.NNUMECOBER);
    fetch existe into vExiste;
    
    if (vExiste > 0) then
      DBMS_OUTPUT.put_line('Ja existe na cobertura: '||cobertura.NNUMECOBER);
    else
       insert into HSSGCOBE (NNUMEGRCOB,          NNUMECOBER)
                     values (19955612  ,cobertura.NNUMECOBER);
    end if;
    
    close existe;  
  end loop;
end;
----------------------------------------------------
-- Script aplicação  - PRONTO SOCORRO
----------------------------------------------------
declare

vExiste number;

cursor existe (p_nnumecober in number) is
 SELECT count(1)
   FROM HSSGCOBE
  where nnumecober =  p_nnumecober;


begin
  for cobertura in (  select NNUMECOBER
                        from hsscober
                       where nnumetitu is NOT null
                        and cdesccober like 'PRONTO SOCORRO%'  ) loop
                        
    open existe(cobertura.NNUMECOBER);
    fetch existe into vExiste;
    
    if (vExiste > 0) then
      DBMS_OUTPUT.put_line('Ja existe na cobertura: '||cobertura.NNUMECOBER);
    else
       insert into HSSGCOBE (NNUMEGRCOB,          NNUMECOBER)
                     values (19955614  ,cobertura.NNUMECOBER);
    end if;
    
    close existe;  
  end loop;
end;


