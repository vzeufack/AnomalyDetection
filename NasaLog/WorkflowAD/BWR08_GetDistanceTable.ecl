IMPORT NasaLog;
IMPORT KMeans;
IMPORT Visualizer;

labelLayout := KMeans.Types.KMeans_Model.labels;
labels := $.Files.Labels.ds;
centroids := $.Files.Centroids.ds;
labeledVectors := $.Files.labeledVectors.ds;
sortedLabeledVectors := SORT(labeledVectors, label, windowID);

distToCentreByClusterRec := RECORD
    sortedLabeledVectors.label;
    sortedLabeledVectors.windowID;
    sortedLabeledVectors.squaredDist;
END;

distanceToCentroid := TABLE(sortedLabeledVectors, distToCentreByClusterRec, label, windowID);
OUTPUT(distanceToCentroid(label = 1),, '~nasaLog::workflowAD::distance#1.csv', CSV, OVERWRITE);
OUTPUT(distanceToCentroid(label = 331),, '~nasaLog::workflowAD::distance#331.csv', CSV, OVERWRITE);

distanceRec := RECORD
    distanceToCentroid.windowID;
    distanceToCentroid.squaredDist;
END;

distances1 := TABLE(distanceToCentroid(label = 1), distanceRec);
distances2 := TABLE(distanceToCentroid(label = 331), distanceRec);

OUTPUT(distances1, ALL, NAMED('distancePlot1')); 
viz_bar1 := Visualizer.Visualizer.MultiD.Bar('Bar1',, 'distancePlot1'); 
viz_bar1;

OUTPUT(distances2, ALL, NAMED('distancePlot2')); 
viz_bar2 := Visualizer.Visualizer.MultiD.Bar('Bar2',, 'distancePlot2'); 
viz_bar2;