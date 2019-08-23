IMPORT STD;

$.Files.ParsedLog.layout parseLog ($.Files.RawLog.layout L) := TRANSFORM
    split1 := STD.STR.Splitwords(L.entry, ' - - ');
    split2 := STD.STR.Splitwords(split1[2], '] "');
    split3 := STD.STR.Splitwords(split2[2], '" ');
    split4 := IF(split3[2] <> 'HTTP/1.0', STD.STR.Splitwords(split3[2], ' '),
                                        STD.STR.Splitwords(split3[3], ' '));
    self.datetime := split2[1];
    self.userIP := split1[1];    
    self.request := IF(split3[2] = 'HTTP/1.0', split3[1] + ' HTTP/1.0', split3[1]);
    self.replyCode := split4[1];
    self.bytesInReply := IF(split4[2] = '-', -1, (INTEGER)split4[2]);
END;

parsedLog := PROJECT($.Files.RawLog.ds, parseLog(LEFT));
OUTPUT(parsedLog,, $.Files.ParsedLog.filepath, THOR, COMPRESSED, OVERWRITE);
