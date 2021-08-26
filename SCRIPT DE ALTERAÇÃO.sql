declare 
  quantidade number;
  
  cursor cr_existeendereco (id_pess in number,
                            id_logr in number,
                            c_cep in varchar2,                            
                            c_end in varchar2,
                            c_num in varchar2,
                            c_bairr in varchar2,
                            c_cid in varchar2,
                            c_est in varchar2) is
    select count(1)
      from hssendp
     where NNUMEPESS = id_pess
       and CCEP_ENDP = c_cep
       and NNUMETLOGR = id_logr
       and CENDEENDP  = c_end
       and CNUMEENDP  = c_num
       and CBAIRENDP  = c_bairr
       and CCIDAENDP  = c_cid
       and CESTAENDP  = c_est;
        
begin
  for reg in(select a.nnumepess, b.nnumeendp, ccep_endp, nnumetlogr, cendeendp, cnumeendp, cbairendp, ccompendp, ccidaendp, cestaendp
              --SELECT DISTINCT CCOMPENDP
              from hsspess a, hssendp b
             where a.nnumepess = b.nnumepess
               -- condições
               ) loop
     open cr_cursor(reg.nnumepess, reg.ccep_endp, reg.nnumetlogr, reg.cendeendp, reg.cnumeendp, reg.ccompendp, reg.ccidaendp, reg.cestaendp);
     fetch cr_cursor into quantidade;
     close cr_cursor;  
     
     if (quantidade = 0) then     
       update hssendp set cbairendp = reg.ccompendp, ccompendp = null
       where nnumeendp = reg.nnumeendp 
         and nnumepess = reg.nnumepess;
     else
       DBMS_OUTPUT.put_line('nnumepess: '||reg.nnumepess || '| nnumeendp: ' || reg.nnumeendp || '| ccompendp: ' || reg.ccompendp);
     end if;
  end loop;
end;                  