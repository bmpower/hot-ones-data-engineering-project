with guests_appearances as (

    select * from {{ ref('int_hot_ones_episodes_guest_appearance_count') }}

),

episodes_wings_finished as (

    select * from {{ ref('int_hot_ones_episodes_wings_finished') }}

),

episodes_wings_not_finished as (

    select * from {{ ref('int_hot_ones_episodes_wings_not_finished') }}

),

guests_wings_finished as (

    select
        guest,
        cast(count(*) as smallint) as episodes_wings_finished
    
    from episodes_wings_finished
    
    group by guest

),

guests_wings_not_finished as (

    select
        guest,
        cast(count(*) as smallint) as episodes_wings_not_finished
    
    from episodes_wings_not_finished

    group by guest

),

guests_summary as (

    select
        guests_appearances.guest,
        guests_appearances.total_appearances,
        coalesce(guests_wings_finished.episodes_wings_finished, 0) as appearances_wings_finished,
        coalesce(guests_wings_not_finished.episodes_wings_not_finished, 0) as appearances_wings_not_finished,
        -- calculate finish percent
        cast (
                -- episodes where wings finished (0 if guest didn't finish) /
                coalesce(guests_wings_finished.episodes_wings_finished, 0.0) / 
                -- episodes where wings finished (0 if guest had no wings finished) + episodes where wings not finished (0 if guest finished)
                (coalesce(guests_wings_finished.episodes_wings_finished, 0.0) + coalesce(guests_wings_not_finished.episodes_wings_not_finished, 0.0))
            as decimal (2, 1)
            ) as finish_percent
        
        from guests_appearances

        left join guests_wings_finished on guests_appearances.guest = guests_wings_finished.guest
        left join guests_wings_not_finished on guests_appearances.guest = guests_wings_not_finished.guest

)

select * from guests_summary