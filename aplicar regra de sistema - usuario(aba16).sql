begin
  for reg in(SELECT NNUMECDIRE, ctipocdire
               FROM hsscdire
              WHERE CTIPOCDIRE = 'U') loop
    
   insert into HSSDIRSI (NNUMECDIRE, ctipodirsi)
        values (reg.NNUMECDIRE, reg.CTIPOCDIRE);
  end loop;
end;      
