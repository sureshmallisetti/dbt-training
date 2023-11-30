select 
c.customerid,
c.segment,
c.country,
sum(orderprofit) as profit 
from {{ ref('stg_orders') }} as c 
group by 
c.customerid,
c.segment,
c.country