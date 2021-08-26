
--VERIFICAR REMESSAS QUE TEM O CCO--
select 
s.nremeresib
,s.ddataresib
,r.nplanrgsib
,r.nnumeusua
--r.coperrgsib
,decode (r.coperrgsib
,'I','INCLUSAO'
,'A','RETIFICACAO'
,'C','CANCELAMENTO'
,'R','REATIVACAO'
,'M','MUDANCA CONTRATUAL')OPERACAO
--,r.cstatrgsib
,decode (r.cstatrgsib
,'A','ACEITO'
,'R','REJEITADO'
,'C','CONFRONTO')STATUS
,r.csiturgsib
,r.ccco_rgsib
,r.cnomergsib
,r.dinclrgsib
,r.ccnpjrgsib
,r.nmotcrgsib

from hssrgsib r , hssresib s

where r.nnumeresib = s.nnumeresib
and r.ccco_rgsib in ('037875952404','037875952306') 
--and r.coperrgsib = 'A' --retificaÃ§Ã£o
order by s.ddataresib desc  