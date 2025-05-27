SELECT
  "Name" AS team_name,
  "Discipline" AS discipline,
  "NOC" AS noc,
  "Event" AS event,
  DENSE_RANK() OVER (PARTITION BY "Discipline" ORDER BY "Name") AS team_rank_within_discipline
FROM public.teams
WHERE "Name" IS NOT NULL