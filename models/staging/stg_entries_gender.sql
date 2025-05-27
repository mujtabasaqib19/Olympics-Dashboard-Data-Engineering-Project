SELECT
  "Discipline" AS discipline,
  CAST("Female" AS INTEGER) AS female,
  CAST("Male" AS INTEGER) AS male,
  CAST("Total" AS INTEGER) AS total,
  RANK() OVER (ORDER BY CAST("Total" AS INTEGER) DESC) AS participation_rank
FROM public.entriesgender