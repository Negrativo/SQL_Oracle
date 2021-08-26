begin  
  for reg in (
              SELECT distinct a.nnumevcopa, titu.ccodititu codigo_contrato, titu.dconttitu data_contrato,
                     a.nnumecober numero_cobertura, cober.cdesccober nome_cobertura/*, a.nnumevcopa numero_copart_A,
                     b.nnumevcopa numero_copart_B*/, a.dvigevcopa vigencia_copart
                FROM HSSVCOPA a, HSSVCOPA b, hsstitu titu, hsscober cober
               WHERE a.nnumecober = b.nnumecober
                 and a.dvigevcopa = b.dvigevcopa
                 and a.nnumetitu = titu.nnumetitu
                 and b.nnumetitu = titu.nnumetitu
                 and cober.nnumecober = a.nnumecober
                 and cober.nnumecober = b.nnumecober
                 and a.nnumevcopa <> b.nnumevcopa
                 and a.nnumevcopa <> b.nnumevcopa
                 and a.dvigevcopa > '01/01/2021'
                 and titu.nnumeempr is null
                 and titu.csitutitu = 'A'
                 --and titu.ccodititu = 036896
                 and not exists (select * from HSSLOGS where NID__LOGS = a.nnumevcopa) --Somente os que nao contem log  (nao sabe de onde veio)
               order by 1, 2
              ) loop
              
   delete from hssvcopa 
         where nnumevcopa = reg.nnumevcopa;
   
  end loop;
end;