with seasons_episodes_summary as (

    select * from {{ ref('int_hot_ones_seasons_episodes_summary') }}

),

sauces_summary as (

    select * from {{ ref('int_hot_ones_sauces_summary_by_season') }}

),

seasons_summary as (
    
    select

        seasons_episodes_summary.season_number,
        seasons_episodes_summary.original_release_date,
        seasons_episodes_summary.num_episodes,
        seasons_episodes_summary.num_episodes_wings_finished,
        seasons_episodes_summary.num_episodes_wings_not_finished,
        seasons_episodes_summary.finish_percent,
        sauces_summary.total_sauces,
        sauces_summary.avg_scoville,
        sauces_summary.max_scoville,
        sauces_summary.max_scoville_sauce
    
    from seasons_episodes_summary

    left join sauces_summary on seasons_episodes_summary.season_number = sauces_summary.season

)

select * from seasons_summary