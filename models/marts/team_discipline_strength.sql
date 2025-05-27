-- models/marts/team_discipline_strength.sql
-- Measures team size and medal impact by NOC and discipline

WITH team_strength AS (
  SELECT
    t.discipline,
    t.noc,
    COUNT(DISTINCT t.team_name) AS total_teams,
    COUNT(DISTINCT t.event) AS total_events
  FROM {{ ref('stg_teams') }} t
  GROUP BY t.discipline, t.noc
),
medal_join AS (
  SELECT
    ts.discipline,
    ts.noc,
    ts.total_teams,
    ts.total_events,
    COALESCE(SUM(m.gold), 0) AS gold,
    COALESCE(SUM(m.silver), 0) AS silver,
    COALESCE(SUM(m.bronze), 0) AS bronze
  FROM team_strength ts
  LEFT JOIN {{ ref('stg_medals') }} m
    ON ts.noc = m.noc
  GROUP BY ts.discipline, ts.noc, ts.total_teams, ts.total_events
)
SELECT *,
  CASE
    WHEN gold + silver + bronze > 15 THEN 'Elite Team'
    WHEN gold + silver + bronze BETWEEN 8 AND 15 THEN 'Strong Contender'
    ELSE 'Emerging'
  END AS team_medal_strength
FROM medal_join
