IMPORT NasaLog.UserAD as X;

stdVectorsRec := X.Files.stdVectors.layout;
vectorsRec := X.Files.vectors.layout;
stdValues := X.Files.StdValues.ds[1];

EXPORT GetOriginalVector (DATASET(stdVectorsRec) stdVectors) := FUNCTION
    vectorsRec Xform (stdVectorsRec L) := TRANSFORM
        SELF.userID := L.userID;
        SELF.avgReqInFirst8Hrs := L.avgReqInFirst8Hrs * (stdValues.maxAvgReqbyWindow - stdValues.minAvgReqbyWindow) + stdValues.minAvgReqbyWindow;
        SELF.avgReqInSecond8Hrs := L.avgReqInSecond8Hrs * (stdValues.maxAvgReqbyWindow - stdValues.minAvgReqbyWindow) + stdValues.minAvgReqbyWindow;
        SELF.avgReqInLast8Hrs := L.avgReqInLast8Hrs * (stdValues.maxAvgReqbyWindow - stdValues.minAvgReqbyWindow) + stdValues.minAvgReqbyWindow;
        SELF.numberOfActiveDays := L.numberOfActiveDays * (stdValues.maxActiveDays - stdValues.minActiveDays) + stdValues.minActiveDays;
        SELF.avgUniqDailyReq := L.avgUniqDailyReq * (stdValues.maxAvgUniqDailyReq - stdValues.minAvgUniqDailyReq) + stdValues.minAvgUniqDailyReq;
        SELF.avgDailyReq := L.avgDailyReq * (stdValues.maxAvgDailyReq - stdValues.minAvgDailyReq) + stdValues.minAvgDailyReq;
        SELF.avgDailyBIR := L.avgDailyBIR * (stdValues.maxAvgBIR - stdValues.minAvgBIR) + stdValues.minAvgBIR;
    END;

    originalVectors := PROJECT(stdVectors, Xform(LEFT));
    RETURN originalVectors;
END;