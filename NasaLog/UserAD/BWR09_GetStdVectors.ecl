stdValues := $.Files.StdValues.ds[1];

$.Files.stdVectors.layout Xform ($.Files.vectors.layout L) := TRANSFORM
    SELF.userID := L.userID;
    SELF.avgReqInFirst8Hrs := (L.avgReqInFirst8Hrs - stdValues.minAvgReqbyWindow)/(stdValues.maxAvgReqbyWindow - stdValues.minAvgReqbyWindow);
    SELF.avgReqInSecond8Hrs := (L.avgReqInSecond8Hrs - stdValues.minAvgReqbyWindow)/(stdValues.maxAvgReqbyWindow - stdValues.minAvgReqbyWindow);
    SELF.avgReqInLast8Hrs := (L.avgReqInLast8Hrs - stdValues.minAvgReqbyWindow)/(stdValues.maxAvgReqbyWindow - stdValues.minAvgReqbyWindow);
    SELF.numberOfActiveDays := (L.numberOfActiveDays - stdValues.minActiveDays)/(stdValues.maxActiveDays - stdValues.minActiveDays);
    SELF.avgUniqDailyReq := (L.avgUniqDailyReq - stdValues.minAvgUniqDailyReq)/(stdValues.maxAvgUniqDailyReq - stdValues.minAvgUniqDailyReq);
    SELF.avgDailyReq := (L.avgDailyReq - stdValues.minAvgDailyReq)/(stdValues.maxAvgDailyReq - stdValues.minAvgDailyReq);
    SELF.avgDailyBIR := (L.avgDailyBIR - stdValues.minAvgBIR)/(stdValues.maxAvgBIR - stdValues.minAvgBIR);
END;

stdVectors := PROJECT($.Files.vectors.ds, Xform(LEFT));
OUTPUT(stdVectors,, $.Files.stdVectors.filepath, THOR, COMPRESSED, OVERWRITE);