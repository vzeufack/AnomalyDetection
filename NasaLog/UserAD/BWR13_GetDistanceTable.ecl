IMPORT NasaLog;
IMPORT KMeans;
IMPORT Visualizer;

labelLayout := KMeans.Types.KMeans_Model.labels;
labels := $.Files.Labels.ds;
centroids := $.Files.Centroids.ds;
labeledVectors := $.Files.labeledVectors.ds;

distToCentreByClusterRec := RECORD
    labeledVectors.userID;
    labeledVectors.distance;
END;

distanceToCentroid := TABLE(labeledVectors, distToCentreByClusterRec);

OUTPUT(distanceToCentroid,, '~nasaLog::userAD::distance.csv', CSV, OVERWRITE);

OUTPUT(distanceToCentroid, NAMED('distancePlot')); 
viz_bar := Visualizer.Visualizer.MultiD.Bar('Bar',, 'distancePlot'); 
viz_bar;