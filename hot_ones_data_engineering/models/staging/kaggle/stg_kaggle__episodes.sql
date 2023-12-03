with source as (

    select * from {{ source('hot_ones_raw_data', 'hot_ones_episodes') }}
    
),

episodes_cleaned as (
    
    select
        --dates
        cast(original_release as date) as original_release_date,

        --numerics
        cast(season as smallint) as season,
        cast(episode_season as smallint) as episode_season,
        cast(episode_overall as smallint) as episode_overall,
        cast(guest_appearance_number as smallint) as guest_appearance_number,

        --strings
        trim(title) as episode_title,
        trim(guest) as guest,

        --booleans
        cast(finished as boolean) as finished_wings
        
    from source

)

select * from episodes_cleaned



