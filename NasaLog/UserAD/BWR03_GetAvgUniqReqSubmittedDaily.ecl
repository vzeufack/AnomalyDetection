IMPORT NasaLog.Files as X;

sortedCleanLog := SORT(X.cleanLog.ds, userIP, date, request);
cleanLogWithNoDuplicates := DEDUP(sortedCleanLog, userIP, date, request);
groupedDedupedCleanLog := GROUP(cleanLogWithNoDuplicates, userIP, date);

uniqDailyReqCountRec := RECORD
    groupedDedupedCleanLog.userIP;
    groupedDedupedCleanLog.date;
    UNSIGNED numOfUniqDailyReq := COUNT(GROUP);
END;

uniqDailyReqCount := TABLE(groupedDedupedCleanLog, uniqDailyReqCountRec);

groupedUniqDailyReqCnt := GROUP(uniqDailyReqCount, userIP);

avgUniqDailyReqRec := RECORD
    groupedUniqDailyReqCnt.userIP;
    REAL avg := AVE(GROUP, groupedUniqDailyReqCnt.numOfUniqDailyReq);
END;

avgUniqDailyReq := TABLE(groupedUniqDailyReqCnt, avgUniqDailyReqRec);
OUTPUT(avgUniqDailyReq,, $.Files.avgDailyUniqReq.filepath, THOR, COMPRESSED, OVERWRITE);