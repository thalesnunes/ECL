EXPORT File_LookupAddress := MODULE
	EXPORT Layout := RECORD
		UNSIGNED4 row_id;
		STRING35 Block;
		STRING3 District;
		UNSIGNED1 Community_Area;
	END;

	EXPORT File := DATASET('~class::takn372::out::LookupAddress', Layout, FLAT);
END;