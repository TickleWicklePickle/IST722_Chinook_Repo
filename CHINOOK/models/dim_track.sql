{{ config(
    materialized='table'  
) }}

WITH stg_tracks AS (
    SELECT
        TRACKID AS track_id,          -- Primary key of the source system (business key)
        NAME AS track_name,           -- Track name
        ALBUMID AS album_id,          -- Album ID (foreign key to dim_album)
        MEDIATYPEID AS media_type_id, -- Media type ID
        GENREID AS genre_id,          -- Genre ID (foreign key to dim_genre)
        COMPOSER AS composer,         -- Track composer
        MILISECONDS AS milliseconds,  -- Track duration in milliseconds
        BYTES AS bytes,               -- File size in bytes
        UNITPRICE AS unit_price       -- Price per track
    FROM {{ source('chinook', 'track') }} -- Correct source reference
    WHERE TRACKID IS NOT NULL  -- Ensuring no nulls for the primary key
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['stg_tracks.track_id']) }} AS track_key, -- Surrogate key
    stg_tracks.*
FROM stg_tracks
