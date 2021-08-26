declare 
  quantidade number;
  
  cursor cr_existeendereco (id_pess in number,
                            c_cep in varchar2,
                            id_logr in number,
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
               and cbairendp is null
               and ccompendp is not null
               and b.cstatendp <> 'I'
               and not exists (select 1 from hssendp c where c.nnumeendp = b.nnumeendp and ccompendp like '%APTO%')
               and not exists (select 1 from hssendp c where c.nnumeendp = b.nnumeendp and ccompendp like '%AP %')
               and not exists (select 1 from hssendp c where c.nnumeendp = b.nnumeendp and ccompendp like '%CASA%')
               and not exists (select 1 from hssendp c where c.nnumeendp = b.nnumeendp and ccompendp like '%apto%')
               and not exists (select 1 from hssendp c where c.nnumeendp = b.nnumeendp and ccompendp like '%SALA %')      
               and not exists (select 1 from hssendp c where c.nnumeendp = b.nnumeendp and ccompendp like '%sala %')
               and not exists (select 1 from hssendp c where c.nnumeendp = b.nnumeendp and ccompendp like '%-%')
               and not exists (select 1 from hssendp c where c.nnumeendp = b.nnumeendp and ccompendp like '%@%')         
               and not exists (select 1 from hssendp c where c.nnumeendp = b.nnumeendp and ccompendp like '%KM %')) loop
     open cr_existeendereco(reg.nnumepess, reg.ccep_endp, reg.nnumetlogr, reg.cendeendp, reg.cnumeendp, reg.ccompendp, reg.ccidaendp, reg.cestaendp);
     fetch cr_existeendereco into quantidade;
     close cr_existeendereco;  
     
     if (quantidade = 0) then     
       update hssendp set cbairendp = reg.ccompendp, ccompendp = null where nnumeendp = reg.nnumeendp and nnumepess = reg.nnumepess;
     else
       DBMS_OUTPUT.put_line('nnumepess: '||reg.nnumepess || '| nnumeendp: ' || reg.nnumeendp || '| ccompendp: ' || reg.ccompendp);
     end if;
  end loop;
end;                  






begin
  for reg in(select hssmanu.nnumefeta
               from hssmanu,hssfeta,hsstpla
              where hssmanu.nnumefeta = hssfeta.nnumefeta
                and hsstpla.nnumetpla = hssfeta.nnumetpla
                and hssmanu.nqtdimanu = 1
                and cweb_tpla = 'S'   ) loop
                
 DBMS_OUTPUT.put_line('PRE UPDATE - nnumefeta: '||reg.nnumefeta || '| nqtdimanu: ' reg.nqtdimanu);
  
  update hssmanu set nqtdimanu = 0
   where nnumefeta in reg.nnumefeta; 
 
 DBMS_OUTPUT.put_line('POS UPDATE - nnumefeta: '||reg.nnumefeta || '| nqtdimanu: ' reg.nqtdimanu);
 
end loop;
end;