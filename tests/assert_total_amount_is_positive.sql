-- Si esta consulta devuelve filas, el test falla.
-- Buscamos órdenes con montos negativos (que no deberían existir).

SELECT
    order_id,
    total_amount
FROM {{ ref('fct_orders') }}
WHERE total_amount < 0