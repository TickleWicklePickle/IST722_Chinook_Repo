WITH source_data AS (
    SELECT
        customerid AS customer_id, -- Primary key of the source systems (business key)
        firstname AS first_name, -- Customer's first name
        lastname AS last_name, -- Customer's last name
        company AS company_name, -- Customer's company
        address AS address, -- Customer's address
        city AS city, -- Customer's city
        state AS state, -- Customer's state
        country AS country, -- Customer's country
        postalcode AS postal_code, -- Customer's postal code
        phone AS phone_number, -- Customer's phone
        fax AS fax_number, -- Customer's fax
        email AS email_address, -- Customer's email
        supportrepid AS support_rep_id -- Employee who helped with the purchase
    FROM {{ source('chinook', 'customer') }} -- Correct source reference
    WHERE customerid IS NOT NULL  -- Ensuring no nulls for the primary key
)

SELECT *
FROM source_data
