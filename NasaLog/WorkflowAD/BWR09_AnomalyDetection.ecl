IMPORT NasaLog;

abnormalVectors1 := $.Files.labeledVectors.ds(label = 1 AND squareddist >= 10000000);
abnormalVectors2 := $.Files.labeledVectors.ds(label = 331 AND squareddist >= 2200000);
OUTPUT(COUNT(abnormalVectors1), NAMED('Number_of_potential_abnormal_windows_1'));
OUTPUT(abnormalVectors1,, '~nasalog::workflowAD::abnormalWindows#1', THOR, COMPRESSED, OVERWRITE);
OUTPUT(COUNT(abnormalVectors2), NAMED('Number_of_potential_abnormal_windows_2'));
OUTPUT(abnormalVectors2,, '~nasalog::workflowAD::abnormalWindows#2', THOR, COMPRESSED, OVERWRITE);