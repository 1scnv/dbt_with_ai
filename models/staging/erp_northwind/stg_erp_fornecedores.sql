WITH 
    fonte_fornecedores AS (
        SELECT *
        FROM {{ source('erp_northwind', 'suppliers') }} -- Fonte de dados: tabela suppliers do ERP Northwind
    )
    -- CTE para criar uma tabela temporária com os dados de fornecedores
    , renomeado AS (
        SELECT
            CAST(id AS INT) AS pk_fornecedor -- Identificador único do fornecedor (chave primária)
            , CAST(companyname AS STRING) AS nome_empresa -- Nome da empresa fornecedora
            , CAST(city AS STRING) AS cidade -- Cidade onde o fornecedor está localizado
            , CAST(country AS STRING) AS pais -- País onde o fornecedor está localizado
        FROM fonte_fornecedores -- Dados provenientes da CTE fonte_fornecedores
    )

SELECT * 
FROM renomeado -- Seleciona todos os dados da CTE renomeado