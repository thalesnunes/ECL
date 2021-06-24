IMPORT $;
Crimes := $.File_Crimes.File;

OUTPUT(SORT(Crimes, Block, District, Community_Area));

