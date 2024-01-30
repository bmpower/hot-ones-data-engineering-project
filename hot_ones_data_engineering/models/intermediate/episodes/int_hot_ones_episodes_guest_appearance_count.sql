with episodes as (

    select * from {{ ref('stg_kaggle__hot_ones_episodes') }}

),

guest_appearance as (

    select
        guest,
        cast(count(*) as smallint) as total_appearances

    from episodes

    group by 
        guest

)

select * from guest_appearance