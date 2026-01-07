WITH fct_order_items AS (
    SELECT * FROM {{ ref('int_order_items_products') }}
),

filtered_order_items AS (
    SELECT
        order_id,
        product_id,
        product_name,
        category_name,
        quantity,
        total_amount,
        total_profit
    FROM
        fct_order_items
)

SELECT * FROM filtered_order_items