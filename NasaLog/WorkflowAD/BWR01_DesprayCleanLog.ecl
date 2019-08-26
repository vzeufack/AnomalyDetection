IMPORT NasaLog;
IMPORT STD;

cleanLogLayout := NasaLog.Files.cleanLog.layout;

cleanLogLayout Xform (cleanLogLayout L) := TRANSFORM
    SELF.userIP := STD.Str.FindReplace(L.userIP, ',','$');
    SELF.request := STD.Str.FindReplace(L.request, ',','$');
    SELF := L;
END;

formattedCleanLog := PROJECT(NasaLog.Files.cleanLog.ds, Xform(LEFT));
OUTPUT(formattedCleanLog,, '~nasalog::workflowAD::cleanLogDollar.csv', CSV, OVERWRITE);
//OUTPUT(formattedCleanLog (STD.Str.Contains(userIP, ',', TRUE) OR STD.Str.Contains(request, ',', TRUE)));