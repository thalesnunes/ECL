IMPORT $;

estados := $.File_estadosmerged.estados_cleaned;

OUTPUT(SORT(estados, geocodigo, -ponto_inicial)(estados.geocodigo >= 110000000000000));