
-- 5. Use CTE for Average Player Performance

-- CTE: Average Runs and Wickets per Player

WITH Player_Averages AS (
    SELECT 
        p.player_id,
        p.player_name,
        t.team_name,
        AVG(s.runs) AS avg_runs,
        AVG(s.wickets) AS avg_wickets
    FROM Stats s
    JOIN Players p ON s.player_id = p.player_id
    JOIN Teams t ON p.team_id = t.team_id
    GROUP BY p.player_id, p.player_name, t.team_name
)
SELECT * FROM Player_Averages
ORDER BY avg_runs DESC;
