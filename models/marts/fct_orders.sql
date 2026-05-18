with orders as (
    select * from {{ ref('stg_orders') }}
)

select
    order_id,
    customer_id,
    store_id,
    ordered_at as order_date,
    order_subtotal,
    order_tax_paid,
    order_total
from orders