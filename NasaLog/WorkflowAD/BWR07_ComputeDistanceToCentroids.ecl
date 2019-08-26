IMPORT NasaLog.Files;
IMPORT KMeans;
IMPORT NasaLog.workflowAD.Files as X;

labelsLayout := KMeans.Types.KMeans_Model.labels;
vectorsLayout := X.vectors.layout;

labeledVectorsRec := RECORD
    vectorsLayout;
    UNSIGNED3 label;
END;

labeledVectorsRec getLabels (vectorsLayout L, labelsLayout R) := TRANSFORM
    SELF.label := R.label;
    SELF := L;  
END;

labeledVectors := JOIN(X.vectors.ds, X.Labels.ds,
                        LEFT.windowID = RIGHT.id,
                        getLabels(LEFT, RIGHT));

distanceToCentroidRec := RECORD
    RECORDOF(labeledVectorsRec);
    REAL squaredDist;
END;

distanceToCentroidRec computeDistance (labeledVectorsRec L, vectorsLayout R) := TRANSFORM
    SELF.squaredDist := POWER((L.cntEvent1 - R.cntEvent1), 2) + POWER((L.cntEvent2 - R.cntEvent2), 2) + POWER((L.cntEvent3 - R.cntEvent3), 2);
    SELF := L;
END;

distanceToCentroids := JOIN(labeledVectors, X.Centroids.ds,
                           LEFT.label = RIGHT.windowID,
                           computeDistance(LEFT, RIGHT));

OUTPUT(distanceToCentroids,, $.Files.labeledVectors.filepath, THOR, COMPRESSED, OVERWRITE);

sumDist := SUM(distanceToCentroids, squaredDist);
OUTPUT(sumDist, NAMED('Total_Distance_to_Centroids'));