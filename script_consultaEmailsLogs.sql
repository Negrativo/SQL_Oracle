BEGIN
  FOR reg IN (SELECT NID__LOGS ID_USER_NNUMEUSUA, HSSUSUA.CCODIUSUA CODIGO_USUA, CANTELOGS EMAIL_ANTERIOR, DDATALOGS DATA_ALTERACAO, CCAMPLOGS LOG 
                FROM HSSLOGS, HSSUSUA
               WHERE HSSUSUA.NNUMEUSUA = HSSLOGS.NID__LOGS
                 AND HSSLOGS.CCAMPLOGS = 'Alteração do email'
                 AND HSSLOGS.CANTELOGS IS NOT NULL
                 AND HSSLOGS.CPOSTLOGS IS NULL
                 AND HSSLOGS.NOPERUSUA IS NULL
                 AND HSSLOGS.CMODULOGS = 'httpd.exe') LOOP
               
               
    UPDATE HSSUSUA
       SET CMAILUSUA = reg.EMAIL_ANTERIOR
     WHERE NNUMEUSUA = reg.ID_USER_NNUMEUSUA;
   
  END LOOP;
END;