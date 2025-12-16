# Player Stats Database

PostgreSQL database for storing NBA data.

## Sample Queries

**Check total records:**
```bash
docker exec player-stats-db psql -U postgres -d player_stats -c "SELECT COUNT(*) FROM player_box_scores;"
```

**View sample records:**
```bash
docker exec player-stats-db psql -U postgres -d player_stats -c "SELECT player, team, game_date, pts, reb, ast FROM player_box_scores LIMIT 10;"
```
