WITH 
    pedidos_com_itens AS (
        SELECT *
        FROM {{ ref('int_vendas_metricas_venda') }} -- Fonte de dados: métricas de vendas intermediárias
    )

SELECT *
FROM pedidos_com_itens