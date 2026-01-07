WITH source AS (
    SELECT * FROM {{ ref('ecommerce_products') }}
),

renamed AS (
    SELECT
        product_id,
        CAST(sku AS STRING) AS sku,
        CAST(product_name AS STRING) AS product_name,
        CAST(description AS STRING) AS description,
        category_id,
        brand_id,
        supplier_id,
        CAST(price AS DECIMAL(10,2)) AS price,
        CAST(cost AS DECIMAL(10,2)) AS cost,
        CAST(weight_kg AS DECIMAL(10,2)) AS weight_kg,
        CAST(is_active AS BOOLEAN) AS is_active,
        CAST(created_at AS DATE) AS created_at,
        CAST(updated_at AS DATE) AS updated_at
    FROM source
)

SELECT * FROM renamed