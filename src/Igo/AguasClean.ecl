IMPORT $, Std;

Export AguasClean := MODULE
	
	Export lcoordStr := RECORD
			STRING coord;
	END;
	
	Export lcoord := RECORD
			STRING xcoord;
			STRING ycoord;
	END;
	
	Export lAguaFinal := RECORD
			STRING NORIOCOMP;
			STRING FREQUENCIA;
			STRING IMPACTO;
			STRING OBJECTID;
			STRING VULNERABILIDADE;
			DATASET(lcoord) COORDINATES;
	END;
	
	lcoord separateCoords2 (lcoordStr L) := TRANSFORM
			AUX1 := STD.STR.FINDREPLACE(L.Coord,'[ ','');
			AUX2 := STD.STR.FINDREPLACE(AUX1,' ]','');
			AUX := STD.STR.SplitWords(AUX2,', ');
			SELF.xcoord := AUX[1];
			SELF.ycoord := AUX[2];
	END;
	
	lAguaFinal separateCoords($.File_Aguas.Layout L) := TRANSFORM
		SELF.NORIOCOMP := L.NORIOCOMP;
		SELF.FREQUENCIA := L.FREQUENCIA;
		SELF.IMPACTO := L.IMPACTO;
		SELF.OBJECTID := L.OBJECTID;
		SELF.VULNERABILIDADE := L.VULNERABILIDADE;
		AUX := STD.STR.FINDREPLACE(L.Coordinates, ' "type": "MultiLineString", "coordinates": [ [', '');
		AUX1 := STD.STR.FINDREPLACE(AUX, ' "type": "LineString", "coordinates": [ [', '');
		AUX2 := STD.STR.FINDREPLACE(AUX1,' ] ] }','');
		
		SELF.COORDINATES := PROJECT(DATASET(STD.STR.SplitWords(AUX2,' ], [ '),lcoordStr),separateCoords2(LEFT));
	END;
	EXPORT fAguasFinal := PROJECT($.File_Aguas.File, separateCoords(LEFT));

END;