WITH 
    funcionarios_base AS (
        SELECT *
        FROM {{ ref('stg_erp_northwind_funcionarios') }} -- Fonte de dados: modelo de staging dos funcionários
    )
    -- CTE para criar uma tabela temporária com os dados de funcionários e seus gerentes
    , funcionarios_com_gerentes AS (
        SELECT
            funcionarios.pk_funcionario
            , funcionarios.nome_completo
            , funcionarios.titulo
            , funcionarios.data_nascimento
            , funcionarios.data_contratacao
            , funcionarios.cidade
            , funcionarios.regiao
            , funcionarios.pais
            , gerentes.nome_completo as nome_gerente
        FROM funcionarios_base funcionarios
        LEFT JOIN funcionarios_base gerentes
        ON funcionarios.fk_supervisor = gerentes.pk_funcionario -- Auto relacionamento entre funcionários e seus gerentes
    )

SELECT *
FROM funcionarios_com_gerentes -- Seleciona todos os dados da CTE funcionarios_com_gerentes