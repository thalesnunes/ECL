EXPORT File_Empresas := MODULE
    EXPORT Layout := RECORD
    STRING8 cnpj;
    STRING4 cnpj_ordem;
    STRING2 cnpj_dv;
    UNSIGNED1 matriz_filial;
    STRING nome_fantasia;
    STRING2 sit_cadastro;
    UNSIGNED4 data_sit;
    STRING2 motivo_sit;
    STRING nome_exterior;
    STRING3 pais;
    UNSIGNED4 inicio_atividade;
    STRING7 cnae_principal;
    STRING cnae_secundaria;
    STRING20 tipo_logradouro;
    STRING logradouro;
    STRING6 numero;
    STRING complemento;
    STRING bairro;
    STRING8 cep;
    STRING2 uf;
    STRING4 municipio;
    STRING4 ddd1;
    STRING8 telefone1;
    STRING4 ddd2;
    STRING8 telefone2;
    STRING4 ddd_fax;
    STRING8 fax1;
    STRING email;
    STRING sit_especial;
    UNSIGNED4 data_sit_especial;
    END;

    Estab1  := DATASET('~proj::bbc::estabelecimento',Layout,CSV);
    Estab2  := DATASET('~proj::bbc::estabelecimento2',Layout,CSV);
    Estab3  := DATASET('~proj::bbc::estabelecimento3',Layout,CSV);
    Estab4  := DATASET('~proj::bbc::estabelecimento4',Layout,CSV);
    Estab5  := DATASET('~proj::bbc::estabelecimento5',Layout,CSV);
    Estab6  := DATASET('~proj::bbc::estabelecimento6',Layout,CSV);
    Estab7  := DATASET('~proj::bbc::estabelecimento7',Layout,CSV);
    Estab8  := DATASET('~proj::bbc::estabelecimento4',Layout,CSV);
    Estab9  := DATASET('~proj::bbc::estabelecimento9',Layout,CSV);
    Estab10 := DATASET('~proj::bbc::estabelecimento10',Layout,CSV);

    // SORT
	Estab1S  := SORT(Estab1, cnpj);
	Estab2S  := SORT(Estab2, cnpj);
	Estab3S  := SORT(Estab3, cnpj);
	Estab4S  := SORT(Estab4, cnpj);
	Estab5S  := SORT(Estab5, cnpj);
	Estab6S  := SORT(Estab6, cnpj);
	Estab7S  := SORT(Estab7, cnpj);
	Estab8S  := SORT(Estab8, cnpj);
	Estab9S  := SORT(Estab9, cnpj);
	Estab10S := SORT(Estab10, cnpj);

    EXPORT File := MERGE(Estab1S, Estab2S, Estab3S, Estab4S, Estab5S, Estab6S, Estab7S, Estab8S, Estab9S, Estab10S, SORTED(cnpj));
END;