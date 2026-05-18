with source as (

    select * from {{ source('jaffle-shop-dc', 'raw_orders') }}

),

renamed as (

    select
        id as order_id,
        customer as customer_id,
        ordered_at,
        store_id as store_id,
        -- Macro conversions to dollars
        {{ cents_to_dollars('subtotal') }} as order_subtotal,
        {{ cents_to_dollars('tax_paid') }} as order_tax_paid,
        {{ cents_to_dollars('order_total') }} as order_total
        
    from source

)
select * from renamed
