IMPORT Visualizer;

ds := DATASET([{1, 1859857932},
               {2, 662257110},
               {3, 394045746},
               {4, 247283663},
               {5, 166924035},
               {6, 106438953},
               {7, 80945491},
               {8, 66853227},
               {9, 60334460},
               {10, 53193420}], {UNSIGNED1 id, UNSIGNED sse});

dsOutput := OUTPUT(ds, NAMED('elbowPlot')); 
dsOutput;
viz_scatter := Visualizer.Visualizer.MultiD.Line('Line',, 'elbowPlot'); 
viz_scatter;