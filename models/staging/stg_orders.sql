WITH source AS (
    SELECT * FROM {{ ref('ecommerce_orders') }}
),

renamed AS (
    SELECT
        order_id,
        CAST(order_number AS STRING) AS order_number,
        customer_id,
        CAST(order_date AS DATE) AS order_date,
        CAST(status AS STRING) AS status,
        CAST(subtotal AS DECIMAL(10,2)) AS subtotal,
        CAST(discount_percent AS DECIMAL(10,2)) AS discount_percent,
        CAST(shipping_cost AS DECIMAL(10,2)) AS shipping_cost,
        CAST(tax_amount AS DECIMAL(10,2)) AS tax_amount,
        CAST(total_amount AS DECIMAL(10,2)) AS total_amount,
        CAST(payment_method AS STRING) AS payment_method,
        CAST(shipping_method AS STRING) AS shipping_method,
        CAST(promotion_id AS STRING) AS promotion_id,
        CAST(notes AS STRING) AS notes
    FROM source
)

SELECT * FROM renamed