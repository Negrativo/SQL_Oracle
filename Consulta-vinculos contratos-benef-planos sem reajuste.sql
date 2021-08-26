select titu.nnumetitu numero_contrato, titu.ccodititu codigo_contrato
  from hsstpla tpla, hsstitu titu
 where not exists (select 1
                      from hssreaju reaju
                     where reaju.nnumeplan = tpla.nnumeplan
                       and reaju.nnumetpla = tpla.nnumetpla)
   and tpla.nnumetitu = titu.nnumetitu
   and tpla.dvigetpla is null
   and titu.csitutitu = 'A'
   --and tpla.nnumeplan = 10
   --and tpla.nnumetpla = 156371126
   
select hssplan.ccodiplan codigo_plano ,tpla.cdesctpla descricao_plano
  from hsstpla tpla, hssplan--, hsstitu titu
 where not exists (select 1
                      from hssreaju reaju
                     where reaju.nnumeplan = tpla.nnumeplan
                       and reaju.nnumetpla = tpla.nnumetpla)
   --and tpla.nnumetitu = titu.nnumetitu
   and tpla.nnumeplan = hssplan.nnumeplan
   and tpla.dvigetpla is null
   and tpla.nnumetitu is null 
   --and titu.csitutitu = 'A'
   --and tpla.nnumeplan = 10
   --and tpla.nnumetpla = 156371126
   
select usua.nnumeusua numero_usua, usua.ccodiusua codigo_usua, usua.cnomeusua nome_usua
  from hsstpla tpla, hssplan, hssusua usua, hsstitu titu
 where not exists (select 1
                      from hssreaju reaju
                     where reaju.nnumeplan = tpla.nnumeplan
                       and reaju.nnumetpla = tpla.nnumetpla)
   --and tpla.nnumetitu = titu.nnumetitu
   and tpla.nnumeplan = hssplan.nnumeplan
   and tpla.dvigetpla is null
 -- and tpla.nnumetitu is null 
   and USUA.NNUMEPLAN = tpla.nnumeplan
   AND USUA.NNUMETPLA = tpla.NNUMETPLA
   AND USUA.NNUMETITU = TITU.NNUMETITU
   and usua.csituusua = 'A'
   order by cnomeusua
   --and titu.csitutitu = 'A'
   --and tpla.nnumeplan = 10   