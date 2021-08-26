--fazer tratativas dos campos que serao alterados, pois tem campo preenchido com espaço, entre outros
declare
  v_contador number;

begin
  v_contador := 0;

  for reg in ( select hssusua.crageusua , hssusua.crcc_usua , hssusua.cnomeusua , hsstitu.ccodititu, hssusua.nnumeusua
                 from hssusua, hssplan, hsstitu
                where hssplan.ccodiplan = 8200
                  and hssplan.nnumeplan = hsstitu.nnumeplan
                  and hssusua.nnumetitu = hsstitu.nnumetitu
                  and (hssusua.crcc_usua is not null or 
                       hssusua.crageusua is not null)
                  and length(somente_numeros_string(crageusua)) = 5 
                  and hssusua.csituusua = 'A'
                  -- não existir com espaços ou traços
                  and not exists (select 1
                         from hssusua a, hssplan b, hsstitu c
                        where b.ccodiplan = 8200
                          and b.nnumeplan = c.nnumeplan
                          and a.nnumetitu = c.nnumetitu
                          and (a.crcc_usua is not null or 
                               a.crageusua is not null)
                          and length(somente_numeros_string(a.crageusua)) = 5 
                          and a.csituusua = 'A'
                          and a.nnumeusua = hssusua.nnumeusua
                          and ((LENGTH(somente_caracteres(a.crageusua,' -')) > 0) or (LENGTH(somente_caracteres(a.crcc_usua,' -')) > 0)))
                   -- não existir caracteres
                   and not exists (select 1
                         from hssusua a, hssplan b, hsstitu c
                        where b.ccodiplan = 8200
                          and b.nnumeplan = c.nnumeplan
                          and a.nnumetitu = c.nnumetitu
                          and (a.crcc_usua is not null or 
                               a.crageusua is not null)
                          and length(somente_numeros_string(a.crageusua)) = 5 
                          and a.csituusua = 'A'
                          and a.nnumeusua = hssusua.nnumeusua
                          and ((LENGTH(somenteletras(a.crageusua)) > 0) or (LENGTH(somenteletras(a.crcc_usua)) > 0))) ) 
  loop                  
  
  update hssusua
     set crageusua = substr(crageusua,1,length(crageusua)-1) || '-' || substr(crageusua,length(crageusua),length(crageusua))
   where hssusua.nnumeusua = reg.nnumeusua
  
  v_contador := nvl(v_contador,0) + 1;  
  if mod(v_contador,250) = 0 then
  commit;
  v_contador := 0;
  end if;
   
  end loop;
 commit;
end;



declare
  v_contador number;

begin
  v_contador := 0;

  for reg in ( select hssusua.crageusua , hssusua.crcc_usua , hssusua.cnomeusua , hsstitu.ccodititu , hssusua.nnumeusua
                 from hssusua, hssplan, hsstitu
                where hssplan.ccodiplan = 8200
                  and hssplan.nnumeplan = hsstitu.nnumeplan
                  and hssusua.nnumetitu = hsstitu.nnumetitu
                  and (hssusua.crcc_usua is not null or 
                       hssusua.crageusua is not null)
                  and length(somente_numeros_string(crcc_usua)) = 6 
                  and hssusua.csituusua = 'A'
                  -- não existir com espaços ou traços
                  and not exists (select 1
                         from hssusua a, hssplan b, hsstitu c
                        where b.ccodiplan = 8200
                          and b.nnumeplan = c.nnumeplan
                          and a.nnumetitu = c.nnumetitu
                          and (a.crcc_usua is not null or 
                               a.crageusua is not null)
                          and length(somente_numeros_string(crcc_usua)) = 6
                          and a.csituusua = 'A'
                          and a.nnumeusua = hssusua.nnumeusua
                          and ((LENGTH(somente_caracteres(a.crageusua,' -')) > 0) or (LENGTH(somente_caracteres(a.crcc_usua,' -')) > 0)))
                   -- não existir caracteres
                   and not exists (select 1
                         from hssusua a, hssplan b, hsstitu c
                        where b.ccodiplan = 8200
                          and b.nnumeplan = c.nnumeplan
                          and a.nnumetitu = c.nnumetitu
                          and (a.crcc_usua is not null or 
                               a.crageusua is not null)
                          and length(somente_numeros_string(crcc_usua)) = 6
                          and a.csituusua = 'A'
                          and a.nnumeusua = hssusua.nnumeusua
                          and ((LENGTH(somenteletras(a.crageusua)) > 0) or (LENGTH(somenteletras(a.crcc_usua)) > 0)))  ) 
  loop                  
  
  update hssusua
         crcc_usua = substr(crcc_usua,1,length(crcc_usua)-1) || '-' || substr(crcc_usua,length(crcc_usua),length(crcc_usua))
   where nnumeusua = reg.nnumeusua
  
  v_contador := nvl(v_contador,0) + 1;
  if mod(v_contador,250) = 0 then
  commit;
  v_contador := 0;
  end if;
   
  end loop;
 commit;
end;










/* teste RENATO para formatar campos 

select trim (somente_caracteres(upper(CRCC_USUA),'0123456789X')) conta_retorno, CRCC_USUA CC_Retorno_Original , length(CRCC_USUA) tamanho
  from TESTE_436791
 where length(trim(CRCC_USUA)) <> length(trim (somente_caracteres(upper(CRCC_USUA),'0123456789X')))
*/