SELECT
  "Team/NOC" AS noc,
  CAST("Gold" AS INTEGER) AS gold,
  CAST("Silver" AS INTEGER) AS silver,
  CAST("Bronze" AS INTEGER) AS bronze,
  CAST("Total" AS INTEGER) AS total,
  CAST("Rank" AS INTEGER) AS rank,
  CAST("Rank by Total" AS INTEGER) AS rank_by_total,
  RANK() OVER (ORDER BY CAST("Gold" AS INTEGER) DESC) AS rank_by_gold
FROM public.medals