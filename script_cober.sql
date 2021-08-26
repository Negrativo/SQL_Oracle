DECLARE
v_contador number;
 
BEGIN 
  
 FOR reg IN (SELECT NNUMETITU 
               FROM HSSTITU
              WHERE NNUMETITU IN ()) LOOP

    FOR reg2 IN (SELECT *
                   FROM HSSCOBER COBER,HSSPLAN, HSSPCOBE, HSSVCOPA
                  WHERE COBER.NNUMEPLAN  = HSSPLAN.NNUMEPLAN
                    AND COBER.NNUMECOBER = HSSPCOBE.NNUMECOBER
                    AND COBER.NNUMECOBER = HSSVCOPA.NNUMECOBER
                    AND NNUMETITU = 31948671
                    AND CSITUCOBER = 'A') LOOP
                
             
      select seq_geral.nextval into v_contador from dual;
      
      reg2.NNUMECOBER := v_contador;
      reg2.NNUMETITU  := reg.NNUMETITU;
      
      INSERT INTO HSSCOBER
           VALUES reg2;
       

      --Inclusao de procedimentos e coparticipação nas coberturas recem inclusas no contrato
      INSERT INTO HSSPCOBE (NNUMECOBER, CCODIPMED)
           VALUES ( reg2.NNUMECOBER, reg2.CCODIPMED);
           
      INSERT INTO HSSVCOPA (NNUMECOBER, DVIGEVCOPA, NCOPAVCOPA, NNUMEVCOPA,
                            NQINIVCOPA, NQFINVCOPA, NVINIVCOPA, NVFINVCOPA,
                            CTIPOVCOPA, CTETOVCOPA, CIRVIVCOPA)
                     VALUES(reg2.NNUMECOBER, reg2.DVIGEVCOPA, reg2.NCOPAVCOPA, reg2.NNUMEVCOPA,
                            reg2.NQINIVCOPA, reg2.NQFINVCOPA, reg2.NVINIVCOPA, reg2.NVFINVCOPA,
                            reg2.CTIPOVCOPA, reg2.CTETOVCOPA, reg2.CIRVIVCOPA)
            
  --hsspcobe
  --hssvcopa

    END LOOP;
  END LOOP;
END;
 
 
 
BEGIN

 FOR reg in (SELECT *
               FROM HSSTITU
              WHERE NNUMETITU IN ()) LOOP
             
            
     
 
