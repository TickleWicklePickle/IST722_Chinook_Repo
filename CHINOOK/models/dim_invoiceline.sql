{{ config(
    materialized='table'  
) }}

WITH stg_invoicelines AS (
    SELECT
        INVOICELINEID AS invoiceline_id, -- Primary key of the source system (business key)
        INVOICEID AS invoice_id,         -- Foreign key to the invoice dimension
        TRACKID AS track_id,             -- Foreign key to the track dimension
        UNITPRICE AS unit_price,         -- Price of the line item
        QUANTITY AS quantity             -- Quantity of the item in the line
    FROM {{ source('chinook', 'invoiceline') }} -- Correct source reference
    WHERE INVOICELINEID IS NOT NULL -- Ensuring no nulls for the primary key
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['stg_invoicelines.invoiceline_id']) }} AS invoiceline_key, -- Surrogate key
    stg_invoicelines.*
FROM stg_invoicelines
