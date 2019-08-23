IMPORT NasaLog.Files as X;
IMPORT KMeans;

EXPORT Files := MODULE
    EXPORT windowedLog := MODULE
        EXPORT layout := RECORD
            RECORDOF(X.CleanLog.layout) AND NOT [recID, timezone, request, replyCode, bytesInReply];
            UNSIGNED1 window;
        END;

        EXPORT filepath := '~nasalog::userad::windowedLog';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT userIPLookupTable := MODULE
        EXPORT layout := RECORD
            UNSIGNED3 userID;
            STRING53 userIP;
        END;

        EXPORT filepath := '~nasalog::userad::userIPLookupTable';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT avgReqByWindow := MODULE
        EXPORT layout := RECORD
            RECORDOF(windowedLog.layout) AND NOT [time, window, date];
            REAL avgReqInFirst8Hrs;
            REAL avgReqInSecond8Hrs;
            REAL avgReqInLast8Hrs;
            REAL numberOfActiveDays;
        END;

        EXPORT filepath := '~nasalog::userad::avgReqByWindow';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT avgDailyUniqReq := MODULE
        EXPORT layout := RECORD
            X.Cleanlog.layout.userIP;
            REAL avg;
        END;

        EXPORT filepath := '~nasalog::userad::avgDailyUniqReq';
        EXPORT ds := DATASET(filepath, layout, THOR); 
    END;

    EXPORT avgDailyReq := MODULE
        EXPORT layout := RECORD
            X.Cleanlog.layout.userIP;
            REAL avg;
        END;

        EXPORT filepath := '~nasalog::userad::avgDailyReq';
        EXPORT ds := DATASET(filepath, layout, THOR); 
    END;

    EXPORT avgDailyBIR := MODULE
        EXPORT layout := RECORD
            X.Cleanlog.layout.userIP;
            REAL avg;
        END;

        EXPORT filepath := '~nasalog::userad::avgDailyBIR';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT vectors := MODULE
        EXPORT Layout := RECORD
            UNSIGNED3 userID;
            RECORDOF(avgReqByWindow.layout) AND NOT [userIP];
            REAL avgUniqDailyReq;
            REAL avgDailyReq;
            REAL avgDailyBIR;
        END;

        EXPORT filepath := '~nasalog::userad::vectors';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT StdValues := MODULE
        EXPORT layout := RECORD
            REAL minAvgReqByWindow;
            REAL maxAvgReqByWindow;
            REAL minActiveDays;
            REAL maxActiveDays;
            REAL minAvgUniqDailyReq;
            REAL maxAvgUniqDailyReq;
            REAL minAvgDailyReq;
            REAL maxAvgDailyReq;
            REAL minAvgBIR;
            REAL maxAvgBIR;
        END;

        EXPORT filepath := '~nasalog::userad::stdValues';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT StdVectors := MODULE
        EXPORT layout := RECORD
            RECORDOF(vectors.Layout);
        END;

        EXPORT filepath := '~nasalog::userad::stdvectors';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT Centroids := MODULE
        EXPORT layout := RECORD
            RECORDOF(StdVectors.layout);
        END;

        EXPORT filepath := '~nasalog::userad::centroids';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT Labels := MODULE
        EXPORT layout := RECORD
            RECORDOF(KMeans.Types.KMeans_Model.labels);
        END;

        EXPORT filepath := '~nasalog::userad::labels';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT labeledVectors := MODULE
        EXPORT layout := RECORD
            RECORDOF(stdVectors.Layout);
            UNSIGNED3 label;
            REAL distance;
        END;

        EXPORT filepath := '~nasalog::userad::labeledVectors';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;
END;