with
goals_and_possesion as
(
select 
	`Goals Home` as number_of_goals
	,`home_possessions (%)` as possesion
from 
premier_league_stats pls 
union all
select
	`Away Goals`
	,`away_possessions (%)`
from
premier_league_stats pls2 	
)
SELECT 
  round((COUNT(*) * SUM(number_of_goals * possesion) - SUM(number_of_goals) * SUM(possesion)) / 
  SQRT((COUNT(*) * SUM(number_of_goals * number_of_goals) - POW(SUM(number_of_goals), 2)) * (COUNT(*) * SUM(possesion * possesion) - POW(SUM(possesion), 2))),2)
  AS correlation_coefficient
FROM goals_and_possesion

