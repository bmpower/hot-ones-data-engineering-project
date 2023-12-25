with sauces as (

    select * from {{ ref('stg_kaggle__sauces') }}

),

avg_and_max_scoville_by_season as (

    select 
        season,
        cast(round(avg(scoville), 0) as int) as avg_scoville,
        max(scoville) as max_scoville
    
    from sauces

    group by season

)

select * from avg_and_max_scoville_by_season