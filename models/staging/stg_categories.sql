WITH source AS (
    SELECT * FROM {{ ref('ecommerce_categories') }}
),
renamed AS (
    SELECT
        category_id,
        CAST(category_name AS STRING) AS category_name,
        CAST(description AS STRING) AS description,
        parent_category_id,
        CAST(is_active AS BOOLEAN) AS is_active,
        CAST(display_order AS INTEGER) AS display_order
    FROM source
)

SELECT * FROM renamed