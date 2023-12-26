with sauces as (

    select * from {{ ref('stg_kaggle__hot_ones_sauces') }}

),

avg_scoville_by_season as (

    select 
        season,
        cast(round(avg(scoville), 0) as int) as avg_scoville
    
    from sauces

    group by season

),

max_scoville_by_season as (

    select
        season,
        scoville as max_scoville,
        sauce_name as max_scoville_sauce
    
    from sauces as s

    where s.scoville = (

        select
            max(scoville) as max_scoville_season
        
        from sauces as ss where s.season = ss.season

        )

    ) 

select
    avg_scoville_by_season.season,
    avg_scoville_by_season.avg_scoville,
    max_scoville_by_season.max_scoville,
    max_scoville_by_season.max_scoville_sauce

from avg_scoville_by_season

left join max_scoville_by_season on avg_scoville_by_season.season = max_scoville_by_season.season
