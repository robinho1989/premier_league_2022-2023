with
goals_per_team as
(
select 
	`Home Team` as team
	,`Goals Home` as number_of_goals
from 
premier_league_stats pls
union all
select 
	`Away Team`  
	,`Away Goals`  
from 
premier_league_stats pls
),
lost_goals_per_team as
(
select 
	`Home Team` as team
	,`Away Goals` as lost_goals
from 
premier_league_stats pls 
union all
select
	`Away Team` 
	,`Goals Home` 
from 
premier_league_stats pls2 
),
total_scored as
(
select
	team
	,sum(number_of_goals) as total_scored_goals_per_team
from 
goals_per_team
group by 1
),
total_lost as 
(
select
	team
	,sum(lost_goals) as total_lost_goals_per_team
from 
lost_goals_per_team
group by 1
),
games_per_team as 
(
select 
	count(*)/10 as number_of_games_per_team 
from 
premier_league_stats pls 
)
select 
	ts.team
	,ts.total_scored_goals_per_team
	,tl.total_lost_goals_per_team
	,round(ts.total_scored_goals_per_team/gpt.number_of_games_per_team,1) as scorded_goals_by_matches
	,round(tl.total_lost_goals_per_team/gpt.number_of_games_per_team,1) as lost_goals_by_matches
from 
total_scored ts
join total_lost tl on ts.team = tl.team
join games_per_team gpt
order by 2 desc



