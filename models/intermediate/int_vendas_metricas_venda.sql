WITH 
    orders as (
        SELECT *
        FROM {{ ref('stg_erp_northwind_orders') }} -- Fonte de dados: tabela de pedidos
    )

    , ordem_itens AS (
        SELECT *
        FROM {{ ref('stg_erp_northwind_ordem_itens') }} -- Fonte de dados: tabela de itens do pedido
    )

    -- CTE para realizar a junção das tabelas orders e ordem_itens
    , pedidos_com_itens AS (
        SELECT 
            orders.pk_pedido -- Chave primária da tabela orders
            , orders.data_pedido -- Data do pedido
            , orders.frete -- Valor do frete do pedido
            , ordem_itens.fk_produto -- Chave estrangeira que referencia o produto
            , ordem_itens.quantidade -- Quantidade de itens no pedido
            , ordem_itens.preco_da_unidade -- Preço unitário do item
            , ordem_itens.desconto_perc -- Percentual de desconto aplicado ao item
        FROM orders  -- Fonte de dados: tabela de pedidos
        INNER JOIN ordem_itens-- Fonte de dados: tabela de itens do pedido
        ON orders.pk_pedido = ordem_itens.fk_pedido -- Condição de junção entre pedidos e itens
    )

    -- CTE para calcular métricas de vendas
    , metricas_venda AS (
        SELECT 
            pk_pedido -- Chave primária do pedido
            , data_pedido -- Data do pedido
            , fk_produto -- Chave estrangeira que referencia o produto
            , quantidade -- Quantidade de itens no pedido
            , preco_da_unidade -- Preço unitário do item
            , desconto_perc -- Percentual de desconto aplicado ao item
            , frete / COUNT(DISTINCT fk_produto) OVER (PARTITION BY pk_pedido) AS frete_rateado -- Frete rateado por produto no pedido
            , quantidade * preco_da_unidade AS total_bruto -- Cálculo do total bruto (quantidade * preço unitário)
            , quantidade * preco_da_unidade * (1 - desconto_perc) AS total_liquido -- Cálculo do total líquido considerando o desconto
            , CASE 
                WHEN desconto_perc > 0 THEN 'true' -- Verifica se houve desconto
                ELSE 'false' -- Caso contrário, indica que não houve desconto
            END AS teve_desconto -- Coluna indicando se o item teve desconto
        FROM pedidos_com_itens -- Base de dados com pedidos e itens
    )

-- Seleciona todas as colunas da CTE metricas_venda
SELECT *
FROM metricas_venda -- Seleciona todos os dados da CTE metricas_venda