with episodes as (

    select * from {{ ref('stg_kaggle__hot_ones_episodes') }}

),

wings_finished as (

    select
        season,
        episode_title,
        guest,
        guest_appearance_number

    from episodes

    where finished_wings = true

)

select * from wings_finished