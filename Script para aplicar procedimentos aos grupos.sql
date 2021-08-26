declare 
v_contador number;
V_existe number;

cursor cr_tem_procedimento  (pProc in varchar2,
                             pGrup in number) is 

 select count(1)
   from HSSGPCOB
  where HSSGPCOB.NNUMEGRCOB = pGrup
    and HSSGPCOB.CCODIPMED  = pProc;

begin

for reg in (select distinct HSSGPCOB.NNUMEGRCOB, HSSPMED.CCODIPMED
              from HSSGPCOB_DESTINO, HSSPMED, HSSGPCOB
             where HSSGPCOB_DESTINO.Grupo = HSSGPCOB.NNUMEGRCOB 
               and HSSGPCOB_DESTINO.Procedimento = HSSPMED.CCODIPMED
               ) loop
  
    open cr_tem_procedimento(reg.CCODIPMED,reg.NNUMEGRCOB);
    fetch cr_tem_procedimento into V_existe ;
    close cr_tem_procedimento;
    
  if (V_existe > 0) then
     DBMS_OUTPUT.put_line('Ja existe no grupo: '||reg.NNUMEGRCOB||', o procedimento: '||reg.CCODIPMED);    
  else
  insert into HSSGPCOB (NNUMEGRCOB, CCODIPMED)
       values (reg.NNUMEGRCOB, reg.CCODIPMED);
  end if;
 
  v_contador := nvl(v_contador,0) + 1;  
    if mod(v_contador,250) = 0 then
      commit;
      v_contador := 0;
    end if;  
  end loop;
end;


--select * from HSSGPCOB
