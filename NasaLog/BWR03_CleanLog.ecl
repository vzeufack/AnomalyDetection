IMPORT DataPatterns;
IMPORT NasaLog;

enrichedLogPatterns := DataPatterns.Profile(NasaLog.Files.EnrichedLog.ds, 
                     features := 'fill_rate,cardinality,best_ecl_types,lengths,patterns,modes'):
                     PERSIST('~nasalog::persist::enrichedLogPatterns');
OUTPUT(enrichedLogPatterns);

$.Files.CleanLog.layout clean ($.Files.EnrichedLog.layout L) := TRANSFORM
    SELF.recID := (UNSIGNED4)L.recID;
    SELF.date := (STRING11)L.date;
    SELF.time := (STRING8)L.time;
    SELF.timezone := (UNSIGNED2)L.timezone;
    SELF.userIP := (STRING53)L.userIP;
    SELF.request := (STRING333)L.request;
    SELF.replyCode := (UNSIGNED2)L.replyCode;
    SELF.bytesInReply := (INTEGER4)L.bytesInReply;
END;

cleanLog := PROJECT($.Files.EnrichedLog.ds, clean(LEFT));
OUTPUT(cleanLog,, $.Files.CleanLog.filepath, THOR, COMPRESSED, OVERWRITE);