with games as
(
select 
	`Home Team` 
	,`Away Team` 
	,`Goals Home` 
	,`Away Goals` 
	,case 
		when `Goals Home` > `Away Goals` then `Home Team` 
		when `Goals Home` < `Away Goals` then `Away Team` 
		end as winner
	,case 
		when `Goals Home` > `Away Goals` then `Away Team` 
		when `Goals Home` < `Away Goals` then `Home Team` 
		end as loosers
from 
premier_league_stats pls
),
won_games_by_team as
(
select
	winner
	,count(winner) as number_of_won_games
from 
games
where winner is not null
group by 1
),
lost_games_by_team as 
(
select
	loosers
	,count(loosers) as number_of_lost_games
from 
games
where loosers is not null
group by 1
),
draw_game_by_team_home as 
(
select 
	`Home Team` as team
	,count(`Home Team`) as home_draws 
from 
premier_league_stats pls 
where `Goals Home` = `Away Goals`
group by 1
),
draw_game_by_team_away as 
(
select 
	`Away Team` as team
	,count(`Away Team`) as away_draws 
from 
premier_league_stats pls 
where `Goals Home` = `Away Goals`
group by 1
),
draw_games_by_team as 
(
select 
	dgh.team as team
	,dgh.home_draws + dga.away_draws as draw_games
from 
draw_game_by_team_home dgh
join draw_game_by_team_away dga on dgh.team = dga.team
)
select 
	winner as team
	,wg.number_of_won_games as won_games
	,lg.number_of_lost_games as lost_games
	,dgt.draw_games as draws
from 
won_games_by_team wg
inner join lost_games_by_team lg on wg.winner = lg.loosers
inner join draw_games_by_team dgt on dgt.team = wg.winner
order by 2 desc






