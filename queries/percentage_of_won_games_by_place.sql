with
home_wins as
(
select 
	count(`Home Team`) as number_of_won_home_games
from 
premier_league_stats pls 
where pls.`Goals Home` > pls.`Away Goals`  
),
away_wins as 
(
select 
	count(`Away Team`) as number_of_won_away_games
from 
premier_league_stats pls 
where pls.`Away Goals` > pls.`Goals Home` 
),
draws as 
(
select 
	count(*) as number_of_draws
from 
premier_league_stats pls
where `Away Goals` = `Goals Home` 
),
all_games as 
(
select 
	count(*) as total_games
from 
premier_league_stats pls
)
select
	round((hm.number_of_won_home_games/ag.total_games)*100,0) as percentage_of_home_wins
	,round((aw.number_of_won_away_games/ag.total_games)*100,0) as percentage_of_away_wins
	,round((d.number_of_draws/ag.total_games)*100,0) as percentage_of_draws
from 
home_wins hm
join all_games ag
join away_wins aw
join draws d



