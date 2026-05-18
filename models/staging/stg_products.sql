with source as (

    select * from {{ source('jaffle-shop-dc', 'raw_products') }}

),

renamed as (

    select
        sku as product_sku,
        name as product_name,
        type as product_type,
        description as product_description,

        -- Macro conversion to dollars
        {{ cents_to_dollars('price') }} as product_price

    from source

)

select * from renamed