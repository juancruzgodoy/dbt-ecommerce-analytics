WITH order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),
products AS (
    SELECT * FROM {{ ref('stg_products') }}
),
categories AS (
    SELECT * FROM {{ ref('stg_categories') }}
),
riched AS (
    SELECT

        -- Order Item info
        oi.order_id,
        oi.quantity,
        oi.unit_price,

        -- Product info
        p.product_id,
        p.product_name,
        p.price AS product_price,

        -- Category info
        c.category_name,

        -- Calculated fields
        quantity * oi.unit_price AS total_amount,
        (unit_price - p.cost) * oi.quantity AS total_profit

    FROM
        order_items AS oi
    LEFT JOIN
        products AS p
    ON
        oi.product_id = p.product_id
    LEFT JOIN
        categories AS c
    ON
        p.category_id = c.category_id
)

SELECT * FROM riched