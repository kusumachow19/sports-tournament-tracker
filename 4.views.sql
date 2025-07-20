-- 4. Create Views for Leaderboards and Points Tables

-- A. View: Player_Leaderboard
CREATE VIEW Player_Leaderboard AS
SELECT 
    p.player_id,
    p.player_name,
    t.team_name,
    SUM(s.runs) AS total_runs,
    SUM(s.wickets) AS total_wickets
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
JOIN Teams t ON p.team_id = t.team_id
GROUP BY p.player_id, p.player_name, t.team_name
ORDER BY total_runs DESC, total_wickets DESC;

SELECT * FROM Player_Leaderboard LIMIT 10;


-- B. View: Team_Points
CREATE VIEW Team_Points AS
SELECT 
    t.team_id,
    t.team_name,
    COUNT(m.winner_id) AS wins,
    COUNT(m.winner_id) * 2 AS points
FROM Matches m
JOIN Teams t ON m.winner_id = t.team_id
GROUP BY t.team_id, t.team_name
ORDER BY points DESC;


SELECT * FROM Team_Points;