# 🏏 Sports Tournament Tracker (MySQL Project)

A comprehensive SQL-based solution to manage and analyze a multi-team sports tournament using MySQL. It includes team and player tracking, match results, statistical views, and performance reports.

---

## 📘 Overview

This project simulates the database backend of a sports tournament (e.g., cricket). It includes:

- Teams & Players Management  
- Match Results Tracking  
- Player Statistics  
- Leaderboard & Points Table using SQL Views  
- Performance Analysis using CTEs

---

## 🏗️ Database Schema

The project consists of the following main tables:

- **Teams** – Stores team details  
- **Players** – Stores player details linked to teams  
- **Matches** – Stores match fixtures and results  
- **Stats** – Stores player-level performance in each match  

```sql
CREATE TABLE Teams (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(50) NOT NULL
);
```

---

## 📊 SQL Views & Queries

### 1. **Player Leaderboard View**

Ranks players based on total runs and wickets.

```sql
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
```

### 2. **Team Points Table View**

Displays team-wise win count and points.

```sql
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
```

---

## 🔄 CTE for Average Performance

```sql
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
```

---

## 📤 Performance Report Query

Provides match stats per team:

```sql
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
```

---

## 🛠️ Tools Used

- **MySQL** (8.x)
- **MySQL Workbench** / CLI
- **SQL Views & CTEs**

---

## ✅ Features

- Team-wise and player-wise tracking
- Match results and statistics
- SQL Views for simplified analytics
- Reusable queries with CTEs
- Exportable performance summary

---

## 📁 Project Structure

```bash
📦 Sports-Tournament-Tracker/
├── schema.sql
├── views.sql
├── performance_report.sql
├── README.md
└── Sports_Tournament_Tracker_Report.pdf
```

---

## 📌 License

This project is open-source and free to use for academic or non-commercial purposes.
