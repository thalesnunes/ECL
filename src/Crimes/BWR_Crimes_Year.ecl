IMPORT $;
Crimes := $.File_Crimes.File;

YearFilter := Crimes.Year >= 2010 AND Crimes.Year <= 2020 ;

CrimesPerYear := TABLE(Crimes(YearFilter),{Year, contagem := COUNT(GROUP)}, Year, FEW);

OUTPUT(CrimesPerYear);

OUTPUT(AVE(CrimesPerYear, contagem));

