WITH 
    transportadoras_raw AS (
        SELECT *
        FROM {{ source('erp_northwind', 'shippers') }} -- Fonte de dados bruta: tabela de transportadoras do ERP Northwind
    )
    , renomeado as (
        select 
            cast(ID as int) as pk_transportadora
            , cast(COMPANYNAME as varchar) as nm_transportadora
        FROM transportadoras_raw
    )

SELECT *
FROM renomeado