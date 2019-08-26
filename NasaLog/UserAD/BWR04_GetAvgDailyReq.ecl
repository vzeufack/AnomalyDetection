IMPORT NasaLog.Files as X;

sortedCleanLog := SORT(X.cleanLog.ds, userIP, date, request);
groupedCleanLog := GROUP(sortedCleanLog, userIP, date);

dailyReqCountRec := RECORD
    groupedCleanLog.userIP;
    groupedCleanLog.date;
    UNSIGNED numOfDailyReq := COUNT(GROUP);
END;

dailyReqCount := TABLE(groupedCleanLog, dailyReqCountRec);

groupedDailyReqCnt := GROUP(dailyReqCount, userIP);

avgDailyReqRec := RECORD
    groupedDailyReqCnt.userIP;
    REAL avg := AVE(GROUP, groupedDailyReqCnt.numOfDailyReq);
END;

avgDailyReq := TABLE(groupedDailyReqCnt, avgDailyReqRec);
OUTPUT(avgDailyReq,, $.Files.avgDailyReq.filepath, THOR, COMPRESSED, OVERWRITE);