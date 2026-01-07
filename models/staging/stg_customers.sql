WITH source AS (
    SELECT * FROM {{ ref('ecommerce_customers') }}
),

renamed AS (
    SELECT
        customer_id,
        CAST(first_name AS STRING) AS first_name,
        CAST(last_name AS STRING) AS last_name,
        CAST(email AS STRING) AS email,
        CAST(phone AS STRING) AS phone,
        CAST(birth_date AS DATE) AS birth_date,
        CAST(city AS STRING) AS city,
        CAST(country AS STRING) AS country,
        CAST(postal_code AS STRING) AS postal_code,
        CAST(segment AS STRING) AS segment,
        CAST(registration_date AS DATE) AS registration_date,
        CAST(last_login AS DATE) AS last_login,
        CAST(is_verified AS BOOLEAN) AS is_verified,
        CAST(accepts_marketing AS BOOLEAN) AS accepts_marketing
    FROM source
)

SELECT * FROM renamed