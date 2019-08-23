IMPORT ML_CORE;
IMPORT KMeans;
IMPORT NasaLog.Utils;
IMPORT NasaLog.UserAD.Files as X;

stdVectors := X.StdVectors.ds;

ML_Core.ToField(stdVectors, ML_data);
ML_data;
noc := 1;
centroidSet := Utils.GetCentroidIDs(COUNT(stdVectors), noc);

Centroids := ML_data(id IN SET(centroidSet, id));
Max_iterations := 30;
Tolerance := 0.03;
Pre_Model := KMeans.KMeans(Max_iterations, Tolerance);
//Model := Pre_Model.Fit( ML_Data(number < 9), Centroids(number < 9));
Model := Pre_Model.Fit(ML_Data, Centroids);

Centers := KMeans.KMeans().Centers(Model);
ML_CORE.FromField(centers, X.stdVectors.Layout, centerDS);
OUTPUT(centerDS,, X.Centroids.filepath, THOR, COMPRESSED, OVERWRITE);

Total_Iterations := KMeans.KMeans().iterations(Model);
OUTPUT(Total_Iterations, NAMED('number_of_iterations'));

labels := KMeans.KMeans().Labels(Model);
OUTPUT(labels,, X.Labels.filepath, THOR, COMPRESSED, OVERWRITE);