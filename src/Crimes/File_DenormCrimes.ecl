IMPORT $;

EXPORT File_DenormCrimes := MODULE

	EXPORT Layout_AddressesCrimes := RECORD
		$.File_LookupAddress.Layout;
		DATASET($.File_CrimesSlim.Layout) Crimes;
	END;

	Layout_AddressesCrimes ParentMove ($.File_LookupAddress.Layout Le) := TRANSFORM
		SELF.Crimes := [];
		SELF := Le;
	END;

	ParentOnly := PROJECT($.File_LookupAddress.File, ParentMove(LEFT));

	Layout_AddressesCrimes ChildMove(Layout_AddressesCrimes Le, $.File_CrimesSlim.Layout Ri) := TRANSFORM
		SELF.Crimes := Le.Crimes + Ri;
		SELF := Le;
	END;

	EXPORT File := DENORMALIZE(ParentOnly, $.File_CrimesSlim.File(Year >= 2016),
														LEFT.row_id = RIGHT.row_id, ChildMove(LEFT, RIGHT));
END;