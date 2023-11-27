select title

from {{ source('hot_ones_raw_data', 'hot_ones_episodes') }}

