WITH 
    funcionarios_base AS (
        SELECT *
        FROM {{ ref('int_vendas_self_join_funcionarios') }} -- Fonte de dados: modelo intermediário de funcionários
    )

SELECT *
FROM funcionarios_base