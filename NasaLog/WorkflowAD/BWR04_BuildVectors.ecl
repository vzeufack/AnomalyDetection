sortedWD := SORT($.Files.windowedData.ds, windowID, eventID);
groupedWD := GROUP(sortedWD, windowID, eventID);
vectorsLayout := $.Files.vectors.layout;

tempVectorsLayout := RECORD
    groupedWD.windowID;
    REAL cntEvent1 := IF (groupedWD.eventID = '37e3d9fa', COUNT(GROUP), 0);
    REAL cntEvent2 := IF (groupedWD.eventID = '9489aaef', COUNT(GROUP), 0);
    REAL cntEvent3 := IF (groupedWD.eventID = '5f4370ac', COUNT(GROUP), 0);
END;

tempVectors := TABLE(groupedWD, tempVectorsLayout);
tempVectors;

vectorsLayout Xform (vectorsLayout L, vectorsLayout R) := TRANSFORM
    SELF.windowID := L.windowID;
    SELF.cntEvent1 := L.cntEvent1 + R.cntEvent1;
    SELF.cntEvent2 := L.cntEvent2 + R.cntEvent2;
    SELF.cntEvent3 := L.cntEvent3 + R.cntEvent3;
END;

vectors := ROLLUP(tempVectors,
                  LEFT.windowID = RIGHT.windowID,
                  Xform (LEFT, RIGHT));

OUTPUT(vectors(cntEvent1 <> 0 OR cntEvent2 <> 0 OR cntEvent3 <> 0),, $.Files.vectors.filepath, THOR, COMPRESSED, OVERWRITE);