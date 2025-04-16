WITH
    fonte_orders as (
        select *
        from {{ source('erp_northwind', 'orders') }} -- Fonte de dados: tabela orders do ERP Northwind
    )
    -- CTE para criar uma tabela temporária com os dados de pedidos
    , renomeado as (
        SELECT
            cast(ID as int) as pk_pedido -- Identificador único do pedido (chave primária)
            , cast(CustomerID as string) as fk_cliente -- Chave estrangeira para a tabela de clientes
            , cast(SHIPVIA as int) as fk_transportadora -- Chave estrangeira para a tabela de transportadoras
            , cast(EmployeeID as int) as fk_funcionario -- Chave estrangeira para a tabela de funcionários
            , cast(ID as int) as numero_pedido -- Número do pedido
            , cast(OrderDate as date) as data_pedido -- Data em que o pedido foi realizado
            , cast(RequiredDate as date) as data_requerida -- Data requerida para entrega do pedido
            , cast(ShippedDate as date) as data_envio -- Data em que o pedido foi enviado
            , cast(FREIGHT as numeric) as frete -- Valor do frete do pedido
            , cast(SHIPNAME as string) as nome_envio -- Nome do destinatário do envio
            , cast(SHIPADDRESS as string) as endereco_envio -- Endereço de envio do pedido
            , cast(SHIPCITY as string) as cidade_envio -- Cidade de envio do pedido
            , cast(SHIPREGION as string) as regiao_envio -- Região de envio do pedido
            , cast(SHIPPOSTALCODE as string) as cep_envio -- Código postal do endereço de envio
            , cast(SHIPCOUNTRY as string) as pais_envio -- País de envio do pedido
        from fonte_orders -- Dados provenientes da CTE fonte_orders
    )

select * 
from renomeado -- Seleciona todos os dados da CTE renomeado