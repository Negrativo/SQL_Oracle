begin
  for reg in (select distinct nnumepaga
                from ctb_ce
               where NNUMEPAGA IN (79393,197421,88050,82233,122881,99891,138933,137366,140405,142034,158193,156717,159669,162607,
                                   171462,172951,184745,183264,186250,80793,89499,77985,75176,93950,118218,128453,129935,143510,
                                   144965,167002,161134,174412,177412,175893,187737,191649,189202,85125,90931,83668,86569,96915,
                                   95424,98393,131459,134412,132907,146436,149212,153715,155227,169966,168508,165553,164067,180357,
                                   178881,181799,195932,92412)
                 and nnumepaga not in (select nnumepaga from ctb_ce_composicao))
  loop
    pkg_reg_auxiliar.processa_composicao_fatura(reg.nnumepaga);   
  end loop;
  commit;
end;