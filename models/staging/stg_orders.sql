
select 
o.orderid,
o.orderdate,
o.shipdate,
o.shipmode,
ordersellingprice-ordercostprice as orderprofit,
c.customerid,
c.customername,
c.segment,
c.country
from {{ ref('raw_orders') }} o
left join {{ ref('raw_customer') }} as c
left join {{ ref('raw_product') }} as p 