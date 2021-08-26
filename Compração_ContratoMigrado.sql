--HSSUSUA - migra
cdemiusua
nuantusua
ntmigusua
dmigrusua

--HSSTITU - migra
dmigrtitu
ncanttitu

ncpostitu


--------- SQL do mesmo benef no novos contrato odonto e contrato normal

select hssusua.*
  from hssusua
 where ccodiusua = '007.2505145'  --Contrato Odonto
   and csituusua = 'A'
 union all
select hssusua.*
  from hssusua
 where ccodiusua = '100.2662478'  --Contrato Normal
   and csituusua = 'A'
   
   
--Alinhar informações de migração entre os dois


------------------------------------------------------------------------
---Contratos do mesmo beneficiario acima

select *
  from hsstitu
 where ccodititu = '100.00017249'  --Contrato Odonto
 union all
select *
  from hsstitu
 where ccodititu = '007.81060001'  --Contrato normal