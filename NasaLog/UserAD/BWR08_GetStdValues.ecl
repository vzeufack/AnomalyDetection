vectors := $.Files.vectors.ds;

REAL minAvgReqByWindow := MIN([MIN(vectors, avgReqInFirst8hrs), MIN(vectors, avgReqInSecond8hrs), MIN(vectors, avgReqInLast8hrs)]);
REAL maxAvgReqByWindow := MAX([MAX(vectors, avgReqInFirst8hrs), MAX(vectors, avgReqInSecond8hrs), MAX(vectors, avgReqInLast8hrs)]);
REAL minActiveDays := MIN(vectors, numberOfActiveDays);
REAL maxActiveDays := MAX(vectors, numberOfActiveDays);
REAL minAvgUniqDailyReq := MIN(vectors, avgUniqDailyReq);
REAL maxAvgUniqDailyReq := MAX(vectors, avgUniqDailyReq);
REAL minAvgDailyReq := MIN(vectors, avgdailyreq);
REAL maxAvgDailyReq := MAX(vectors, avgdailyreq);
REAL minAvgBIR := MIN(vectors, avgdailybir);
REAL maxAvgBIR := MAX(vectors, avgdailybir);

stdVal := DATASET([{minAvgReqByWindow, maxAvgReqByWindow,
                    minActiveDays, maxActiveDays,
                    minAvgUniqDailyReq, maxAvgUniqDailyReq,
                    minAvgDailyReq, maxAvgDailyReq,
                    minAvgBIR, maxAvgBIR}], $.Files.StdValues.layout);

OUTPUT(stdVal,, $.Files.StdValues.filepath, THOR, COMPRESSED, OVERWRITE);