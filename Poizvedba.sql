SELECT *
FROM države
WHERE regija = "Evropa" OR regija = "Afrika";

SELECT *
FROM države
WHERE regija IN ("Evropa" , "Afrika");

SELECT *
FROM države
WHERE država LIKE "F%";

SELECT *
FROM države
WHERE država LIKE "%i";

SELECT *
FROM države
WHERE država LIKE "%g%";

SELECT *
FROM države
WHERE država LIKE "_u%";

SELECT *
FROM države
WHERE država LIKE "% %";

SELECT *
FROM države
WHERE država LIKE "% %" and država NOT LIKE "% % %";

SELECT *
FROM države
WHERE regija = "Evropa" AND (površina <10000 or prebivalstvo >10000000);

SELECT 5%7;

SELECT 5 DIV 7;

SELECT 4<<1;

SELECT *
FROM države
ORDER BY površina DESC;

SELECT *
FROM knjige
ORDER BY leto ASC, cena DESC, strani asc;

SELECT naslov, strani, cena, leto
FROM knjige
ORDER BY 4 ASC, 3 DESC, 2 ASC;

SELECT *
FROM države
ORDER BY prebivalstvo DESC
LIMIT 5;

SELECT *
FROM države
ORDER BY prebivalstvo DESC
LIMIT 4,1;

SELECT *
FROM države
ORDER BY prebivalstvo DESC
LIMIT 1 OFFSET 4;

SELECT COUNT(*)
FROM države
WHERE regija = "Evropa";

SELECT COUNT(distinct regija)
FROM države;

SELECT distinct regija
FROM države;

SELECT regija, COUNT(*)
FROM države
GROUP BY regija
ORDER BY 2 desc;

SELECT regija, COUNT(*)
FROM države
GROUP BY regija
HAVING COUNT(*) >= 20
ORDER BY 2 DESC;

SELECT regija, sum(prebivalstvo)
FROM države
WHERE regija = "Evropa";

SELECT regija, sum(prebivalstvo)
FROM države
GROUP BY regija
ORDER BY 2 DESC;

SELECT avg(prebivalstvo)
FROM države
WHERE država like "A%";

SELECT država
FROM države
WHERE površina = 
(SELECT MAX(površina) 
FROM države 
WHERE regija = "Afrika");


