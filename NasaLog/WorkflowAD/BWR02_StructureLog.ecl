tempRec := RECORD
    UNSIGNED lineID;
    $.Files.structuredLog.layout;
END;

dataWithEvent := DATASET('~nasalog::workflowad::processedCleanLogDollar', tempRec, CSV(HEADING(1)));

$.Files.structuredLog.layout Xform (tempRec L) := TRANSFORM
    SELF := L;
END;

structuredLog := PROJECT(dataWithEvent, Xform(LEFT));
//structuredLog;
OUTPUT(structuredLog,, $.Files.structuredLog.filepath, THOR, COMPRESSED, OVERWRITE);