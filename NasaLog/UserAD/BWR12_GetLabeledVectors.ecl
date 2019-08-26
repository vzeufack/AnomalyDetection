IMPORT KMeans;

labelsLayout := KMeans.Types.KMeans_Model.labels;
stdVectorsLayout := $.Files.StdVectors.layout;

labeledVectorsRec := RECORD
    stdVectorsLayout;
    UNSIGNED3 label;
END;

labeledVectorsRec getLabels (stdVectorsLayout L, labelsLayout R) := TRANSFORM
    SELF.label := R.label;
    SELF := L;  
END;

labeledVectors := JOIN($.Files.stdVectors.ds, $.Files.Labels.ds,
                        LEFT.userID = RIGHT.id,
                        getLabels(LEFT, RIGHT));

distanceToCentroidRec := RECORD
    RECORDOF(labeledVectorsRec);
    REAL distance;
END;

distanceToCentroidRec computeDistance (labeledVectorsRec L, stdVectorsLayout R) := TRANSFORM
    SELF.distance := POWER((L.avgReqInFirst8Hrs - R.avgReqInFirst8Hrs), 2) + POWER((L.avgReqInSecond8Hrs - R.avgReqInSecond8Hrs), 2) 
                            + POWER((L.avgReqInLast8Hrs - R.avgReqInLast8Hrs), 2) + POWER((L.numberOfActiveDays - R.numberOfActiveDays), 2)
                            + POWER((L.avgUniqDailyReq - R.avgUniqDailyReq), 2) + POWER((L.avgDailyReq - R.avgDailyReq), 2) + POWER((L.avgDailyBIR - R.avgDailyBIR), 2) ;
    SELF := L;
END;

distanceToCentroids := JOIN(labeledVectors, $.Files.Centroids.ds,
                            LEFT.label = RIGHT.userID,
                            computeDistance(LEFT, RIGHT));

OUTPUT(distanceToCentroids,, $.Files.labeledVectors.filepath, THOR, COMPRESSED, OVERWRITE);

sumDist := SUM(distanceToCentroids, distance);
OUTPUT(sumDist, NAMED('Total_Distance_to_Centroids'));