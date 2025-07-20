
-- 6. Export Team Performance Reports
-- SQL Query: Team Performance Summary Report

SELECT 
    t.team_name,
    COUNT(DISTINCT m.match_id) AS matches_played,
    SUM(CASE WHEN m.winner_id = t.team_id THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN m.team1_id = t.team_id OR m.team2_id = t.team_id THEN 1 ELSE 0 END) AS appearances,
    ROUND(
        (SUM(CASE WHEN m.winner_id = t.team_id THEN 1 ELSE 0 END) /
        NULLIF(SUM(CASE WHEN m.team1_id = t.team_id OR m.team2_id = t.team_id THEN 1 ELSE 0 END), 0)) * 100, 2
    ) AS win_percentage
FROM Teams t
LEFT JOIN Matches m 
    ON m.team1_id = t.team_id OR m.team2_id = t.team_id
GROUP BY t.team_id, t.team_name
ORDER BY win_percentage DESC;

