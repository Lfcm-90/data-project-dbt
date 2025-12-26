with mock_source_data as (
    select 
        1 as id,
        '2024-01-01 10:00:00'::timestamp as scheduled_time,
        'Meeting with team' as description,
        'pending' as status
    union all
    select 
        2 as id,
        '2024-01-02 14:30:00'::timestamp as scheduled_time,
        'Client presentation' as description,
        'completed' as status
    union all
    select 
        3 as id,
        '2024-01-03 09:00:00'::timestamp as scheduled_time,
        'Project kickoff' as description,
        'canceled' as status
)
select *
from mock_source_data