CREATE TABLE IF NOT EXISTS player_box_scores (
    id SERIAL PRIMARY KEY,
    player_name VARCHAR(255) NOT NULL,
    team VARCHAR(100),
    game_date DATE NOT NULL,
    season VARCHAR(20) NOT NULL,
    opponent VARCHAR(100),
    minutes_played DECIMAL(5, 2),
    points INTEGER,
    rebounds INTEGER,
    assists INTEGER,
    steals INTEGER,
    blocks INTEGER,
    turnovers INTEGER,
    field_goals_made INTEGER,
    field_goals_attempted INTEGER,
    three_pointers_made INTEGER,
    three_pointers_attempted INTEGER,
    free_throws_made INTEGER,
    free_throws_attempted INTEGER,
    plus_minus INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for common queries
CREATE INDEX idx_player_name ON player_box_scores(player_name);
CREATE INDEX idx_game_date ON player_box_scores(game_date);
CREATE INDEX idx_season ON player_box_scores(season);
CREATE INDEX idx_player_season ON player_box_scores(player_name, season);

-- function to update updated_at col
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- automatically update updated_at col
CREATE TRIGGER update_player_box_scores_updated_at
    BEFORE UPDATE ON player_box_scores
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
