{{ config(
    materialized='table'  
) }}

WITH stg_genre_analysis AS (
    SELECT
        T.GENREID AS genre_id,                               -- Foreign key to the genre dimension
        G.NAME AS genre_name,                                -- Name of the genre
        SUM(IL.UNITPRICE * IL.QUANTITY) AS total_order_amount, -- Total revenue per genre
        SUM(IL.QUANTITY) AS quantity_of_order,              -- Total quantity of tracks purchased per genre
        I.INVOICEDATE AS purchase_date                      -- Date of purchase
    FROM {{ source('chinook', 'invoice') }} I
    JOIN {{ source('chinook', 'invoiceline') }} IL ON I.INVOICEID = IL.INVOICEID
    JOIN {{ source('chinook', 'track') }} T ON IL.TRACKID = T.TRACKID
    JOIN {{ source('chinook', 'genre') }} G ON T.GENREID = G.GENREID
    GROUP BY
        T.GENREID,
        G.NAME,
        I.INVOICEDATE
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['stg_genre_analysis.genre_id', 'stg_genre_analysis.purchase_date']) }} AS genre_analysis_key, -- Surrogate key
    stg_genre_analysis.*
FROM stg_genre_analysis
