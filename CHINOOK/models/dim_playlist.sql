{{ config(
    materialized='table'  
) }}

WITH stg_playlists AS (
    SELECT
        PLAYLISTID AS playlist_id,   -- Ensure this alias matches the YAML
        NAME AS playlist_name        -- Ensure this alias matches the YAML
    FROM raw.chinook.playlist
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['stg_playlists.playlist_id']) }} AS playlist_key, -- Surrogate key
    stg_playlists.*
FROM stg_playlists
