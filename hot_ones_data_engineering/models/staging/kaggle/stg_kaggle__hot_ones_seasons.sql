with source as (

    select * from {{ source('hot_ones_raw_data', 'hot_ones_seasons') }}
    
),

seasons_cleaned as (
    
    select
        --dates
        cast(original_release as date) as original_release_date,
        case
            when last_release = 'NA' then null
            else cast(last_release as date) 
            end as last_release_date,

        --numerics
        cast(season as smallint) as season_number,
        case
            when episodes = 'NA' then null
            else cast(episodes as smallint)
            end as num_episodes,

        --strings
        case
            when note = 'NA' then null
            else trim(note) 
            end as special_note
        
    from source

)

select * from seasons_cleaned