IMPORT $, Visualizer;

// Join
Aguas := $.File_AguasCSVClean.File;
Estados := $.File_estadosmerged.File;

RecJoin := RECORD
	RECORDOF(Aguas);
    Estados.PONTO_INICIAL;
	UNSIGNED2 SCORE
END;

RecJoin JoinGeocodigo (RECORDOF(Aguas) Le, RECORDOF(Estados) Ri) := TRANSFORM
	SELF.GEOCODIGO := Le.GEOCODIGO;
	SELF.PONTO_INICIAL := Ri.PONTO_INICIAL;
	SELF.SCORE := 1000/((2*Le.FREQUENCIA + 3*Le.IMPACTO + 2*Le.VULNERABILIDADE)/7);
	SELF := Le;
END;

GeocodigoJoined := JOIN(Aguas, Estados, LEFT.GEOCODIGO=RIGHT.GEOCODIGO, JoinGeocodigo(LEFT, RIGHT));

OUTPUT(GeocodigoJoined,,'~proj::bbc::GeocodigoJoined', overwrite);

// Crosstab report
CntRec := RECORD
	GeocodigoJoined.SCORE;
	cnt := COUNT(GROUP);
END;

CTRep := SORT(TABLE(GeocodigoJoined,CntRec,SCORE),SCORE);
OUTPUT(CTRep,NAMED('end_por_score'), overwrite);

// Visualization
Visualizer.MultiD.Column('Enderecos_Score',,'end_por_score');