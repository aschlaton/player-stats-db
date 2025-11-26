CREATE TABLE IF NOT EXISTS player_box_scores (
    id SERIAL PRIMARY KEY,
    player_id VARCHAR(50) NOT NULL,
    game_id VARCHAR(50) NOT NULL,
    team_id VARCHAR(50) NOT NULL,
    season VARCHAR(20) NOT NULL,
    player VARCHAR(255) NOT NULL,
    team VARCHAR(100) NOT NULL,
    match_up VARCHAR(100) NOT NULL,
    game_date VARCHAR(50) NOT NULL,
    w_l VARCHAR(10) NOT NULL,
    min INTEGER,
    pts INTEGER,
    fgm INTEGER,
    fga INTEGER,
    fg_percent DOUBLE PRECISION,
    three_pm INTEGER,
    three_pa INTEGER,
    three_p_percent DOUBLE PRECISION,
    ftm INTEGER,
    fta INTEGER,
    ft_percent DOUBLE PRECISION,
    oreb INTEGER,
    dreb INTEGER,
    reb INTEGER,
    ast INTEGER,
    stl INTEGER,
    blk INTEGER,
    tov INTEGER,
    pf INTEGER,
    plus_minus INTEGER,
    fp DOUBLE PRECISION,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(player_id, game_id)
);

-- Create indexes for common queries
CREATE INDEX idx_player_id ON player_box_scores(player_id);
CREATE INDEX idx_game_id ON player_box_scores(game_id);
CREATE INDEX idx_team_id ON player_box_scores(team_id);
CREATE INDEX idx_season ON player_box_scores(season);
CREATE INDEX idx_game_date ON player_box_scores(game_date);
CREATE INDEX idx_player_season ON player_box_scores(player_id, season);

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
