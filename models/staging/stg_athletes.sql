SELECT
  "Name" AS name,
  "NOC" AS noc,
  "Discipline" AS discipline,
  ROW_NUMBER() OVER (PARTITION BY "NOC", "Discipline" ORDER BY "Name") AS athlete_row_num
FROM public.athletes
WHERE "Name" IS NOT NULL;
