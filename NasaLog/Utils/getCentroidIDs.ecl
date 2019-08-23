EXPORT getCentroidIDs(UNSIGNED dataSize, UNSIGNED noc) := FUNCTION
    step := ROUNDUP(dataSize/noc);
    ds1 := DATASET([{1}], {UNSIGNED id});
    ds2 := IF(noc > 1, DATASET(noc-1,
                               TRANSFORM({UNSIGNED id},
                                          SELF.id := step*COUNTER),
                                          LOCAL
                               )
             );
    ds := IF(noc > 1, ds1 + ds2, ds1);
    RETURN ds;
END;