 begin 
   for reg in (SELECT HSSATCAD.nnumeatcad
                FROM HSSTITU,HSSEMPR,HSSCONGE, (SELECT ATCAD.*
                                                 FROM HSSATCAD ATCAD,HSSSETOR,HSSATCAD TITULAR 
                                                WHERE ATCAD.NNUMETITU > 0 
                                                  AND ATCAD.NTITUUSUA = TITULAR.NNUMEUSUA(+)
                                                  AND ATCAD.CFLAGATCAD IS NULL 
                                                  AND (TITULAR.CFLAGATCAD IS NULL OR 
                                                       TITULAR.CFLAGATCAD =  'A' OR
                                                       TITULAR.CFLAGATCAD =  'D' OR
                                                       (TITULAR.CFLAGATCAD = 'R' AND TITULAR.CTIPOATCAD <> 'I')) 
                                                 AND ATCAD.NNUMESETOR = HSSSETOR.NNUMESETOR(+)) HSSATCAD
               WHERE HSSTITU.NNUMETITU = HSSATCAD.NNUMETITU
                -- AND CRAZAEMPR LIKE '%ASSOC DOS SERV DA CAM MUN DE CARIACICA. ASCAMCA%'
                 AND (HSSTITU.CSITUTITU NOT IN ('C','M') OR DSITUTITU >= TRUNC(SYSDATE))
                 AND HSSTITU.NNUMEEMPR = HSSEMPR.NNUMEEMPR
                 AND HSSTITU.NNUMECONGE = HSSCONGE.NNUMECONGE(+)
                 AND HSSATCAD.COPERATCAD = 'U'
                 AND NOT EXISTS (SELECT 8 FROM HSSANEXO WHERE HSSANEXO.NNUMEATCAD = HSSATCAD.NNUMEATCAD)) loop
 
   delete from hssatcad 
    where nnumeatcad = reg.nnumeatcad;
   
  end loop;
end;