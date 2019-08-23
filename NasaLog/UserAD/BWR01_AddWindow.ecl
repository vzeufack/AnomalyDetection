IMPORT NasaLog.Files as X;

determineWindow (UNSIGNED2 h, UNSIGNED2 n) := FUNCTION  
    windowID := IF(h = 0, 1, ROUNDUP((h * n)/24.0));
	RETURN windowID;
END;

windowedLogLayout := $.Files.windowedLog.layout;

windowedLogLayout assignWindow (X.cleanLog.layout L) := TRANSFORM
    SELF.window := determineWindow((UNSIGNED2)L.time[1..2], 3);
    SELF := L;
END;

windowedLog := PROJECT(X.cleanLog.ds, assignWindow(LEFT));
OUTPUT(windowedLog,, $.Files.windowedLog.filepath, THOR, COMPRESSED, OVERWRITE);