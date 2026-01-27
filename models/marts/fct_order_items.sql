WITH order_items_with_products AS (
    SELECT * FROM {{ ref('int_order_items_products') }}
),

filtered_order_items AS (

    SELECT
        order_id,
        order_item_id,
        product_id,
        product_name,
        category_name,
        quantity,
        total_amount,
        total_profit
    FROM
        order_items_with_products
)

SELECT * FROM filtered_order_items