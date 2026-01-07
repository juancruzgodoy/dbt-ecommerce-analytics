# Ecommerce Analytics con dbt & DuckDB

Este proyecto es un Data Warehouse moderno construido localmente utilizando **dbt (data build tool)** y **DuckDB**. Transforma datos crudos de una tienda de comercio electrónico en un Modelo Dimensional (Star Schema) listo para análisis de negocio.

## Arquitectura del Proyecto

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
     
## Calidad de Datos

Se implementaron tests automáticos (`schema.yml`) para asegurar la integridad:
* **Primary Keys:** Tests de `unique` y `not_null`.
* **Foreign Keys:** Tests de `relationships` para asegurar integridad referencial entre Facts y Dimensions.

## Tecnologías

* **dbt Core:** Transformación y testing de datos.
* **DuckDB:** Base de datos analítica embebida (procesamiento local de alto rendimiento).
* **SQL:** Lenguaje de modelado.

## 📂 Estructura del Proyecto

```text
ecommerce_analytics/
├── dbt_project.yml          # Configuración principal de dbt
├── README.md                # Documentación del proyecto
├── .gitignore               # Archivos ignorados por Git
├── models/
│   ├── staging/             # Limpieza de datos crudos (1:1 con seeds)
│   │   ├── schema.yml       # Tests y documentación de staging
│   │   ├── stg_categories.sql
│   │   ├── stg_customers.sql
│   │   ├── stg_order_items.sql
│   │   ├── stg_orders.sql
│   │   └── stg_products.sql
│   ├── intermediate/        # Lógica de negocio y Joins
│   │   ├── int_order_items_products.sql
│   │   ├── int_orders_customers.sql
│   │   └── int_products_enriched.sql
│   └── marts/               # Modelos finales (Star Schema)
│       ├── schema.yml       # Tests de integridad (PKs, FKs)
│       ├── dim_customers.sql
│       ├── dim_products.sql
│       ├── fct_order_items.sql
│       └── fct_orders.sql
├── seeds/                   # Archivos CSV (Datos fuente)
│   ├── ecommerce_customers.csv
│   ├── ecommerce_orders.csv
│   ├── ecommerce_products.csv
│   └── ... (otros archivos fuente)
├── tests/                   # Tests singulares (SQL custom)
└── analysis/                # Consultas analíticas ad-hoc
```

## Cómo ejecutar el proyecto

Prerrequisitos: **Python 3.10+** y **Git** instalados.

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/TU_USUARIO/ecommerce-analytics-dbt.git](https://github.com/TU_USUARIO/ecommerce-analytics-dbt.git)
    cd ecommerce-analytics-dbt
    ```

2.  **Configurar entorno virtual:**
    ```bash
    python -m venv venv
    .\venv\Scripts\Activate  # En Windows
    # source venv/bin/activate  # En Mac/Linux
    
    pip install dbt-duckdb
    ```

3.  **Construir y Testear:**
    El comando `build` ejecuta los modelos (seeds, tables, views) y corre los tests automáticamente.
    ```bash
    dbt build
    ```

4.  **Ver Documentación y Linaje:**
    ```bash
    dbt docs generate
    dbt docs serve
    ```
