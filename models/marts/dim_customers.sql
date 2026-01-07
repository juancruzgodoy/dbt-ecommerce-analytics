WITH int_orders_customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

filtrered_customers AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        email,
        phone,
        city,
        postal_code,
    FROM
        int_orders_customers
)

SELECT * FROM filtrered_customers