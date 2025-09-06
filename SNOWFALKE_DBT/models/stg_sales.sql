{{
    config(
        materialized='table'
    )
}}

select * from dbt_dev.dbt_sma.sales