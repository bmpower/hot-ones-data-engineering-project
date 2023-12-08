with source as (

    select * from {{ source('hot_ones_raw_data', 'hot_ones_sauces') }}
    
),

sauces_cleaned as (
    
    select

        --numerics
        cast(sauce_number as smallint) as sauce_number,
        cast(season as smallint) as season,
        cast(scoville as int) as scoville,

        --strings
        trim(sauce_name) as sauce_name
        
    from source

)

select * from sauces_cleaned