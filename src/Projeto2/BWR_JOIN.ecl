IMPORT $;

// LENDO OS ARQUIVOS OTIMIZADOS E COM COLUNAS MAIS RELEVANTES
empresasCleaned := $.File_Empresas.MergeEmpresas.empresasCleand;
estabelecimentosCleaned := $.Estabelecimentos1a10.MergeEstabelecimentos.estabelecimentoCleand;
sociosCleaned := $.Socios1a10.MergeSocios.sociosCleand;
PEPCleaned := $.PEPCleand.PEPClear;


// EXPORT JoinGeral := MODULE
JUNTANDO AS BASES DE SOCIOS E PEP
SociosPEP := RECORD
    sociosCleaned;
    PEPCleaned;
END;

SociosPEP MyJoin1(sociosCleaned Le,PEPCleaned Ri) := TRANSFORM
    SELF:=Le;
    SELF:=Ri;
END;

joinSociosPEP := JOIN(sociosCleaned,PEPCleaned,
                                (LEFT.NOME = RIGHT.NOME AND (LEFT.CNPJ_CPF = '***' +
                                RIGHT.CNPJ_CPF[5..7] + RIGHT.CNPJ_CPF[9..11] + '**')),
                                MyJoin1(LEFT, RIGHT),
                                ALL);


// JUNTANDO AS BASES DE SOCIOS, PEP E EMPRESAS
empresaseSociosPEP := RECORD
    empresasCleaned;
    joinSociosPEP;
END;

empresaseSociosPEP MyJoin2(empresasCleaned Le,SociosPEP Ri) := TRANSFORM
    SELF:=Le;
    SELF:=Ri;
END;

Empresas_SOCIOSPEP := JOIN(empresasCleaned,joinSociosPEP,
                                (LEFT.CNPJ_BASICO = RIGHT.CNPJ_BASICO),
                                MyJoin2(LEFT, RIGHT),
                                ALL);

// RETIRANDO DUPLICAÇÕES
Empresas_SociosPEPsemdup := DEDUP(Empresas_SOCIOSPEP,LEFT.NOME=RIGHT.NOME);


// JUNTANDO A BASE DE ESTABELECIMENTOS A TODAS AS OUTRAS
Tudo := RECORD
    Empresas_SociosPEPsemdup;
    estabelecimentosCleaned;
END;

Tudo MyJoin3(estabelecimentosCleaned Le,Empresas_SociosPEPsemdup Ri) := TRANSFORM
    SELF:=Le;
    SELF:=Ri;
END;


// DANDO EXPORT NO LAYOUT FINAL DO DATASET
EXPORT Layout := JOIN(estabelecimentosCleaned,Empresas_SociosPEPsemdup,
                                (LEFT.CNPJ_BASICO = RIGHT.CNPJ_BASICO[1..8]),
                                MyJoin3(LEFT, RIGHT),
                                ALL);

// DANDO EXPORT NA CONTAGEM DE SÓCIOS PEP QUE PARTICIPAM DE ALGUMA EMPRESA
EXPORT cnt := COUNT(Layout);
END;