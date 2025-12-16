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

-- Create view without metadata
CREATE OR REPLACE VIEW player_box_scores_view AS
SELECT
    player_id,
    game_id,
    team_id,
    player,
    team,
    match_up,
    game_date,
    season,
    w_l,
    min,
    pts,
    fgm,
    fga,
    fg_percent,
    three_pm,
    three_pa,
    three_p_percent,
    ftm,
    fta,
    ft_percent,
    oreb,
    dreb,
    reb,
    ast,
    stl,
    blk,
    tov,
    pf,
    plus_minus,
    fp
FROM player_box_scores;

-- Players table
CREATE TABLE IF NOT EXISTS players (
    id SERIAL PRIMARY KEY,
    player_id VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    team VARCHAR(100),
    number INTEGER,
    position VARCHAR(50),
    height VARCHAR(20),
    weight VARCHAR(50),
    college VARCHAR(255),
    country VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for players table
CREATE INDEX idx_players_player_id ON players(player_id);
CREATE INDEX idx_players_team ON players(team);
CREATE INDEX idx_players_name ON players(name);

-- Trigger for players updated_at
CREATE TRIGGER update_players_updated_at
    BEFORE UPDATE ON players
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
