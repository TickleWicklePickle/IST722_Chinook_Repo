{{ config(
    materialized='table'  
) }}

WITH stg_genre AS (
    SELECT
        genreid AS genre_id          -- Primary key of the source system (business key)
        ,name AS genre_name         -- genre name
     
    FROM raw.chinook.genre
    where genreid is not null
)


SELECT
 {{ dbt_utils.generate_surrogate_key(['stg_genre.genre_id']) }} AS genre_key
  , stg_genre.*
FROM stg_genre
