IMPORT NasaLog.Files as X;

IPs := TABLE(X.cleanLog.ds,{userIP},userIP);
uniqueIPs := SET(SORT(IPs,userIP),userIP);
IpDS := DATASET(uniqueIPs, {STRING val});

$.Files.userIPLookupTable.layout assignUserID (IpDS L, UNSIGNED3 cnt) := TRANSFORM
    SELF.userID := cnt;
    SELF.userIP := L.val;
END;

userIPLookupTable := PROJECT(IPds, assignUserID(LEFT, COUNTER));
OUTPUT(userIPLookupTable,, $.Files.userIPLookupTable.filepath, THOR, COMPRESSED, OVERWRITE);