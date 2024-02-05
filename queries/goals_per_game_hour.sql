with
goals_per_hour as
(
select 
	clock 
	,`Goals Home` as goals
from 
premier_league_stats pls
union all
select
clock 
,`Away Goals` 
from
premier_league_stats pls2 
),
goals_amount_per_hour as
(
select
	clock
	,sum(goals) as goals_amount
from 
goals_per_hour
group by 1
),
all_goals as 
(
select 
	sum(goals) as total_goals
from 
goals_per_hour
),
games_by_hour as
(
select 
	clock 
	,count(clock) as number_of_games
from 
premier_league_stats pls 
group by 1
),
total_number_of_games as 
(
select 
	count(*) as all_games
from 
premier_league_stats pls
)
select
	gaph.clock
	,round((gbh.number_of_games/tng.all_games)*100,1) as games_percentage
	,round((gaph.goals_amount/ag.total_goals)*100,1) as goals_amount_percentage
from 
goals_amount_per_hour gaph
join all_goals ag
join total_number_of_games tng
join games_by_hour gbh on gbh.clock = gaph.clock


/*
policzyć korelację w posiadaniu piłki a liczbą strzelonych goli
*/