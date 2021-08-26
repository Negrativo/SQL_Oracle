--tabela de backup
create table backup_hssusua_443175 as (
select hssusua.nnumeusua, hssusua.nnumetitu, hssusua.CCHAPUSUA,
       hssusua.ctipousua, hssusua.ntituusua
  from hssusua, hsstitu
 where hsstitu.nnumetitu = 19007514
   and hsstitu.nnumetitu = hssusua.nnumetitu
   and hssusua.csituusua = 'A'
)

--tabela para armazenar dados da matricula dos titulares para aplicar nos dependentes depois
create table hssusua_matri_titu (
  nnumeusuaT number,
  ntituusuaT number,
  CCHAPUSUAT varchar2(20),
  nnumetituT number
  )

--loop para aplicar dados da matricula dos titulares na tabela complementar 
begin
    for reg in (select hssusua.nnumeusua, hssusua.nnumetitu, hssusua.CCHAPUSUA,
                       hssusua.ctipousua, hssusua.ntituusua
                  from hssusua, hsstitu
                 where hsstitu.nnumetitu = 19007514
                   and hsstitu.nnumetitu = hssusua.nnumetitu
                   and hssusua.csituusua = 'A') loop
      
      if reg.ctipousua = 'T' then
        insert into hssusua_matri_titu(nnumeusuaT,ntituusuaT, nnumetituT, CCHAPUSUAT)
        values (reg.nnumeusua, reg.ntituusua, reg.nnumetitu, reg.CCHAPUSUA);
      end if;
   
   end loop;
end;

/*###############################################################################################################################*/
select * from hssusua_matri_titu
/*###############################################################################################################################*/

--loop para aplicar cod de matricula em todos da familia, onde valida atraves do titular da familia e aplica o cod da matricula dele para todos
begin
  
    for reg in (select nnumeusuaT,ntituusuaT, nnumetituT, CCHAPUSUAT
                  from hssusua_matri_titu ) loop
      
        update hssusua 
           set CCHAPUSUA = reg.CCHAPUSUAT
         where ntituusua = reg.ntituusuaT
           and nnumetitu = 19007514;
   
    end loop;
end;



select  hssusua.ntituusua, hssusua.ctipousua, hssusua.CCHAPUSUA
                  from hssusua, hsstitu
                 where hsstitu.nnumetitu = 19007514
                   and hsstitu.nnumetitu = hssusua.nnumetitu
                   and hssusua.csituusua = 'A'
                 order by ntituusua