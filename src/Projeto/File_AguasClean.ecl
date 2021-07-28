IMPORT $, Std;

EXPORT File_AguasClean := MODULE

	EXPORT coords_string := RECORD
			STRING coords;
	END;

	EXPORT coords_real := RECORD
			REAL8 xcoord;
			REAL8 ycoord;
	END;

	EXPORT Layout := RECORD
			STRING NORIOCOMP;
			UNSIGNED1 FREQUENCIA;
			UNSIGNED1 IMPACTO;
			UNSIGNED4 OBJECTID;
			UNSIGNED1 VULNERABILIDADE;
			DATASET(coords_real) COORDINATES;
	END;

	coords_real separateCoords2 (coords_string Le) := TRANSFORM
			clean1 := STD.STR.FINDREPLACE(Le.coords,'[ ','');
			clean2 := STD.STR.FINDREPLACE(clean1,' ]','');
			clean_final := STD.STR.SplitWords(clean2,', ');
			SELF.xcoord := (REAL8) clean_final[1];
			SELF.ycoord := (REAL8) clean_final[2];
	END;

	Layout separateCoords($.File_Aguas.Layout Le) := TRANSFORM
		SELF.NORIOCOMP := Le.NORIOCOMP;
		SELF.FREQUENCIA := IF(Le.FREQUENCIA='Alta',3,IF(Le.FREQUENCIA='Média',2,1));
		SELF.IMPACTO := IF(Le.IMPACTO='Alto',3,IF(Le.FREQUENCIA='Médio',2,1));
		SELF.OBJECTID := (UNSIGNED4) Le.OBJECTID;
		SELF.VULNERABILIDADE := IF(Le.VULNERABILIDADE='Alta',3,IF(Le.VULNERABILIDADE='Média',2,1));
		clean := STD.STR.FINDREPLACE(Le.Coordinates, ' "type": "MultiLineString", "coordinates": [ [', '');
		clean1 := STD.STR.FINDREPLACE(clean, ' "type": "LineString", "coordinates": [ [', '');
		clean2 := STD.STR.FINDREPLACE(clean1,' ] ] }','');
		coords := DATASET(STD.STR.SplitWords(clean2,' ], [ '),coords_string);
		SELF.COORDINATES := PROJECT(coords,separateCoords2(LEFT));

	END;
	EXPORT File := PROJECT($.File_Aguas.File, separateCoords(LEFT));

END;