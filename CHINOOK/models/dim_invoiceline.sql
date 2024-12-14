{{ config(
    materialized='table'  
) }}

WITH stg_invoicelines AS (
    SELECT
        invoicelineid AS invoiceline_id, -- Primary key of the source system (business key)
        invoiceid AS invoice_id,         -- Foreign key to the invoice dimension
        trackid AS track_id,             -- Foreign key to the track dimension
        unitprice AS unit_price,         -- Price of the line item
        quantity AS quantity             -- Quantity of the item in the line
    FROM {{ source('chinook', 'invoiceline') }} -- Correct source reference
    WHERE invoicelineid IS NOT NULL -- Ensuring no nulls for the primary key
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['stg_invoicelines.invoiceline_id']) }} AS invoiceline_key, -- Surrogate key
    stg_invoicelines.*
FROM stg_invoicelines
