-- models/marts/noc_medal_trends.sql
-- Tracks medals by NOC with trends for Power BI charting

SELECT
  m.noc,
  SUM(m.gold) AS total_gold,
  SUM(m.silver) AS total_silver,
  SUM(m.bronze) AS total_bronze,
  SUM(m.total) AS total_medals,
  MIN(m.rank) AS best_rank,
  AVG(m.rank_by_total) AS avg_rank_by_total,
  RANK() OVER (ORDER BY SUM(m.gold) DESC) AS gold_rank,
  RANK() OVER (ORDER BY SUM(m.total) DESC) AS total_medal_rank,
  CASE
    WHEN SUM(m.total) > 25 THEN 'Top Performer'
    WHEN SUM(m.total) BETWEEN 10 AND 25 THEN 'Competitive'
    ELSE 'Developing'
  END AS performance_band
FROM {{ ref('stg_medals') }} m
GROUP BY m.noc
