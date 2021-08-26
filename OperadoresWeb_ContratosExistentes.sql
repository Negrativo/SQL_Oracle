--Chamada da rotina no modulo
insereUsuarioWeb(Q_TitulosCCODITITU.AsString,Q_TitulosNNUMEEMPR.AsString, Q_TitulosCCODITITU.AsString, 0);
--Parametros da procedure no modulo
procedure insereUsuarioWeb(login, nomeLogin, senha : String; Operador : Double = 0);

--Query da Segusua no modulo
SELECT * FROM SEGUSUA
WHERE NNUMEUSUA = :Id

--Insert na segusua realizado pela procedure insereUsuarioWeb
insert into segusua (NNUMEUSUA  , CNOMEUSUA, CNCOMUSUA, CSENHUSUA, NIDIAUSUA, DINCLUSUA, CSTATUSUA, CADMIUSUA, CSVENUSUA, NNUMEPERF)
             values (Prox_Numero, CCODITITU, NNUMEEMPR, CCODITITU, 0        , SYSDATE  , 'A'      , 'N'      , 'S'      , 21578424 );

--Query Operadores Web
SELECT * FROM HSSOPTIT
WHERE NNUMETITU = :Contrato
--Insert do operador gerado no contrato, ainda na procedure insereUsuarioWeb              
insert into hssoptit (NNUMEUSUA  , NNUMETITU)
              values (Prox_Numero, NNUMETITU);
              

--Script para inclusao em contratos ja existentes              
DECLARE
  Prox_Numero  number;
  existe       number;

  cursor cr_existe (p_nnumeusua in number,
                    p_ccodititu in number) is
         select count(1)
           from segusua
          where nnumeusua = p_nnumeusua
            or cnomeusua = to_char(p_ccodititu);    
BEGIN 
  for reg in (select nnumetitu, ccodititu, nnumeempr 
                from hsstitu 
               where nnumeempr is not null 
                 and csitutitu = 'A') loop
    
    select seqgeral.nextval into Prox_Numero from dual; 
    
    open cr_existe (Prox_Numero, reg.ccodititu);
    fetch cr_existe into existe;
    close cr_existe;
    
    if (existe = 0) then
      insert into segusua (NNUMEUSUA  ,     CNOMEUSUA,     CNCOMUSUA,     CSENHUSUA, NIDIAUSUA, DINCLUSUA, CSTATUSUA, CADMIUSUA, CSVENUSUA, NNUMEPERF)
                   values (Prox_Numero, reg.CCODITITU, reg.NNUMEEMPR, reg.CCODITITU, 0        , SYSDATE  , 'A'      , 'N'      , 'S'      , 21578424 );
                   
      insert into hssoptit (NNUMEUSUA  , NNUMETITU)
               values (Prox_Numero, reg.NNUMETITU);
    else 
      DBMS_OUTPUT.put_line('Ja existe operador cadastrado com esse numero: '||Prox_Numero); 
    end if;
  end loop;
end;