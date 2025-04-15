WITH
    fonte_categoria as (
        select *
        from {{ source('erp_northwind', 'category') }} -- Fonte de dados: tabela category do ERP Northwind
    )
    -- CTE para criar uma tabela temporária com os dados de categorias
    , renomeado as (
        SELECT
            cast(ID as int) as pk_categoria -- Identificador único da categoria (chave primária)
            , cast(CATEGORYNAME as string) as nome_categoria -- Nome da categoria
            , cast(DESCRIPTION as string) as descricao_categoria -- Descrição da categoria
        from fonte_categoria -- Dados provenientes da CTE fonte_categoria
    )

select *
from renomeado -- Seleciona todos os dados da CTE renomeado