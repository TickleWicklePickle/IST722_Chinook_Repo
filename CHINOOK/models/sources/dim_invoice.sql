WITH source_data AS (
    SELECT
        customerid AS customer_id, -- Customer making the purchase
        invoiceid AS invoice_id, -- The purchase identifier
        invoicedate AS invoice_date, -- Date of purchase
        billingaddress AS billing_address, -- Customer's address
        billingcity AS billing_city, -- Customer's city
        billingstate AS billing_state, -- Customer's state
        billingcountry AS billing_country, -- Customer's country
        billingpostalcode AS billing_postal_code, -- Customer's postal code
        total AS total_amount -- Total $ amount of the purchase
    FROM {{ source('chinook', 'invoice') }}
)

SELECT *
FROM source_data

