$.Files.windowedData.layout Xform ($.Files.structuredLog.layout L) := TRANSFORM
    SELF.windowID := (((UNSIGNED)L.date[1..2] - 1) * 24) + ((UNSIGNED)L.time[1..2] + 1);
    SELF := L;
END;

windowedData := PROJECT($.Files.structuredLog.ds, Xform(LEFT));
OUTPUT(windowedData,, $.Files.windowedData.filepath, THOR, COMPRESSED, OVERWRITE);
//OUTPUT(MAX(windowedData, windowID));