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
EXPORT File :=  DATASET('grupo4::estabelecimento',Layout,CSV) +
                DATASET('grupo4::estabelecimento2',Layout,CSV) +
                DATASET('grupo4::estabelecimento3',Layout,CSV) +
                DATASET('grupo4::estabelecimento4',Layout,CSV) +
                DATASET('grupo4::estabelecimento5',Layout,CSV) +
                DATASET('grupo4::estabelecimento6',Layout,CSV) +
                DATASET('grupo4::estabelecimento7',Layout,CSV) +
                DATASET('grupo4::estabelecimento4',Layout,CSV) +
                DATASET('grupo4::estabelecimento9',Layout,CSV) +
                DATASET('grupo4::estabelecimento10',Layout,CSV);
END;