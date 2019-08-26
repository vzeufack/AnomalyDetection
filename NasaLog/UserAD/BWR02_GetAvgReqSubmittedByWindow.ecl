sortedWindowData := SORT($.Files.windowedLog.ds, date, userIP, window);
groupedWindowedData := GROUP(sortedWindowData, date, userIP, window);

reqCountLayout := RECORD
    groupedWindowedData.date;
    groupedWindowedData.userIP;
    UNSIGNED cnt1 := IF(groupedWindowedData.window = 1, COUNT(GROUP), 0);
    UNSIGNED cnt2 := IF(groupedWindowedData.window = 2, COUNT(GROUP), 0);
    UNSIGNED cnt3 := IF(groupedWindowedData.window = 3, COUNT(GROUP), 0);
END;

TempCounts := TABLE(groupedWindowedData, reqCountLayout);

reqCountLayout countRequests (reqCountLayout L, reqCountLayout R) := TRANSFORM
    SELF.cnt1 := L.cnt1 + R.cnt1;
    SELF.cnt2 := L.cnt2 + R.cnt2;
    SELF.cnt3 := L.cnt3 + R.cnt3;
    SELF := L;
END;

Counts := ROLLUP (TempCounts,
                  LEFT.date = RIGHT.date AND LEFT.userIP = RIGHT.userIP,
                  countRequests(LEFT, RIGHT));
sortedCounts := SORT(Counts, userIP);
groupedCounts := GROUP(sortedCounts, userIP);

avgReqLayout := RECORD
    groupedCounts.userIP;
    REAL avgReqInFirst8Hrs := AVE(GROUP, groupedCounts.cnt1);
    REAL avgReqInSecond8Hrs := AVE(GROUP, groupedCounts.cnt2);
    REAL avgReqInLast8Hrs := AVE(GROUP, groupedCounts.cnt3);
    REAL numberOfActiveDays := COUNT(GROUP);
END;

avgCounts := TABLE(groupedCounts, avgReqLayout);
OUTPUT(avgCounts,, $.Files.avgReqByWindow.filepath, THOR, COMPRESSED, OVERWRITE);