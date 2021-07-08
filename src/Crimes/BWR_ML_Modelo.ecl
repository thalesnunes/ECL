IMPORT $;
IMPORT ML_Core;
IMPORT ML_Core.Types;
IMPORT LogisticRegression as LR;

Bruto := TABLE($.File_CrimesSlim.File,{row_id,FBI_Code,time,Latitude,Longitude,Arrest});

DadosFiltrados := Bruto(FBI_Code<>'' AND time<>0 AND Latitude<>0 AND Longitude<>0 AND Arrest IN [false,true]);

ModeloLayout := RECORD
    UNSIGNED8 row_id;
    UNSIGNED1 FBI_Code;
    UNSIGNED3 time;
    DECIMAL11_9 Latitude;
    DECIMAL11_9 Longitude;
    UNSIGNED1 Arrest;
END;

ModeloLayout toUnsigned(RECORDOF(DadosFiltrados) Le) := TRANSFORM
SELF.FBI_Code := (UNSIGNED1) Le.FBI_Code;
SELF.Arrest := (UNSIGNED1) Le.Arrest;
SELF := Le;
END;

DadosTratados := PROJECT(DadosFiltrados, toUnsigned(LEFT));

DadosTrain := DadosTratados[1..10000];
DadosTest := DadosTratados[10001..13000];
ML_Core.ToField(DadosTrain, DadosTrainNF);
ML_Core.ToField(DadosTest, DadosTestNF);

XTrain := DadosTrainNF(number < 5);
YTrain := PROJECT(DadosTrainNF(number = 5), TRANSFORM(Types.DiscreteField,
SELF.number := 1, SELF := LEFT));


XTest := DadosTestNF(number < 5);
YTest := PROJECT(DadosTestNF(number = 5), TRANSFORM(Types.DiscreteField,
SELF.number := 1, SELF := LEFT));


mod_bi := LR.BinomialLogisticRegression(100,0.0001).getModel(XTrain, YTrain);


predict := LR.BinomialLogisticRegression().Classify(mod_bi, XTest);
OUTPUT(predict, NAMED('predict'));

conf_matrix := LR.Confusion(Ytest,predict);
bin_matrix := LR.BinomialConfusion(conf_matrix);
OUTPUT(bin_matrix, NAMED('Accuracy'));