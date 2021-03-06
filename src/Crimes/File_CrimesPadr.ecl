EXPORT File_CrimesPadr := MODULE
 EXPORT Layout := RECORD
    UNSIGNED8 id_reg;
	UNSIGNED4 day;
	UNSIGNED3 time;
    UNSIGNED4 ID;
    STRING9 Case_Number;
    STRING22 Date;
    STRING35 Block;
    STRING4 IUCR;
	STRING33 Primary_Type;
    STRING60 Description;
    STRING53 Location_Description;
    STRING5 Arrest;
    STRING5 Domestic;
    STRING4	Beat;
    STRING3 District;
    UNSIGNED1 Ward;
    UNSIGNED1 Community_Area;
    STRING3 FBI_Code;
    UNSIGNED4 X_Coordinate;
    UNSIGNED4 Y_Coordinate;
    UNSIGNED2 Year;
    STRING22 Updated_On;
    REAL8 Latitude;
    REAL8 Longitude;
    STRING29 Location;
	END;
EXPORT File := DATASET('~class::takn372::out::CrimesPadr', Layout, FLAT);
END;