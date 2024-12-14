{{ config(
    materialized='table'  
) }}

WITH stg_genre_analysis AS (
    SELECT
        T.GENREID AS genre_id                               -- Foreign key to the genre dimension
        ,G.NAME AS genre_name                                -- Name of the genre
        ,count(distinct(T.trackid)) as tracks_per_genre       -- number of tracks per genre
        ,SUM(IL.QUANTITY) AS tracks_purchased_per_genre              -- Total quantity of tracks purchased per genre
        ,count(distinct(p.playlistid)) as playlists_per_genre
        ,SUM(IL.UNITPRICE * IL.QUANTITY) AS revenue_per_genre -- Total revenue per genre
        --,to_date( I.INVOICEDATE) AS purchase_date                      -- Date of purchase
    FROM {{ source('chinook', 'invoice') }} I
    JOIN {{ source('chinook', 'invoiceline') }} IL ON I.INVOICEID = IL.INVOICEID
    JOIN {{ source('chinook', 'track') }} T ON IL.TRACKID = T.TRACKID
    JOIN {{ source('chinook', 'genre') }} G ON T.GENREID = G.GENREID
    join {{source('chinook', 'playlisttrack')}} P ON P.TRACKID = T.TRACKID
    GROUP BY
        T.GENREID
        ,G.NAME
       -- ,I.INVOICEDATE
)

SELECT
   -- {{ dbt_utils.generate_surrogate_key(['stg_genre_analysis.genre_id', 'stg_genre_analysis.purchase_date']) }} AS genre_analysis_key, -- Surrogate key
    stg_genre_analysis.*
FROM stg_genre_analysis
order by genre_id
