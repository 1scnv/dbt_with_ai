WITH 
    fonte_produtos AS (
        SELECT *
        FROM {{ source('erp_northwind', 'products') }} -- Fonte de dados: tabela products do ERP Northwind
    )
    -- CTE para criar uma tabela temporária com os dados de produtos
    , renomeado AS (
        SELECT
            CAST(ID AS INT) AS pk_produto -- Identificador único do produto (chave primária)
            , CAST(productname AS STRING) AS nome_produto -- Nome do produto
            , CAST(categoryid AS INT) AS fk_categoria -- Identificador da categoria (chave estrangeira)
            , CAST(SUPPLIERID AS INT) AS fk_fornecedor -- Identificador do fornecedor (chave estrangeira)
            , CAST(quantityperunit AS STRING) AS quantidade_por_unidade -- Quantidade por unidade (texto)
            , CAST(unitprice AS FLOAT) AS preco_unitario -- Preço unitário do produto
            , CAST(UNITSINSTOCK AS INT) AS unidades_em_estoque -- Quantidade de unidades em estoque
            , CAST(UNITSONORDER AS INT) AS unidades_em_pedido -- Quantidade de unidades em pedido
            , CAST(REORDERLEVEL AS INT) AS nivel_de_pedido -- Nível de reordenação do produto
            , discontinued AS produto_descontinuado -- Indica se o produto está descontinuado (booleano)
        FROM fonte_produtos -- Dados provenientes da CTE fonte_produtos
    )

SELECT * 
FROM renomeado -- Seleciona todos os dados da CTE renomeado