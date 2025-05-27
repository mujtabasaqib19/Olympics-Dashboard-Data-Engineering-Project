WITH joined AS (
  SELECT
    e.discipline,
    e.female,
    e.male,
    e.total AS total_entries,
    COALESCE(SUM(d.total_medals), 0) AS total_medals
  FROM {{ ref('stg_entries_gender') }} e
  LEFT JOIN {{ ref('discipline_medal_summary') }} d
    ON e.discipline = d.discipline
  GROUP BY e.discipline, e.female, e.male, e.total
)
SELECT *,
  ROUND(CAST(total_medals AS NUMERIC), 2) / NULLIF(total_entries, 0) AS medals_per_entry,
  CASE
    WHEN female = male THEN 'Balanced'
    WHEN female > male THEN 'Female-Dominant'
    ELSE 'Male-Dominant'
  END AS gender_dominance,
  CASE
    WHEN total_medals > 20 THEN 'High Output'
    WHEN total_medals BETWEEN 10 AND 20 THEN 'Medium Output'
    ELSE 'Low Output'
  END AS performance_tier
FROM joined
