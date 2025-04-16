WITH 
    produtos_base AS (
        SELECT *
        FROM {{ ref('stg_erp_northwind_produtos') }} -- Fonte de dados: tabela de produtos
    )
    , categorias_base AS (
        SELECT *
        FROM {{ ref('stg_erp_northwind_categorias') }} -- Fonte de dados: tabela de categorias
    )
    , fornecedores_base AS (
        SELECT *
        FROM {{ ref('stg_erp_fornecedores') }} -- Fonte de dados: tabela de fornecedores
    )
    , produtos_enriquecidos AS (
        SELECT
            produtos_base.pk_produto -- Identificador único do produto
            , produtos_base.nome_produto -- Nome do produto
            , produtos_base.fk_categoria -- Chave estrangeira para a categoria
            , produtos_base.fk_fornecedor -- Chave estrangeira para o fornecedor
            , produtos_base.quantidade_por_unidade -- Quantidade por unidade
            , produtos_base.preco_unitario -- Preço unitário do produto
            , produtos_base.unidades_em_estoque -- Quantidade de unidades em estoque
            , produtos_base.unidades_em_pedido -- Quantidade de unidades em pedido
            , produtos_base.nivel_de_pedido -- Nível de reordenação do produto
            , produtos_base.produto_descontinuado -- Indica se o produto está descontinuado
            , categorias_base.nome_categoria -- Nome da categoria do produto
            , fornecedores_base.nome_empresa -- Nome do fornecedor do produto
            , fornecedores_base.cidade -- Cidade do fornecedor
            , fornecedores_base.pais -- País do fornecedor
        FROM produtos_base
        LEFT JOIN categorias_base
        ON produtos_base.fk_categoria = categorias_base.pk_categoria -- Relacionamento entre produtos e categorias
        LEFT JOIN fornecedores_base
        ON produtos_base.fk_fornecedor = fornecedores_base.pk_fornecedor -- Relacionamento entre produtos e fornecedores
    )

SELECT *
FROM produtos_enriquecidos -- Seleciona todos os dados da CTE produtos_enriquecidos