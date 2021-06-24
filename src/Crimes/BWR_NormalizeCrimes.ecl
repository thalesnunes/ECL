IMPORT $, STD;

Crimes := $.File_Crimes.File;
Layout := $.File_Crimes.Layout;

RecSlimCrimes := RECORD
	Layout AND NOT Block AND NOT District AND NOT Community_Area;
	UNSIGNED8 row_id;
END;

RecLookup := RECORD
	UNSIGNED8 row_id := 0;
	Crimes.Block;
	Crimes.District;
	Crimes.Community_Area;
END;

LookupTable := TABLE(Crimes, RecLookup);
LookupDS := DEDUP(SORT(LookupTable, Block, District, Community_Area));

RecLookup TransfLookup(LookupDS Le, UNSIGNED Cnt) := TRANSFORM
	SELF.row_id := Cnt;
	SELF := Le;
END;

LookupFinal := PROJECT(LookupDS, TransfLookup(LEFT, COUNTER));

RecSlimCrimes TransfCrimes(Layout Le, LookupFinal Ri) := TRANSFORM
	SELF.row_id := Ri.row_id;
	SELF := Le;
END;

CrimesSlim := JOIN(Crimes, LookupFinal,
									 LEFT.Block = RIGHT.Block AND
									 LEFT.District = RIGHT.District AND
									 LEFT.Community_Area = RIGHT.Community_Area,
									 TransfCrimes(LEFT, RIGHT));

OUTPUT(CrimesSlim,,'~class::takn372::out::CrimesSlim', overwrite);
OUTPUT(LookupFinal,,'~class::takn372::out::LookupAddress', overwrite);