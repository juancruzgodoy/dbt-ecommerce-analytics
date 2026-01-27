WITH orders_with_customers AS (
    SELECT * FROM {{ ref('int_orders_customers') }}
),

filtered_customers AS (

    SELECT DISTINCT
        customer_id,
        first_name,
        last_name,
        email,
        phone,
        country,
        city,
        postal_code

    FROM
        orders_with_customers
)

SELECT * FROM filtered_customers