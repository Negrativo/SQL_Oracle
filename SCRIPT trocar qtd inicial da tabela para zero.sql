declare
  v_quantidade number;
begin
  for reg in (select distinct hssmanu.nnumefeta, hssmanu.nqtdimanu, hssmanu.dvigemanu --add todas as pk na consulta
               from hssmanu,hssfeta,hsstpla
              where hssmanu.nnumefeta = hssfeta.nnumefeta
                and hsstpla.nnumetpla = hssfeta.nnumetpla
                and hssmanu.nqtdimanu = 1
                --and hssfeta.nnumefeta = 3245637
                and cweb_tpla = 'S' 
                order by hssmanu.nnumefeta, hssmanu.dvigemanu ) loop
                

 update hssmanu 
    set nqtdimanu = 0 
   where nnumefeta in reg.nnumefeta,
     and nqtdimanu in reg.nqtdimanu,
     and dvigemanu in reg.dvigemanu;
   --add todas as pk aqui para validação

  v_quantidade := 0;
  if (v_quantidade < 1000) then
      v_quantidade := v_quantidade + 1;
    else
     commit;
     v_quantidade := 0;
    end if;

end loop;
end;


-- para seegunda tabela de precos

declare
  v_quantidade number;
begin
  for reg in (select distinct  HSSPFQTD.Nqinipfqtd, HSSPFQTD.Nnumetpla, HSSPFQTD.Nnumeplan, HSSPFQTD.Dvigepfqtd, NTITUPFQTD
                 from hsstpla, HSSPFQTD
                where HSSPFQTD.nnumetpla = hsstpla.nnumetpla
                  --and HSSPFQTD.nnumeplan = 771
                  and HSSPFQTD.Nqinipfqtd = 1
                  --and HSSPFQTD.NTITUPFQTD = 143.48
                  and cweb_tpla = 'S'
                  order by nnumeplan,dvigepfqtd, ntitupfqtd ) loop
    
    v_quantidade := 0;
     
    update HSSPFQTD 
       set Nqinipfqtd = 0 
     where Nqinipfqtd in reg.Nqinipfqtd
       and Nnumetpla in reg.Nnumetpla
       and Nnumeplan in reg.Nnumeplan
       and Dvigepfqtd in reg.dvigepfqtd;
     
    if (v_quantidade < 1000) then
      v_quantidade := v_quantidade + 1;
    else
     commit;
     v_quantidade := 0;
    end if;
 
  end loop;
end;




  