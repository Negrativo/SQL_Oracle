select a.nome nome, a.id, b.id
  from (select hsspess.ccpf_pess cpf,
               hsspess.cnomepess nome,
               hsspess.nnumepess id
          from hsspess
         where hsspess.ccpf_pess is not null) a,
       (select hsspess.ccpf_pess cpf,
               hsspess.cnomepess nome,
               hsspess.nnumepess id
          from hsspess
         where hsspess.ccpf_pess is not null) b
 where a.cpf = b.cpf
   and a.id <> b.id
   and a.nome = b.nome
    and ('A' in (select SITUACAO FROM TABLE ( PKG_PESSOA.FUN_VINCULOS_PESSOA(a.id)))
          and 'C' in (select SITUACAO FROM TABLE ( PKG_PESSOA.FUN_VINCULOS_PESSOA(b.id)))
          or
          'C' in (select SITUACAO FROM TABLE ( PKG_PESSOA.FUN_VINCULOS_PESSOA(a.id)))
          and 'A' in (select SITUACAO FROM TABLE ( PKG_PESSOA.FUN_VINCULOS_PESSOA(b.id))))
