with source as (

    select * from {{ source('jaffle-shop-dc', 'raw_items') }}

),

renamed as (

    select
        id as item_id,
        order_id as order_id,
        sku as item_sku

    from source

)

select * from renamed