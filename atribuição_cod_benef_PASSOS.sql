--função da uhssfunc.pas
function Atribuicao_Codigo_Usuario (Usuario,Empresa              : Double;
                                    Codigo_Atual,Tipo_Usuario,
                                    Codigo_Titulo,Codigo_Titular,
                                    Codigo_Locacao               : string;
                                    Id_Contrato,
                                    Id_Congenere,Plano           : Double;
                                    Grau_Parentesco,Sexo         : string;
                                    Nascimento,Inclusao,
                                    Data_Contrato                : TDateTime;
                                var Carteira                     : string) : String; --*
                                
                                
-----------------------------------------------------------------------------------------
--cursores transcritos da func para sql
--atribuicao_codigo_usuario_JLS
-----------------------------------------------------------------------------------------

create or replace function atribuicao_codigo_usuario_JLS (tipo_usuario      in varchar2,
                                                          codigo_titular    in varchar2,
                                                          codigo_contrato   in varchar2,
                                                          id_plano          in number,
                                                          id_usuario        in number,
                                                          id_usuario_antigo in number,
                                                          grau_usuario      in varchar2 default null,
                                                          sexo_usuario      in varchar2 default null) return varchar2 as

  contrato        number;
  num_usuarios    number;
  num_titulares   number;
  num_familias    number;
  num_dep_familia number;
  posicao         number;
  tamanho         number;
  config_usuario  varchar2(1);
  codigo_plano    varchar2(6);
  ultimo          number;
  congenere       number;
  empresa         number;
  temp            varchar2(20);
  plano           number;
  cgc             varchar2(18);
  grau_parentesco varchar2(1);
  parentesco      varchar2(2);
  acomodacao      varchar2(25);
  cod_dependente  varchar2(20);
  codigo_familia  varchar2(16);
  codigo_congenere varchar2(5);
  codigo_empresa   varchar2(16);
  cod_contrato     varchar2(6);
  cod_modelo       hssusua.ccodiusua%type;
  codigo           varchar2(16);
  sexo             varchar2(1);
  existe           varchar2(1);
  tipo_titular     varchar2(1);
  historico_raise  varchar2(4000);
  raise_20570      exception;
  id_existe        number;
  usuario_existe   number;
  prefixo_operadora varchar2(3);
  sequencia         number;
  codigoinicial     number;
  qtd_usu_financ    number;
  contador          number;
  i                 number;
  existe_financ     number;
  v_ponto_2         number;
  v_ponto_3         number;
  codigo2           hssusua.ccartusua%type;
  modalidade        hssplan.cmodaplan%type;
  ultimodigito      varchar2(2);
  proximo_digito    varchar2(2);
  matricula         hssusua.cchapusua%type;
  v_tipo_usua        varchar2(15);
  v_razao_conge      hssconge.crazaconge%type;

  cursor cr_scpassos (p_cod_titu in varchar2) is
    select nnumetitu, nvl(hsstitu.nnumeempr,0) empresa, hsstitu.nnumeconge, crazaconge,
           decode(instr(hsstitu.ccodititu,'.'),
                  0,hsstitu.ccodititu,
                  substr(hsstitu.ccodititu,1,instr(hsstitu.ccodititu,'.')-1)) cod_contrato
      from hsstitu, hssconge

     where ccodititu = p_cod_titu
       and hsstitu.nnumeconge = hssconge.nnumeconge(+);

  cursor cr_plano_passos (p_plano in number) is
    select ccodiplan
      from hssplan
     where nnumeplan = p_plano;
   
  cursor cr_cod_modelo_passos (p_num_contrato in number,
                               p_num_plano    in number) is 
    select nnumeusua,ccodiusua,
           instr(ccodiusua,'.',instr(ccodiusua,'.')+1) ponto_2,
           instr(ccodiusua,'.',-1) ponto_3
      from hssusua
     where nnumetitu = p_num_contrato
       and nnumeplan = p_num_plano
       and length(ccodiusua) > 14
       and length(somente_caracteres(ccodiusua,'.')) = 3
     group by nnumeusua,ccodiusua
     order by 1 asc;

  cursor cr_cod_titu_emp_passos(p_num_contrato in number,
                                p_num_plano    in number,
                                p_ponto_2      in number,
                                p_ponto_3      in number) is
    select nvl(max(to_number(substr(somente_numeros_string(ccodiusua),p_ponto_2,(p_ponto_3-p_ponto_2)))),0) ultimo
      from hssusua
     where nnumetitu = p_num_contrato
       and nnumeplan = p_num_plano;

  cursor cr_cod_titu_passos (p_num_conge in number,
                             p_num_plano in number,
                             p_ponto_2   in number,
                             p_ponto_3   in number) is
    select nvl(max(to_number(substr(ccodiusua,p_ponto_2,(p_ponto_3-p_ponto_2)))),0) ultimo
      from hsstitu, hssusua
     where hsstitu.nnumeconge = p_num_conge
       and hsstitu.nnumeplan  = p_num_conge
       and hsstitu.nnumetitu  = hssusua.nnumetitu;

  cursor cr_cod_passos (p_cod_titular in varchar2,
                        p_ponto_3     in number) is
    select nvl(max(to_number(substr(ccodiusua,p_ponto_3+1,2))),0) ultimo
      from hssusua
     where ccodiusua like SUBSTR(p_cod_titular,01,p_ponto_3-1)||'%';
     
begin
  -- Santa Casa de Passos
  --elsif cgc = '23278898000160' then
  
  open cr_cod_modelo_passos(codigo_contrato,codigo_plano);
  fetch cr_cod_modelo_passos into id_existe,cod_modelo,v_ponto_2,v_ponto_3;
  close cr_cod_modelo_passos;

  open  cr_scpassos(codigo_contrato);
  fetch cr_scpassos into contrato,empresa,congenere, v_razao_conge,cod_contrato;
  close cr_scpassos;

  open cr_plano_passos(id_plano);
  fetch cr_plano_passos into codigo_plano;
  close cr_plano_passos;

  if tipo_usuario in ('T','F') then
    if nvl(empresa,0) > 0 then

      open cr_cod_titu_emp_passos(codigo_contrato,codigo_plano,v_ponto_2,v_ponto_3);
      fetch cr_cod_titu_emp_passos into ultimo;
      close cr_cod_titu_emp_passos;

      temp := cod_contrato || '.' ||  Acrescenta_Zeros_String(codigo_plano,3) || '.' || Acrescenta_Zeros(ultimo + 1,4) || '.01';
    else
      open cr_cod_titu_passos(codigo_congenere,codigo_plano,v_ponto_2,v_ponto_3);
      fetch cr_cod_titu_passos into ultimo;
      close cr_cod_titu_passos;

      temp := cod_contrato || '.' ||  Acrescenta_Zeros_String(codigo_plano,3) || '.' || Acrescenta_Zeros(ultimo + 1,4) || '.01';
    end if;

  else

    open cr_cod_passos(codigo_titular,v_ponto_3);
    fetch cr_cod_passos into ultimo;
    close cr_cod_passos;

    temp := substr(codigo_titular,1,11) || '.' || Acrescenta_Zeros(ultimo + 1,2);
  end if;

  --temp := temp || '-' || Modulo11(Somente_Numeros(temp),11);

  return temp;

end;
   
-------------------------------------------------------------------------------------------
--Teste do atribuição de codigo------------------------------------------------------------ 
-------------------------------------------------------------------------------------------
 
 declare
 novo_titular number;
 codigo_teste varchar2(100);
begin
  select sequsua.nextval into novo_titular from dual;
  
  select atribuicao_codigo_usuario_jls('T','','151','21','',594263,'F','F') into codigo_teste from dual;
  
  dbms_output.put_line(codigo_teste);
end;
