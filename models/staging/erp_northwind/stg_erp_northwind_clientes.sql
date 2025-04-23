WITH 
    clientes_raw AS (
        SELECT *
        FROM {{ source('erp_northwind', 'customers') }} -- Fonte de dados bruta: tabela de clientes do ERP Northwind
    )

    , renomeado as(
        SELECT 
            cast(ID as varchar) as pk_cliente
            , cast(COMPANYNAME as varchar) as nm_empresa_cliente
            , cast(CITY as varchar) as cidade_cliente
            , cast(REGION as varchar) as regiao_cliente
            , cast(COUNTRY as varchar) as pais_cliente
        FROM clientes_raw
    )

SELECT *
FROM renomeado