WITH source AS (
    SELECT * FROM {{ ref('ecommerce_order_items') }}
),

renamed AS (
    SELECT
        order_item_id,
        order_id,
        product_id,
        CAST(quantity AS INTEGER) AS quantity,
        CAST(unit_price AS DECIMAL(10,2)) AS unit_price,
        CAST(subtotal AS DECIMAL(10,2)) AS total_amount
    FROM source
)

SELECT * FROM renamed