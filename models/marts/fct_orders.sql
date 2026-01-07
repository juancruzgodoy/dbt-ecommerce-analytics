WITH fct_orders AS (
    SELECT * FROM {{ ref('int_orders_customers') }}
),
filtered_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount
    FROM
        fct_orders
)

SELECT * FROM filtered_orders