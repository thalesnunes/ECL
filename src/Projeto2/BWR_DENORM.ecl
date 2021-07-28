IMPORT $;

ESTADOS := $.File_estadosmerged.estados_cleaned;
ESTADOS_Layout := RECORDOF($.File_estadosmerged.estados_cleaned);



// ABRINDO O DATASET E FAZENDO ALGUMAS MANIPULAÇÕES PARA FAZER A DESNORMALIZAÇÃO
GEOCODIGO := PROJECT(ESTADOS, ESTADOS_Layout AND NOT [PONTO_INICIAL]);
PONTO_INICIAL := PROJECT(ESTADOS,ESTADOS_Layout);
Layout2 := SORT($.File_Empresas.File,cnpj,nome_fantasia);
LayoutRecs := DEDUP(Layout2,LEFT.nome_fantasia=RIGHT.nome_fantasia AND LEFT.SIGLA_FUNCAO=RIGHT.SIGLA_FUNCAO);

// PREPARAÇÃO DO DATASET PARA A DESNORMALIZAÇÃO E CRIAÇÃO DE UMA COLUNA DE SCORE E OUTRA DE SCORE_RESULT
Layout_SociosCNPJ := RECORD
    CNPJ;
    UNSIGNED1 SociosPEPcnt;
    UNSIGNED4 SCORE;
    STRING7 SCORE_RESULT;
    DATASET(RECORDOF(LayoutRecs)) SociosPEP;
END;

// POPULANDO O PARENT
Layout_SociosCNPJ ParentMove(RECORDOF(CNPJ) Le) := TRANSFORM
    SELF.SociosPEPcnt := 0;
    SELF.SociosPEP := [];
    SELF.SCORE := 1000;
    SELF.SCORE_RESULT:= '';
    SELF := Le;
END;
ParentOnly := PROJECT(CNPJ, ParentMove(LEFT));

// POPULANDO CHILD
Layout_SociosCNPJ ChildMove(Layout_SociosCNPJ Le, RECORDOF(LayoutRecs) Ri, INTEGER Cnt):= TRANSFORM
            SELF.SociosPEPcnt := Cnt;
            SELF.SociosPEP := Le.SociosPEP + Ri;
            SELF.SCORE := Le.SCORE + IF(Ri.SIGLA_FUNCAO = 'VEREAD',-48,0) + IF(Ri.SIGLA_FUNCAO = 'DEP',-102,0) + IF(Ri.SIGLA_FUNCAO = 'PREFEI',-96,0);    // MUDAR O IF
            SELF.SCORE_RESULT := IF(SELF.SCORE >= 800,'BOM',IF(SELF.SCORE >= 600,'REGULAR','RUIM'));
            SELF := Le;
        END;

// APLICANDO A DESNORMALIZAÇÃO
File := DENORMALIZE(ParentOnly, LayoutRecs,
                LEFT.CNPJ_BASICO = RIGHT.CNPJ_BASICO, ChildMove(LEFT,RIGHT,COUNTER));

OUTPUT(DEDUP(File,LEFT.CNPJ_BASICO=RIGHT.CNPJ_BASICO,LEFT.SOCIOSPEP=RIGHT.SOCIOSPEP),,'proj::bbc::denorm');