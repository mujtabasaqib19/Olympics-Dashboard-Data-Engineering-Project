WITH medal_base AS (
  SELECT
    a.discipline,
    a.noc,
    m.gold,
    m.silver,
    m.bronze,
    m.total,
    m.rank,
    m.rank_by_total
  FROM {{ ref('stg_athletes') }} a
  INNER JOIN {{ ref('stg_medals') }} m
    ON a.noc = m.noc
)
SELECT
  discipline,
  noc,
  COUNT(*) AS athlete_count,
  SUM(gold) AS total_gold,
  SUM(silver) AS total_silver,
  SUM(bronze) AS total_bronze,
  SUM(total) AS total_medals,
  MIN(rank) AS best_rank,
  AVG(rank_by_total) AS avg_rank_by_total,
  CASE
    WHEN SUM(gold) > 10 THEN 'Gold-Dominant'
    WHEN SUM(silver) > 10 THEN 'Silver-Dominant'
    WHEN SUM(bronze) > 10 THEN 'Bronze-Dominant'
    ELSE 'Even Spread'
  END AS medal_focus
FROM medal_base
GROUP BY discipline, noc