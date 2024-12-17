{{ config(
    materialized='table'  
) }}

WITH stg_album AS (
    SELECT
       concat(al.albumid, a.artistid) as album_key
        ,AL.ALBUMID AS album_id          -- Primary key of the source system (business key)
        ,AL.TITLE AS album_title          -- ALBUM name
        ,A.ARTISTID AS artist_id
        ,A.NAME AS ARTIST_NAME
        
    FROM raw.chinook.album AL
    LEFT JOIN raw.chinook.artist A on A.artistid = AL.artistid

)


SELECT
    stg_album.*
FROM stg_album
