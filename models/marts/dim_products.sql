WITH dim_products AS (
    SELECT * FROM {{ ref('int_products_enriched') }}
),

filtered_products AS (
    SELECT
        product_id,
        sku,
        product_name,
        description,
        price,
        category_name,

    FROM
        dim_products
)

SELECT * FROM filtered_products