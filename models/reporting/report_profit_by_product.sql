select 
p.productid,
p.category,
p.productname,
p.subcategory,
sum(orderprofit) as profit
from {{ ref('stg_orders') }} as p
group by
p.productid,
p.category,
p.productname,
p.subcategory
