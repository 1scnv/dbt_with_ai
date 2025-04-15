-- models/staging/erp_northwind/stg_erp_northwind_categorias.sql
-- Descrição:
-- Este modelo cria uma tabela temporária com os dados de categorias
-- do banco de dados Northwind. Ele seleciona todos os campos da tabela
-- de categorias e os renomeia para o padrão do dbt.
WITH
    fonte_categoria as (
        select *
        from {{ source('erp_northwind', 'category') }}
    )
    -- CTE para criar uma tabela temporária com os dados de categorias
    , renomeado as (
        SELECT
            cast(ID as int) as pk_categoria
            , cast(CATEGORYNAME as string) as nome_categoria
            , cast(DESCRIPTION as string) as descricao_categoria
        from fonte_categoria
    )

select *
from renomeado