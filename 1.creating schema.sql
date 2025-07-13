-- 1.Creating schema:Teams,Players,Matches,Stats.

-- Teams Table
CREATE TABLE Teams (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(50) NOT NULL
);


-- Players Table
CREATE TABLE Players (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    player_name VARCHAR(50) NOT NULL,
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);


-- Matches Table
CREATE TABLE Matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    match_date DATE,
    team1_id INT,
    team2_id INT,
    winner_id INT,
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id),
    FOREIGN KEY (winner_id) REFERENCES Teams(team_id)
);



-- Stats Table
CREATE TABLE Stats (
    stat_id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT,
    player_id INT,
    runs INT,
    wickets INT,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);
