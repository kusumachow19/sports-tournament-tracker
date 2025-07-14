-- 3. Queries for match results,player scores

-- A. Get All Match Results

SELECT 
    m.match_id,
    m.match_date,
    t1.team_name AS team1,
    t2.team_name AS team2,
    tw.team_name AS winner
FROM Matches m
JOIN Teams t1 ON m.team1_id = t1.team_id
JOIN Teams t2 ON m.team2_id = t2.team_id
JOIN Teams tw ON m.winner_id = tw.team_id
ORDER BY m.match_date;

-- B. Player Performance in a Specific Match

SELECT 
    s.match_id,
    p.player_name,
    t.team_name,
    s.runs,
    s.wickets
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
JOIN Teams t ON p.team_id = t.team_id
WHERE s.match_id = 10; -- Change 10 to any match ID

--  C. Total Runs and Wickets by Each Player

SELECT 
    p.player_name,
    t.team_name,
    SUM(s.runs) AS total_runs,
    SUM(s.wickets) AS total_wickets
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
JOIN Teams t ON p.team_id = t.team_id
GROUP BY p.player_id
ORDER BY total_runs DESC;


-- D. Match-wise Top Scorer

SELECT 
    s.match_id,
    p.player_name,
    MAX(s.runs) AS top_score
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
GROUP BY s.match_id, p.player_id
ORDER BY s.match_id, top_score DESC;

-- E. Team-wise Total Runs in All Matches

SELECT 
    t.team_name,
    SUM(s.runs) AS team_total_runs
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
JOIN Teams t ON p.team_id = t.team_id
GROUP BY t.team_id
ORDER BY team_total_runs DESC;
