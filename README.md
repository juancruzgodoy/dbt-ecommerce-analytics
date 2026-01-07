# 🛒 Ecommerce Analytics con dbt & DuckDB

Este proyecto es un Data Warehouse moderno construido localmente utilizando **dbt (data build tool)** y **DuckDB**. Transforma datos crudos de una tienda de comercio electrónico en un Modelo Dimensional (Star Schema) listo para análisis de negocio.

## 🏗️ Arquitectura del Proyecto

El proyecto sigue la estructura de capas estándar de Analytics Engineering:

1.  **Staging (`models/staging`):**
    * Limpieza básica de datos crudos (casting de tipos, renombrado de columnas).
    * Materialización: Vistas.
    * Fuentes: Orders, Customers, Products, Order Items, Categories.

2.  **Intermediate (`models/intermediate`):**
    * Lógica de negocio y cruces complejos (Joins).
    * Enriquecimiento de órdenes con datos de clientes.
    * Cálculo de métricas a nivel de ítem (ganancia, subtotales).

3.  **Marts (`models/marts`):**
    * Tablas finales para consumo de BI (PowerBI, Tableau, Metabase).
    * **Esquema de Estrella:**
        * `fct_orders`: Tabla de hechos de cabecera de pedidos.
        * `fct_order_items`: Tabla de hechos detallada con métricas de producto.
        * `dim_customers`: Dimensión de clientes.
        * `dim_products`: Dimensión de productos y categorías.

## ⚙️ Tecnologías

* **dbt Core:** Transformación y testing de datos.
* **DuckDB:** Base de datos analítica embebida (procesamiento local de alto rendimiento).
* **SQL:** Lenguaje de modelado.

## 🚀 Cómo ejecutar el proyecto

Prerrequisitos: Python 3.x instalado.

1.  **Configurar entorno:**
    ```bash
    python -m venv venv
    .\venv\Scripts\Activate
    pip install dbt-duckdb
    ```

2.  **Construir y Testear:**
    El comando `build` ejecuta los modelos (seeds, tables, views) y corre los tests automáticamente.
    ```bash
    dbt build
    ```

3.  **Ver Documentación y Linaje:**
    ```bash
    dbt docs generate
    dbt docs serve
    ```

## 🧪 Calidad de Datos

Se implementaron tests automáticos (`schema.yml`) para asegurar la integridad:
* **Primary Keys:** Tests de `unique` y `not_null`.
* **Foreign Keys:** Tests de `relationships` para asegurar integridad referencial entre Facts y Dimensions.

---
