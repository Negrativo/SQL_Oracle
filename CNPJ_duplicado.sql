  select a.nome nome, a.id, b.id
    from (select hsspess.ccnpjpess cnpj,
                 hsspess.cnomepess nome,
                 hsspess.nnumepess id
            from hsspess
           where hsspess.ccnpjpess is not null) a,
         (select hsspess.ccnpjpess cnpj,
                 hsspess.cnomepess nome,
                 hsspess.nnumepess id
            from hsspess
           where hsspess.ccnpjpess is not null) b
   where a.cnpj = b.cnpj
     and a.id <> b.id
     and a.nome = b.nome
     and ('A' in (select SITUACAO FROM TABLE ( PKG_PESSOA.FUN_VINCULOS_PESSOA(a.id)))
          and 'C' in (select SITUACAO FROM TABLE ( PKG_PESSOA.FUN_VINCULOS_PESSOA(b.id)))
          or
          'C' in (select SITUACAO FROM TABLE ( PKG_PESSOA.FUN_VINCULOS_PESSOA(a.id)))
          and 'A' in (select SITUACAO FROM TABLE ( PKG_PESSOA.FUN_VINCULOS_PESSOA(b.id))))
          
          
/*
###############################################################################################
Segunda opção de Query q construi
###############################################################################################
*/

SELECT A.CCNPJPESS, A.NNUMEPESS, B.NNUMEPESS, A.CNOMEPESS, B.CNOMEPESS 
  FROM HSSPESS A, HSSPESS B
 WHERE A.CCNPJPESS = B.CCNPJPESS 
   --AND A.CCNPJPESS = '87001335010094'                                
   AND EXISTS (SELECT 1
                 FROM HSSSETOR
                WHERE HSSSETOR.NNUMEPESS  = B.NNUMEPESS
                  AND HSSSETOR.CSITUSETOR = 'A')
   AND EXISTS (SELECT 1
                 FROM HSSTITU, HSSMCANC
                WHERE (HSSTITU.NNUMEPESS = A.NNUMEPESS OR HSSTITU.NRESFPESS = A.NNUMEPESS)
                  AND HSSTITU.NNUMEMCANC = HSSMCANC.NNUMEMCANC
                  AND HSSTITU.CSITUTITU = 'C')        