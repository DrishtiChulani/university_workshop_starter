with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

customer_orders as (
    select
        customer_id,
        min(ordered_at) as first_order_date,
        max(ordered_at) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(order_total) as lifetime_value
    from orders
    group by 1
)

select
    c.customer_id,
    c.customer_name,
    co.first_order_date,
    co.most_recent_order_date,
    co.number_of_orders,
    co.lifetime_value,
    -- Simple operational business rule logic for presentation
    case 
        when co.number_of_orders > 1 then 'returning'
        else 'new'
    end as customer_type
from customers c
left join customer_orders co on c.customer_id = co.customer_id