select 
	round((sum(`Goals Home`)+sum(`Away Goals`))/count(*),2) as average_goals_per_game 
from 
premier_league_stats pls 