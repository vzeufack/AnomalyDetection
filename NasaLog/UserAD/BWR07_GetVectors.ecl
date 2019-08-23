userIPLookupTable := $.Files.userIPLookupTable.ds;

vectorsLayout := RECORD
    STRING53 userIP;
    RECORDOF($.Files.avgReqByWindow.layout) AND NOT [userIP];
    REAL avgUniqDailyReq := 0;
    REAL avgDailyReq := 0;
    REAL avgDailyBIR := 0;
END;

vectorsLayout addAvgUniqDailyReq ($.Files.avgReqByWindow.layout L, $.Files.avgDailyUniqReq.layout R) := TRANSFORM
    SELF.avgUniqDailyReq := R.avg;
    SELF := L;
END;

vectorsPart1 := JOIN($.Files.avgReqByWindow.ds, $.Files.avgDailyUniqReq.ds,
                     LEFT.userIP = RIGHT.userIP,
                     addAvgUniqDailyReq(LEFT, RIGHT));

vectorsLayout addAvgDailyReq (vectorsLayout L, $.Files.avgDailyReq.layout R) := TRANSFORM
    SELF.avgDailyReq := R.avg;
    SELF := L;
END;

vectorsPart2 := JOIN(vectorsPart1, $.Files.avgDailyReq.ds,
                     LEFT.userIP = RIGHT.userIP,
                     addAvgDailyReq(LEFT, RIGHT));

vectorsLayout addAvgDailyBIR (vectorsLayout L, $.Files.avgDailyBIR.layout R) := TRANSFORM
    SELF.avgDailyBIR := R.avg;
    SELF := L;
END;

vectorsPart3 := JOIN(vectorsPart2, $.Files.avgDailyBIR.ds,
                     LEFT.userIP = RIGHT.userIP,
                     addAvgDailyBIR(LEFT, RIGHT));

$.Files.vectors.layout getVectors (vectorsLayout L, userIPLookupTable R) := TRANSFORM
    SELF.userID := R.userID;
    SELF := L;
END;

vectors := JOIN(vectorsPart3, userIPLookupTable,
                LEFT.userIP = RIGHT.userIP,
                getVectors(LEFT, RIGHT));

OUTPUT(vectors,, $.Files.vectors.filepath, THOR, COMPRESSED, OVERWRITE);
