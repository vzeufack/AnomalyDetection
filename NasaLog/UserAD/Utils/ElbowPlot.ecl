IMPORT Visualizer;

ds := DATASET([{1, 642},
               {2, 420},
               {3, 310},
               {4, 298},
               {5, 203},
               {6, 188},
               {7, 166},
               {8, 134},
               {9, 125},
               {10, 114}], {UNSIGNED1 id, UNSIGNED sse});

dsOutput := OUTPUT(ds, NAMED('elbowPlot')); 
dsOutput;
viz_scatter := Visualizer.Visualizer.MultiD.Line('Line',, 'elbowPlot'); 
viz_scatter;