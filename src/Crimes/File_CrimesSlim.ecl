EXPORT File_CrimesSlim := MODULE
 EXPORT Layout := RECORD
    UNSIGNED4 ID;
    STRING9 Case_Number;
    STRING22 Date;
    STRING4 IUCR;
	STRING33 Primary_Type;
    STRING60 Description;
    STRING53 Location_Description;
    STRING5 Arrest;
    STRING5 Domestic;
    STRING4	Beat;
    UNSIGNED1 Ward;
    STRING3 FBI_Code;
    UNSIGNED4 X_Coordinate;
    UNSIGNED4 Y_Coordinate;
    UNSIGNED2 Year;
    STRING22 Updated_On;
    REAL8 Latitude;
    REAL8 Longitude;
    STRING29 Location;
    UNSIGNED8 row_id;
	END;
EXPORT File := DATASET('~class::takn372::out::CrimesSlim', Layout, FLAT);
END;