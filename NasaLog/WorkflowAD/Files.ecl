IMPORT NasaLog.Files as X;
IMPORT KMeans;

EXPORT Files := MODULE
    EXPORT structuredLog := MODULE
        EXPORT layout := RECORD
            X.cleanLog.layout;
            STRING eventID;
            STRING eventTemplate;
        END;

        EXPORT filepath := '~nasalog::workflowAD::structuredLog';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT windowedData := MODULE
        EXPORT layout := RECORD
            structuredLog.layout;
            UNSIGNED windowID;
        END;

        EXPORT filepath := '~nasalog::workflowAD::windowedData';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT vectors := MODULE
        EXPORT layout := RECORD
            UNSIGNED windowID;
            REAL cntEvent1;
            REAL cntEvent2;
            REAL cntEvent3;
        END;

        EXPORT filepath := '~nasalog::workflowAD::vectors';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT Centroids := MODULE
        EXPORT layout := RECORD
            RECORDOF(vectors.layout);
        END;

        EXPORT filepath := '~nasalog::workflowAD::centroids';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT Labels := MODULE
        EXPORT layout := RECORD
            RECORDOF(KMeans.Types.KMeans_Model.labels);
        END;

        EXPORT filepath := '~nasalog::workflowAD::labels';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT labeledVectors := MODULE
        EXPORT layout := RECORD
            RECORDOF(vectors.Layout);
            UNSIGNED3 label;
            REAL squaredDist;
        END;

        EXPORT filepath := '~nasalog::workflowAD::labeledVectors';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;
END;