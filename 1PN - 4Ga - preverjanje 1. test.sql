-- Uvozite pripravljeno skripto. Vse delajte v ustvarjeni podatkovni zbirki. Kodo shranite v tekstovno datoteko in jo pustite na namizju.
-- Napišite poizvedbe v jeziku SQL za naslednje naloge.
-- 1. Iz tabele občine izpišite za vse Gorenjske občine število učencev, dijakov in študentov. (10t)
SELECT `ime_občine`, `učenci`, dijaki, `študenti`
FROM `občine`
WHERE ime_regije = "Gorenjska";
-- 2. Iz tabele osebe izpišite vse podatke za tiste ženske, ki se jim ime začne na črko 'a'. (10t)
SELECT *
FROM osebe
WHERE spol = "Ž" AND ime LIKE "A%";
-- 3. Izpišite imena petih občin tabele občine, ki imajo najmanj komunalnih odpadkov na prebivalca. (10t)
SELECT `ime_občine`, komunalni_odpadki / prebivalci
FROM `občine`
ORDER BY komunalni_odpadki / prebivalci asc
LIMIT 5; 
-- 4. Katera občina iz tabele občine je na petem mestu po številu podjetij? (10t)
SELECT `ime_občine`, podjetja
FROM `občine`
ORDER BY podjetja desc
LIMIT 4, 1;
-- 5. Tabeli osebe in poklici sta povezani preko stolpcev id_poklica in id. Izpišite vse osebe skupaj s poklicem, ki so bile rojene v samostojni Sloveniji, ne glede na to ali imajo poklic ali ne. (10t)
SELECT o.ime, o.priimek, p.poklic
FROM osebe o left join poklici p
ON o.id_poklica = p.id
WHERE o.rojstni_dan > "1991-12-23";
-- 6. Koliko oseb tabele osebe se je rodilo med 6. in 7. uro zjutraj. (10t)
SELECT COUNT(*)
FROM osebe
WHERE hour(rojstni_dan) = 6;
-- 7. Izpišite število avtomobilov po posameznih regijah tabele občine, a samo za tiste regije, ki imajo več kot 100000 avtomobilov. (10t)
SELECT ime_regije, sum(osebni_avtomobili)
FROM `občine`
GROUP BY ime_regije
HAVING sum(osebni_avtomobili) > 100000;