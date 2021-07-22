EXPORT File_Aguas := MODULE
    EXPORT Layout_coords := RECORD
        REAL8 coord_x;
        REAL8 coord_y;
    END;
    EXPORT Layout := RECORD
	    STRING freq {XPATH('properties/FREQUENCIA')};
	    STRING impacto {XPATH('properties/IMPACTO')};
	    STRING id {XPATH('properties/OBJECTID')};
	    STRING vulner {XPATH('properties/VULNERABILIDADE')};
	    DATASET(Layout_coords) coords {XPATH('geometry/coordinates')};
    END;
    EXPORT File := DATASET('~class::takn372::aguas',Layout,JSON('/'));
END;