#WORKUNIT('name','Vectors_For_Visualization');

stdVectors := $.Files.stdVectors.ds;

dataToViewRec := RECORD
   stdVectors.userID;
   stdVectors.numberOfActiveDays;
   stdVectors.avgDailyReq;
   stdVectors.avgDailyBIR;
END;

dataToView := TABLE(stdVectors, dataToViewRec);
OUTPUT(dataToView,, '~nasalog::userad::userad_stdvectors.csv', CSV, OVERWRITE);