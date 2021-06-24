IMPORT $,STD;

Crimes := $.File_Crimes.File;

profileResults 	:= STD.DataPatterns.Profile(Crimes);

OUTPUT(profileResults, ALL, NAMED('profileResults'));