{{ config(
    materialized='table'  
) }}

WITH stg_invoices AS (
    SELECT
        invoiceid AS invoice_id,            -- Primary key of the source system (business key)
        customerid AS customer_id,          -- Reference to the customer associated with the invoice
        REPLACE(TO_DATE(invoicedate)::varchar,'-','')::int  as invoice_date_key, --date key
        to_date(invoicedate) AS invoice_date,        -- Date of the invoice
        billingaddress AS billing_address,  -- Billing address
        billingcity AS billing_city,        -- Billing city
        billingstate AS billing_state,      -- Billing state
        billingcountry AS billing_country,  -- Billing country
        billingpostalcode AS billing_postal_code, -- Billing postal code
        total AS invoice_total              -- Total amount of the invoice
    FROM {{ source('chinook', 'invoice') }} -- Correct source reference
    WHERE invoiceid IS NOT NULL             -- Ensuring no nulls for the primary key
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['stg_invoices.invoice_id']) }} AS invoice_key, -- Surrogate key for the invoice
    stg_invoices.*
FROM stg_invoices