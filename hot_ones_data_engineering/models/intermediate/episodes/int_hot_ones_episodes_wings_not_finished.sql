with episodes as (

    select * from {{ ref('stg_kaggle__hot_ones_episodes') }}

),

wings_not_finished as (

    select
        season,
        episode_title,
        guest,
        guest_appearance_number

    from episodes

    where finished_wings = false

)

select * from wings_not_finished