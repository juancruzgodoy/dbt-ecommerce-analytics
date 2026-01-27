WITH products AS (
    SELECT * FROM {{ ref('stg_products') }}
),

categories AS (
    SELECT * FROM {{ ref('stg_categories') }}
),

enriched AS (
    SELECT

        -- Product info
        p.product_id,
        p.sku,
        p.product_name,
        p.description,
        p.price,

        -- Category info
        c.category_name

    FROM
        products AS p
    LEFT JOIN
        categories AS c
    ON
        p.category_id = c.category_id
)

SELECT * FROM enriched