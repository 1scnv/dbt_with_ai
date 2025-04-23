WITH 
    fonte_ordem_itens AS (
        SELECT *
        FROM {{ source('erp_northwind', 'order_details') }} -- Fonte de dados: tabela order_details do ERP Northwind
    )
    -- CTE para criar uma tabela temporária com os dados de itens de ordem
    ,   renomeado as (
        select
            orderid::varchar || '-' || productid::varchar as pk_pedido_item -- Chave primária composta de pedido e produto
            , cast(orderid as int) as fk_pedido -- Chave estrangeira para a tabela de pedidos
            , cast(productid as int) as fk_produto -- Chave estrangeira para a tabela de produtos
            , cast(discount as numeric(18,2)) as desconto_perc -- Percentual de desconto aplicado
            , cast(unitprice as numeric(18,2)) as preco_da_unidade -- Preço unitário do produto
            , cast(quantity as int) as quantidade -- Quantidade de produtos no pedido
        FROM fonte_ordem_itens -- Dados provenientes da CTE fonte_ordem_itens
    )

SELECT * 
FROM renomeado -- Seleciona todos os dados da CTE renomeado