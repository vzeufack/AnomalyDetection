IMPORT STD;

//DateTime pattern => [99/Aaa/9999:99:99:99 -9999]
PATTERN n := PATTERN('[0-9]+'); //number
PATTERN w := PATTERN('[A-Za-z]+'); //word
RULE datetimeRule := '[' n '/' w '/' n ':' n ':' n ':' n ' -' n;

parsedLogLayoutWithNoID := RECORDOF($.Files.enrichedLog.layout) AND NOT [recID];

parsedLogLayoutWithNoID enrich($.Files.ParsedLog.layout L):= TRANSFORM 
    SELF.date := MATCHTEXT(n[1]) + '-' + MATCHTEXT(w) + '-' + MATCHTEXT(n[2]);
    SELF.time := MATCHTEXT(n[3]) + ':' + MATCHTEXT(n[4]) + ':' + MATCHTEXT(n[5]);
    SELF.timezone := MATCHTEXT(n[6]);
    SELF := L;
END;

enrichedLogWithNoID := PARSE($.Files.parsedLog.ds, datetime, datetimeRule, enrich(LEFT), SCAN ALL);
SortedEnrichedLogWithNoID := SORT(enrichedLogWithNoID, date, time);

$.Files.enrichedLog.layout addID (SortedEnrichedLogWithNoID L, UNSIGNED cnt) := TRANSFORM
    SELF.recID := cnt;
    SELF := L;
END;

enrichedLog := PROJECT(SortedEnrichedLogWithNoID, addID(LEFT, COUNTER));
OUTPUT(enrichedLog,, $.Files.enrichedLog.filepath, THOR, COMPRESSED, OVERWRITE);