IMPORT NasaLog.Files as X;

sortedCleanLog := SORT(X.cleanLog.ds, userIP, date);
filteredData := sortedCleanLog (bytesInReply <> -1);
groupedData := GROUP(filteredData, userIP, date);

avgBIRByDateRec := RECORD
    groupedData.userIP;
    groupedData.date;
    REAL avg := AVE(GROUP, groupedData.bytesInReply);
END;

avgBIRByDate := TABLE(groupedData, avgBIRByDateRec);

groupedAvgBIRByDate := GROUP(avgBIRByDate, userIP);

avgDailyBIRRec := RECORD
    groupedAvgBIRByDate.userIP;
    REAL avg := AVE(GROUP, groupedAvgBIRByDate.avg);
END;

avgDailyBIR := TABLE(groupedAvgBIRByDate, avgDailyBIRRec);
OUTPUT(avgDailyBIR,, $.Files.avgDailyBIR.filepath, THOR, COMPRESSED, OVERWRITE);