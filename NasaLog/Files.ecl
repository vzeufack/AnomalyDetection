EXPORT Files := MODULE
    EXPORT RawLog := MODULE
        EXPORT layout := RECORD
            STRING entry;
        END;
        
        EXPORT filepath := '~nasalog::rawLog';
        EXPORT ds := DATASET(filepath, layout, CSV);
    END;

    EXPORT ParsedLog := MODULE
        EXPORT layout := RECORD
            STRING datetime;
            STRING userIP;
            STRING request;
            STRING replyCode;
            INTEGER bytesInReply;
        END;

        EXPORT filepath := '~nasalog::parsedLog';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT EnrichedLog := MODULE
        EXPORT layout := RECORD
            UNSIGNED recID;
            STRING date;
            STRING time;
            STRING timezone;
            RECORDOF(ParsedLog.layout) AND NOT [datetime];
        END;

        EXPORT filepath := '~nasalog::enrichedLog';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;

    EXPORT cleanLog := MODULE
        EXPORT layout := RECORD
            UNSIGNED4 recID;
            STRING11 date;
            STRING8 time;
            UNSIGNED2 timezone;
            STRING53 userIP;
            STRING333 request;
            UNSIGNED2 replyCode;
            INTEGER4 bytesInReply;
        END;

        EXPORT filepath := '~nasalog::cleanLog';
        EXPORT ds := DATASET(filepath, layout, THOR);
    END;
END;