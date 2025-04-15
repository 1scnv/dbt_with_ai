WITH 
    fonte_funcionarios AS (
        SELECT *
        FROM {{ source('erp_northwind', 'employees') }} -- Fonte de dados: tabela employees do ERP Northwind
    )
    -- CTE para criar uma tabela temporária com os dados de funcionários
    , renomeado AS (
        SELECT
            CAST(id AS INT) AS pk_funcionario -- Identificador único do funcionário (chave primária)
            , CAST(REPORTSTO as int) as fk_supervisor -- Identificador do supervisor (chave estrangeira)
            , FIRSTNAME || ' ' || LASTNAME AS nome_completo -- Concatena o primeiro e último nome para formar o nome completo
            , CAST(TITLE AS STRING) AS titulo -- Título do funcionário
            , CAST(BIRTHDATE AS DATE) AS data_nascimento -- Data de nascimento do funcionário
            , CAST(HIREDATE AS DATE) AS data_contratacao -- Data de contratação do funcionário
            , CAST(CITY AS STRING) AS cidade -- Cidade onde o funcionário reside
            , CAST(REGION AS STRING) AS regiao -- Região onde o funcionário reside
            , CAST(COUNTRY AS STRING) AS pais -- País onde o funcionário reside
            --, CAST(home_phone AS STRING) AS telefone_residencial -- Telefone residencial do funcionário (comentado)
            --, CAST(postal_code AS STRING) AS codigo_postal -- Código postal do endereço do funcionário (comentado)
            --, CAST(address AS STRING) AS endereco -- Endereço completo do funcionário (comentado)
        FROM fonte_funcionarios -- Dados provenientes da CTE fonte_funcionarios
    )

SELECT * 
FROM renomeado -- Seleciona todos os dados da CTE renomeado