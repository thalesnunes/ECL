IMPORT $;
Crimes := $.File_Crimes.File;

Rec := RECORD
	hora := Crimes.Date[12..13]+Crimes.Date[21..22];
	contagem := COUNT(GROUP);
END;

CrimesByHour := TABLE(Crimes, Rec, Date[12..13]+Date[21..22]);

OUTPUT(CrimesByHour);

IncludeCrimes := Crimes.Primary_Type IN ['BATTERY', 'BURGLARY', 'ROBBERY'];

CrimesFilteredByHour := TABLE(Crimes(IncludeCrimes), Rec, Date[12..13]+Date[21..22]);

OUTPUT(CrimesFilteredByHour);