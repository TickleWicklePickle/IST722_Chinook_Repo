{{ config(
    materialized='table'  
) }}

WITH stg_playlists AS (
    SELECT
        p1.PLAYLISTID AS playlist_id   -- Ensure this alias matches the YAML
        ,p1.NAME AS playlist_name        -- Ensure this alias matches the YAML
        ,p2.trackid as track_id
    FROM raw.chinook.playlist p1
    left join raw.chinook.playlisttrack p2 on p1.playlistid = p2.playlistid
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['stg_playlists.playlist_id']) }} AS playlist_key, -- Surrogate key
    stg_playlists.*
FROM stg_playlists
