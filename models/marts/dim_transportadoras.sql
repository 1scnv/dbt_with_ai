with
    fonte_transportadoras as (
        select *
        from {{ ref('stg_erp_northwind_transportadoras') }}
    )

select *
from fonte_transportadoras