WITH 
    produtos_base AS (
        SELECT *
        FROM {{ ref('stg_erp_northwind_produtos') }} -- Fonte de dados: modelo intermediário de produtos
    )

SELECT *
FROM produtos_base