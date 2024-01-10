with seasons as (

    select * from {{ ref('stg_kaggle__hot_ones_seasons') }}

),

episodes as (

    select * from {{ ref('stg_kaggle__hot_ones_episodes') }}

),

episodes_wings_finished as (

    select * from {{ ref('int_hot_ones_episodes_wings_finished') }}

),

episodes_wings_not_finished as (

    select * from {{ ref('int_hot_ones_episodes_wings_not_finished') }}

),

total_episodes_in_season as (

    select
        season,
        cast(count(*) as smallint) as num_episodes

    from episodes

    group by season

),

num_episodes_wings_finished_in_season as (

    select
        season,
        cast(count(*) as smallint) as num_episodes_wings_finished
    
    from episodes_wings_finished

    group by season

),

num_episodes_wings_not_finished_in_season as (

    select
        season,
        cast(count(*) as smallint) as num_episodes_wings_not_finished
    
    from episodes_wings_not_finished

    group by season

)

select 
    seasons.season_number,
    seasons.original_release_date,
    total_episodes_in_season.num_episodes,
    -- return 0 (instead of null) if there are no episodes in the season with wings finished, or no episodes in the season with no wings finished
    coalesce(num_episodes_wings_finished_in_season.num_episodes_wings_finished, 0) as num_episodes_wings_finished,
    coalesce(num_episodes_wings_not_finished_in_season.num_episodes_wings_not_finished, 0) as num_episodes_wings_not_finished
    
from seasons

left join total_episodes_in_season on seasons.season_number = total_episodes_in_season.season
left join num_episodes_wings_finished_in_season on seasons.season_number = num_episodes_wings_finished_in_season.season
left join num_episodes_wings_not_finished_in_season on seasons.season_number = num_episodes_wings_not_finished_in_season.season