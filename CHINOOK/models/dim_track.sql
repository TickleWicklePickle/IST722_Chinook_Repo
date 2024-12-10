SELECT
    ROW_NUMBER() OVER (ORDER BY TRACKID) AS trackkey, -- To generate a surrogate key
    TRACKID AS trackid,
    NAME AS trackname,
    ALBUMID AS albumid,
    MEDIATYPEID AS mediatypeid,
    GENREID AS genreid,
    COMPOSER AS compose,
    MILISECONDS AS miliseconds,
    BYTES AS bytes,
    UNITPRICE AS unitprice
FROM raw.chinook.track
