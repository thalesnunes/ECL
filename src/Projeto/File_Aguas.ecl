EXPORT File_Aguas := MODULE
    EXPORT Layout := RECORD
	    STRING freq {XPATH('properties/FREQUENCIA')};
	    STRING impacto {XPATH('properties/IMPACTO')};
	    STRING id {XPATH('properties/OBJECTID')};
	    STRING vulner {XPATH('properties/VULNERABILIDADE')};
	    STRING coords {XPATH('geometry/<>')};
    END;
    EXPORT File := DATASET('~class::takn372::aguas',Layout,JSON('/'));
END;