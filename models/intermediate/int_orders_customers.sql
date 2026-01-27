WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

enriched AS (
    SELECT

        -- Order info
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status,
        o.total_amount,

        -- Customer info
        c.first_name,
        c.last_name,
        c.email,
        c.phone,
        c.city,
        c.country,
        c.postal_code,

        -- Clasificacion segun registro
        CASE
            WHEN o.customer_id IS NULL THEN 'Guest'
            ELSE 'Registered'
        END AS customer_type

    FROM
        orders AS o
    LEFT JOIN
        customers AS c
    ON
        o.customer_id = c.customer_id
)

SELECT * FROM enriched