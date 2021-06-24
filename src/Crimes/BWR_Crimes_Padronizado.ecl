IMPORT $,STD;
Crimes := $.File_Crimes.File;
Layout := $.File_Crimes.Layout;

OutRec := RECORD
	UNSIGNED8 id_reg;
	UNSIGNED4 day;
	UNSIGNED3 time;
	Layout;
END;

OutRec Padronizar(Layout Le, UNSIGNED Cnt) := TRANSFORM
	SELF.id_reg := Cnt;
	SELF.day := STD.Date.FromStringToDate(Le.date[1..10], '%m/%d/%Y');
	hour := (UNSIGNED1) Le.date[12..13];
	hour_std := IF(Le.date[21]='P',hour+12,hour);
	hour_form := IF(hour_std=12,0,IF(hour_std=24,12,hour_std));
	SELF.time := STD.Date.TimeFromParts(hour_form, (UNSIGNED1) Le.date[15..16], (UNSIGNED1) Le.date[18..19]);
	SELF := Le;
END;

CrimesPadr := PROJECT(Crimes,Padronizar(LEFT,COUNTER));
OUTPUT(CrimesPadr)