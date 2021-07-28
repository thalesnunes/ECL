EXPORT File_Aguas := MODULE
 EXPORT Layout := RECORD
 	STRING NORIOCOMP {xpath('properties/NORIOCOMP')};
	STRING FREQUENCIA {xpath('properties/FREQUENCIA')};
	STRING IMPACTO {xpath('properties/IMPACTO')};
	STRING OBJECTID {xpath('properties/OBJECTID')};
	STRING VULNERABILIDADE {xpath('properties/VULNERABILIDADE')};
	STRING Coordinates {xpath('geometry/<>')}
END;
 EXPORT File := DATASET('~CLASS::grp011::aguas',Layout,JSON('/features'));
END;