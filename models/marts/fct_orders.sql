WITH orders_with_customers AS (
    SELECT * FROM {{ ref('int_orders_customers') }}
),

filtered_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount
    FROM
        orders_with_customers
)

SELECT * FROM filtered_orders