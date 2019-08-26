IMPORT ML_CORE;
IMPORT KMeans;
IMPORT NasaLog.Utils;
IMPORT NasaLog.WorkflowAD.Files;

vectors := $.Files.vectors.ds;

ML_Core.ToField(vectors, ML_data);
noc := 2;
centroidSet := Utils.GetCentroidIDs(COUNT(vectors), noc);

Centroids := ML_data(id IN SET(centroidSet, id));
Max_iterations := 30;
Tolerance := 0.03;
Pre_Model := KMeans.KMeans(Max_iterations, Tolerance);
Model := Pre_Model.Fit(ML_Data, Centroids);

Centers := KMeans.KMeans().Centers(Model);
ML_CORE.FromField(centers, Files.vectors.Layout, centerDS);
OUTPUT(centerDS,, $.Files.Centroids.filepath, THOR, COMPRESSED, OVERWRITE);

Total_Iterations := KMeans.KMeans().iterations(Model);
OUTPUT(Total_Iterations, NAMED('Number_of_Iterations'));

labels := KMeans.KMeans().Labels(Model);
OUTPUT(labels,, $.Files.Labels.filepath, THOR, COMPRESSED, OVERWRITE);