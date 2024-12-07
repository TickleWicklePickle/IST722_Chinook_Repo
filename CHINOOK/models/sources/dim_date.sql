SELECT *
FROM {{ source('raw', 'datedimension') }}
