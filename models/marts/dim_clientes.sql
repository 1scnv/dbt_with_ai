WITH 
    clientes_base AS (
        SELECT *
        FROM {{ ref('stg_erp_northwind_clientes') }} -- Fonte de dados: tabela de clientes no modelo de staging
    )

SELECT *
FROM clientes_base