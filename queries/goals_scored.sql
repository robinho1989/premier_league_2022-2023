select 
	sum(`Goals Home`) + sum(`Away Goals`) as goals_scored  
from 
premier_league_stats pls 