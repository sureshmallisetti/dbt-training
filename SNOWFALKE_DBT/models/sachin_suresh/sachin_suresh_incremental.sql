{{
    config(
        materialized='incremental',
        unique_key=['id','region']
    )
}}

with suresh as (
    select * from {{ ref('suresh') }}
    where current_timestamp > (select coalesce(max(last_updated),'1970-01-01-110101') from {{ ref('suresh') }})
),

/*
sachin as (
    select * from {{ ref('sachin') }}
    where current_timestamp > (select coalesce(max(last_updated),'1970-01-01-110101') from {{ ref('sachin') }})
),

delta_suresh as (
select * from suresh 
union all
select * from {{ ref('suresh') }}
where (id,region) in (select id,region  from suresh)
),

delta_sachin as (
select * from sachin 
union all
select * from {{ ref('sachin') }}
where (id,region) in (select id,region  from sachin)
),

*/

final as (
    
select 
sh.id,
sh.region,
sh.product,
sh.name,
sh.last_updated,
shn.product_description 
from 
suresh sh 
left join {{ ref('sachin') }} shn 
on sh.id=shn.id and sh.region=shn.region
),

duplicate_remove as (
    select * from final qualify row_number() over(partition by id,region order by last_updated)=1
)

select * from duplicate_remove