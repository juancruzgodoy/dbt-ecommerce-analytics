# Ecommerce Analytics con dbt & DuckDB

Este proyecto es un Data Warehouse moderno construido localmente utilizando **dbt (data build tool)** y **DuckDB**. Transforma datos crudos de una tienda de comercio electrónico en un Modelo Dimensional (Star Schema) listo para análisis de negocio.

## Arquitectura del Proyecto

El proyecto sigue la estructura de capas estándar de Analytics Engineering:

1.  **Staging (`models/staging`):**
    * Limpieza básica de datos crudos (casting de tipos).
    * **Estandarización:** Traducción de estados de órdenes de Español a Inglés (ej: `pendiente` -> `pending`).
    * Materialización: Vistas.

2.  **Intermediate (`models/intermediate`):**
    * Lógica de negocio y cruces complejos (Joins).
    * Enriquecimiento de órdenes con datos de clientes.
    * Cálculo de métricas a nivel de ítem (ganancia, subtotales).

3.  **Marts (`models/marts`):**
    * Tablas finales para consumo de BI.
    * **Lógica de Calidad:** Deduplicación de clientes para asegurar granularidad única.
    * **Esquema de Estrella:**
        * `fct_orders`: Tabla de hechos de cabecera de pedidos.
        * `fct_order_items`: Tabla de hechos detallada con métricas de producto.
        * `dim_customers`: Dimensión de clientes única.
        * `dim_products`: Dimensión de productos y categorías.

## Calidad de Datos

Se implementaron múltiples niveles de testing (`dbt build` passing: 63 tests):
* **Schema Tests:** `unique`, `not_null` y `accepted_values` (para estados de órdenes).
* **Integridad Referencial:** Tests de `relationships` entre todas las tablas del modelo estrella.
* **Tests Singulares:** Validación de lógica de negocio (ej: `assert_total_amount_is_positive.sql`).

## Estructura del Proyecto

```text
ecommerce_analytics/
├── dbt_project.yml          # Configuración principal
├── README.md                # Documentación
├── models/
│   ├── staging/             # Limpieza y Estandarización
│   │   ├── schema.yml
│   │   ├── stg_orders.sql   # Incluye traducción de estados
│   │   └── ...
│   ├── intermediate/        # Joins y Enriquecimiento
│   │   ├── schema.yml
│   │   ├── int_orders_customers.sql
│   │   └── ...
│   └── marts/               # Modelos Finales
│       ├── schema.yml       # Tests PK/FK exhaustivos
│       ├── dim_customers.sql # Incluye deduplicación
│       ├── fct_order_items.sql
│       └── ...
├── macros/
│   └── calculate_margin.sql # Lógica reutilizable (Jinja)
├── tests/
│   └── assert_total_amount_is_positive.sql # Test de calidad de negocio
└── seeds/                   # Archivos CSV (Datos fuente)
```

## Cómo ejecutar el proyecto

Prerrequisitos: **Python 3.10+** y **Git** instalados.

1.  **Clonar el repositorio:**
    ```bash
    git clone https://github.com/juancruzgodoy/dbt-ecommerce-analytics
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

## Notas de Arquitectura (Deuda Técnica)

**Uso de Seeds vs. Sources:**
Para facilitar la ejecución local y la portabilidad de este demo, se utilizan **dbt seeds** para cargar los datos crudos (archivos CSV).
En un entorno de producción real, estos modelos de staging se refactorizarían para leer desde fuentes definidas en un archivo `_sources.yml` utilizando la función `{{ source() }}`, permitiendo:
* Controles de frescura de datos (`freshness checks`).
* Carga incremental de tablas masivas.
* Separación entre la ingesta (EL) y la transformación (T).

* **Snapshots (Historial de Cambios):**
  Actualmente no se aplica la estrategia de *Slowly Changing Dimensions (Tipo 2)* porque el origen de datos son archivos estáticos (Seeds). En un entorno productivo, se utilizarían dbt snapshots para rastrear cambios históricos en dimensiones como `precios` o `direcciones` de clientes.

