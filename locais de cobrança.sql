SELECT CBOLELOPG, CLREMLOPG, NDBANLOPG, pkg_boleto_class.layout_homologado(CLREMLOPG) boleto,
       pkg_paga.layout_remessa_homologada(CLREMLOPG) remessa,
       hsslopg.*
  FROM HSSLOPG
where nnumelopg = 2550864;
 
select CBOLELOPG, CLREMLOPG,  pkg_boleto_class.layout_homologado(CLREMLOPG) boleto,
       pkg_paga.layout_remessa_homologada(CLREMLOPG) remessa, NDBANLOPG, hsslopg.* FROM HSSLOPG
where CLREMLOPG = '14';