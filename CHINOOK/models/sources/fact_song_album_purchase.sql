WITH source_data AS (
    SELECT
        invoice.total AS total_order_amount, -- Sum of unit price * quantity per purchase
        invoiceline.quantity AS quantityoforder, -- Number of tracks purchased
        invoice.invoicedate AS purchase_date, -- Date of purchase, derived from dim_date
        invoice.invoiceid AS invoice_id, -- Source key used for drill-through
        track.albumid AS album_id, -- Dimension FK for dim_track
        invoice.customerid AS customer_id -- Dimension FK for dim_customer
    FROM {{ source('chinook', 'invoice') }} AS invoice
    JOIN {{ source('chinook', 'invoiceline') }} AS invoiceline
      ON invoice.invoiceid = invoiceline.invoiceid
    JOIN {{ source('chinook', 'track') }} AS track
      ON invoiceline.trackid = track.trackid
    WHERE invoice.total IS NOT NULL
      AND invoiceline.quantity IS NOT NULL
      AND invoice.invoicedate IS NOT NULL
)

SELECT *
FROM source_data