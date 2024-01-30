with sauces as (

    select * from {{ ref('stg_kaggle__hot_ones_sauces') }}

),

sauce_count_by_season as (

    select
        season,
        cast(count(distinct sauce_name) as smallint) as total_sauces

    from sauces

    group by season
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

    ),

sauces_summary_by_season as (
    
    select
    sauce_count_by_season.season,
    sauce_count_by_season.total_sauces,
    avg_scoville_by_season.avg_scoville,
    max_scoville_by_season.max_scoville,
    max_scoville_by_season.max_scoville_sauce

    from sauce_count_by_season

    left join avg_scoville_by_season on sauce_count_by_season.season = avg_scoville_by_season.season
    left join max_scoville_by_season on sauce_count_by_season.season = max_scoville_by_season.season

)

select * from sauces_summary_by_season
