{{
    config(
        materialized='view'
    )
}}

select * from dbt_dev.dbt_sma.sachin