with
most_common_results as
(
select 
concat(`Goals Home`,'-',`Away Goals`) as final_result 
,count(concat(`Goals Home`,'-',`Away Goals`)) as number_of_games
from 
premier_league_stats pls 
group by 1
),
all_games as 
(
select 
	count(*) as total_number_of_games
from 
premier_league_stats pls 
)
select
	mcr.final_result
	,round((mcr.number_of_games/ag.total_number_of_games)*100,1) as games_percentage
from 
most_common_results mcr
join all_games ag 
order by 2 desc
