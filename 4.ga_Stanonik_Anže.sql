-- Ustvarite podatkovno zbirko z imenom oblike »razred_priimek_ime« (npr. 4ra_Novak_Janez). Uvozite pripravljene skripte. Vse delajte v ustvarjeni podatkovni zbirki. Kodo shranite v tekstovno datoteko in jo oddajte v spletno učilnico.
-- Napišite poizvedbe v jeziku SQL za naslednje naloge.
-- 1. Izpišite imena, priimke in rojstne dneve tistih oseb tabele rojstni_dnevi, ki so rojeni po letu 1945. (10t)
SELECT ime, priimek, rojstni_dan
FROM rojstni_dnevi
WHERE YEAR(rojstni_dan) > 1945;
-- 2. Izpišite imena, priimke in spol tistih oseb tabele rojstni_dnevi, ki imajo enako dolžino imena in priimka. (10t)
SELECT ime, priimek, spol
FROM rojstni_dnevi
WHERE CHAR_LENGTH(ime) = CHAR_LENGTH(priimek);
-- 3. Izpišite različne države iz tabele atp. Razvrstite jih po abecedi padajoče. (10t)
SELECT `država`
FROM atp
GROUP BY država
ORDER BY `država` desc;
-- 4. Katera evropska država je na 15. mestu po številu prebivalcev iz tabele države?(10t)
SELECT `država`
FROM države
ORDER BY prebivalstvo DESC
LIMIT 14,1;
-- 5. Kolikšna je skupna površina afriških držav iz tabele države? (10t)
SELECT regija, SUM(`površina`) AS površina
FROM `države`
WHERE regija = "Afrika";
-- 6. Koliko knjig tabele knjige, je cenejših od 30€? Stolpec v izpisu poimenujte "Poceni knjige". (10t)
SELECT COUNT(ID_knjige) AS "Poceni knjige"
FROM knjige
WHERE Cena < 30;
-- 7. Izpišite število držav po posameznih regijah tabele države! (10t)
SELECT regija, COUNT(št) AS "število držav po posameznih regijah"
FROM `države`
GROUP BY regija;
-- 8. V stolpec opombe tabele dnevnik vnesite svoje ime in priimek in trenutni datum in čas v stolpec čas! (10t)
-- 9. V stolpec V tabele telesa vpišite prostornino za vse kocke, z enim samim stavkom. (10t)
-- 10. Izbrišite vse trikotnike iz tabele liki. (10t)