-- Izpišite vse podatke iz tabele obcine.
SELECT *
FROM občine;
-- Izpišite vse podatke za Kranj.
SELECT *
FROM občine
WHERE ime_občine = "Kranj";
-- Izpišite vse podatke za Kranj in Ljubljano.
SELECT *
FROM občine
WHERE ime_občine = "Kranj" || ime_občine = "Ljubljana";
-- Izpišite vse podatke za Kranj, Maribor, Koper, Novo mesto in Jesenice.
SELECT *
FROM občine
WHERE ime_občine IN ("Kranj", "Maribor", "Novo mesto", "Jesenice") || ime_občine LIKE "koper%";
-- Izpišite imena vseh občin, ki so velike med 100 in 300 km2. Spisek uredite po abecednem vrstnem redu naraščajoče.
SELECT *
FROM občine
WHERE površina < 300 && površina > 100
ORDER BY ime_občine;
-- Izpišite imena vseh gorenjskih občin v bazi. Spisek uredite po abecednem vrstnem redu padajoče.
SELECT *
FROM občine
WHERE ime_regije = "gorenjska"
ORDER BY ime_občine DESC;
-- Izpišite vse podatke o občinah, katerih ime regije se prične s črko O.
SELECT *
FROM občine
WHERE ime_regije LIKE "o%";
-- Izpišite vse podatke o občinah, ki imajo v imenu besedo ob.
SELECT *
FROM občine
WHERE ime_regije LIKE "%ob%";
-- Prikažite ime občine ter število prebivalcev na km2 površine občine. Spisek uredite enkrat padajoče in enkrat naraščajoče po gostoti prebivalstva. Stolpec, ki prikazuje število prebivalcev na km2 poimenuj Gostota prebivalstva.
SELECT ime_občine, prebivalci/površina AS gostota
FROM občine
ORDER BY 2;
SELECT ime_občine, prebivalci/površina AS gostota
FROM občine
ORDER BY 2 desc;
-- Prikažite gostoto prebivalstva za Kranj. V glavi stolpca naj piše: Gostota prebivalstva za Kranj.
SELECT prebivalci/površina AS "Gostota prebivalstva za Kranj"
FROM občine
WHERE ime_občine = "Kranj";
-- Prikažite ime občine in neto plačo na prebivalca. Spisek naj bo urejen naraščajoče po neto plači na prebivalca. Stolpec v katerem je prikazan izračunana vrednost naj se imenuje: neto plača na prebivalca.
SELECT ime_občine, neto_plača_na_zaposlenega*zaposlene_osebe/prebivalci AS "neto plača na prebivalca"
FROM občine
ORDER BY 2;
-- Stolpcu dajte ime Število gorenjskih občin v bazi in izpišite podatke o številu občina pri katerih je kot regija navedena Gorenjska.
SELECT COUNT(*) AS "Število gorenjskih občin v bazi"
FROM občine
WHERE ime_regije = "gorenjska";
-- Koliko je občin z več kot 10000 prebivalcev.
SELECT COUNT(*) AS "občin z več kot 10000 prebivalcev"
FROM občine
WHERE prebivalci > 10000;
-- Koliko je skupno število prebivalcev v občinah, ki so v bazi.
SELECT sum(prebivalci) AS "število prebivalcev v občinah"
FROM občine;
-- Koliko je skupno število prebivalcev v gorenjski regiji.
SELECT sum(prebivalci) AS "število prebivalcev v orenjski regiji"
FROM občine
WHERE ime_regije = "gorenjska";
-- Prikažite skupno število prebivalcev za posamezno regijo. Seznam naj bo urejen padajoče po skupnem številu prebivalcev.
SELECT ime_regije, sum(prebivalci) AS "število prebivalcev v orenjski regiji"
FROM občine
GROUP by ime_regije
ORDER BY 2 desc;
-- Prikažite vse regije, ki imajo več kot 200000 prebivalcev.
SELECT ime_regije, SUM(prebivalci)
FROM občine
GROUP BY ime_regije
HAVING SUM(prebivalci) > 200000
ORDER BY 2 DESC;
-- Prikažite skupno število prebivalcev in gostoto prebivalstva na km2 za posamezno regijo. Seznam naj bo urejen padajoče po skupnem gostoti prebivalcev.
SELECT ime_regije, SUM(prebivalci), SUM(prebivalci)/SUM(površina) AS gostota
FROM občine
GROUP BY ime_regije
ORDER BY 3 DESC;
-- Prikažite imena občin in skupen prihodek za prvih 10 najbogatejših občin.
SELECT ime_občine, prihodek_podjetij_1000
FROM občine
ORDER BY 2 DESC
LIMIT 10;
-- Prikažite imena občin in skupen prihodek za prvih 10% najbogatejših občin.
prepare stavek FROM 'SELECT ime_občine, prihodek_podjetij_1000
FROM občine
ORDER BY 2 desc
LIMIT ?;'
SET @X=(SELECT Max(id_občine) div 10
FROM občine)
EXECUTE stavek USING @X;
-- Prikažite skupen prihodek po regijah. Spisek naj bo urejen po skupnem prihodku padajoče.
SELECT ime_regije, sum(prihodek_podjetij_1000)
FROM občine
GROUP BY ime_regije
ORDER BY 2 DESC;
-- Izpišite ime regije in površino najmanjše občine za Gorenjsko, Koroško, Pomursko in Zasavsko.
SELECT ime_regije, ime_občine, površina
FROM občine
WHERE (ime_regije, površina) IN
(SELECT ime_regije, MIN(površina) 
FROM občine
WHERE ime_regije IN ('Gorenjska', 'Koroška', 'Pomurska', 'Zasavska')
GROUP BY ime_regije);
-- Izpišite občine in njihove površine za vse občine v bazi, pri katerih je površina za 50% manjša ali večja kot je površina Kranjske občine.
SELECT `ime_občine`, površina
FROM občine
WHERE`površina` < 
(SELECT `površina`/ 1.5
FROM občine
WHERE `ime_občine` = "Kranj") OR
`površina` > 
(SELECT `površina`* 1.5
FROM občine
WHERE `ime_občine` = "Kranj")
ORDER BY 2 asc;
-- Izpišite občini v katerih je največja razlika po številu moških in žensk. 
SELECT `ime_občine`, ABS(`moški` - `ženske`)
FROM `občine`
order BY 2 DESC LIMIT 2;
-- Izpišite prvih pet občin z največjo gostoto otrok v vrtcih.
SELECT `id_občine`, `ime_občine`, round(otroci_v_vrtcih/vrtci)
FROM `občine`
order BY 3 DESC LIMIT 5;
-- V kateri občini je največji odstotek brezposelnih oseb?
SELECT ime_občine, brezposelne_osebe/ prebivalci * 100 AS "odstotek brezposelnih oseb"
FROM `občine`
order BY 2 DESC LIMIT 1;
-- V kateri regiji je največji odstotek brezposelnih oseb?
SELECT ime_regije, SUM(brezposelne_osebe)/SUM(prebivalci)
FROM `občine`
GROUP BY ime_regije DESC 
order BY 2 desc LIMIT 1;
-- Ali je v kateri občini več študentov kot dijakov in tudi več dijakov kot učencev?
SELECT `ime_občine`
FROM `občine`
WHERE `študenti` > dijaki AND dijaki > `učenci`;
-- Zanimajo nas občine, ki imajo več stanovanj kot avtomobilov.
SELECT `ime_občine`, stanovanja, osebni_avtomobili
FROM `občine`
WHERE stanovanja > osebni_avtomobili;
-- 
-- 
SELECT *
FROM knjige
ORDER BY leto ASC, cena DESC, strani ASC;

SELECT COUNT(distinct regija)
FROM države;

SELECT država
FROM države
WHERE površina = 
(SELECT MAX(površina) 
FROM države 
WHERE regija = "Afrika");

-- Preverjanje – poizvedbe           				A
-- Imamo podatkovno zbirko Glasbene skupine z naslednjimi tabelami. V zbirki zajemamo podatke o bandih, članih bandov ter njihovih vlogah v bandu.
--   
-- 
-- 1.	Izpišite vse glasbenike, urejene po abecednem vrstnem redu.  1t
SELECT ime, priimek
FROM glasbeniki
ORDER BY 1 ASC;

-- 2.	Izpišite vse bande in število let, ki so pretekla od njihovega nastanka. 2t
SELECT ime, year(CURDATE()) - leto_ustanovitve
FROM bandi;
-- 3.	V katerih bandih je zabeležen le en član? 2t
SELECT b.ime
FROM bandi b JOIN glasbeniki g
ON b.ID_banda = g.ID_banda
GROUP BY b.ime
HAVING COUNT(b.ime) = 1;
-- 4.	Ali obstaja glasbenik, ki nima zabeležene nobene vloge v bandu?  2t
SELECT g.ime, g.priimek, COUNT(gv.ID_glasbenika)
FROM glasbeniki g left JOIN glasbeniki_vloge gv
ON g.ID_glasbenika = gv.ID_glasbenika
GROUP BY ime
HAVING COUNT(gv.ID_glasbenika) = 0;
-- 5.	Kateri glasbenik je najstarejši? 2t
SELECT ime, priimek, datum_rojstva
FROM glasbeniki
ORDER BY CURDATE() - datum_rojstva DESC LIMIT 1 ;
-- 6.	V katerem bandu je David Gilmour in kakšno vlogo ima? 2t
SELECT g.ime , g.priimek, b.ime AS "ime banda", v.opis
FROM glasbeniki g JOIN bandi b
ON g.ID_banda = b.ID_banda
JOIN glasbeniki_vloge gv 
ON g.ID_glasbenika = gv.ID_glasbenika
JOIN vloge v
ON v.ID_vloga_v_bandu = gv.ID_vloga_v_bandu
WHERE g.ime = "David";
-- 7.	Izpišite število bandov po posameznih žanrih. 2t
SELECT z.naziv_zanra, COUNT(*)
FROM bandi b JOIN zanri z
ON b.ID_zanra = z.ID_zanra
GROUP BY z.ID_zanra;
-- 8.	Izpiši vse slovenske bobnarje. 2t
SELECT g.ime, g.priimek
FROM glasbeniki g JOIN bandi b
ON g.ID_banda = b.ID_banda
JOIN drzave d 
ON d.ID_drzava = b.ID_drzava
WHERE d.naziv_drzave = "Slovenija";

-- Odgovorite na naslednja vprašanja!
-- 
-- Izpišite priimek, ime in oddelek za vse zaposlene. Izpis uredi naraščajoče po abecednem redu priimkov zaposlenih
-- ;
SELECT z.Priimek , z.Ime , o.Oddelek
FROM zaposleni z JOIN oddelki o
ON z.ID_Oddelek = o.ID_Oddelek
ORDER BY z.Priimek;
-- Izpišite priimke, imena in telefonske številke delavcev, ki delajo v oddelku Dodelava
-- ;
SELECT Priimek, Ime , Telefon
FROM zaposleni z JOIN oddelki o
ON z.ID_Oddelek = o.ID_Oddelek
WHERE o.Oddelek = 'Dodelava';
-- V katerem oddelku dela Kovač Anton?
-- ;
SELECT o.Oddelek
FROM zaposleni z JOIN oddelki o
ON z.ID_Oddelek = o.ID_Oddelek
WHERE z.Ime = 'Anton' AND z.priimek = 'Kovač';
-- Koliko ljudi je zaposlenih v oddelku Servis?
-- ;
SELECT COUNT(*)
FROM zaposleni z JOIN oddelki o
ON z.ID_Oddelek = o.ID_Oddelek
WHERE o.Oddelek = 'Servis';
-- Izpišite imena oddelkov in število zaposlenih v posameznem oddelku.
-- ;
SELECT o.Oddelek, COUNT(*)
FROM zaposleni z JOIN oddelki o
ON z.ID_Oddelek = o.ID_Oddelek
GROUP BY o.Oddelek;
-- Izpišite vse izdelke in njihove cene iz skupine Nahrbtniki.
-- ;
SELECT i.Izdelek, i.Cena
FROM izdelki i JOIN kategorije k
ON i.ID_Kategorija = k.ID_Kategorija
WHERE k.Kategorija = 'Nahrbtniki';
-- Izpišite kategorije in število izdelkov v posamezni kategoriji.
-- ;
SELECT k.Kategorija, COUNT(*)
FROM izdelki i JOIN kategorije k
ON i.ID_Kategorija = k.ID_Kategorija
GROUP BY k.Kategorija;
-- Izpišite datume vseh naročil za stranko Zdravje.
-- ;
SELECT n.Datum
FROM narocilo n JOIN stranke s
ON n.ID_Stranka = s.ID_Stranka
WHERE s.Ime = 'Zdravje';
-- Koliko naročil je bilo izvedenih za stranko Zdravje?
-- ;
SELECT COUNT(*)
FROM narocilo n JOIN stranke s
ON n.ID_Stranka = s.ID_Stranka
WHERE s.Ime = 'Zdravje'; 
-- Izpišite število naročil po posameznih strankah. Spisek naj bo urejen padajoče po številu naročil.
-- ;
SELECT s.Ime, count(*)
FROM narocilo n JOIN stranke s
ON n.ID_Stranka = s.ID_Stranka
GROUP BY s.ID_Stranka 
ORDER BY 2 desc;
-- Izpišite ime in priimek in število obdelanih naročil zaposlenega, ki je obdelal največ naročili.
-- ;
SELECT z.Ime, z.Priimek, COUNT(n.ID_Narocilo) 
FROM narocilo n JOIN zaposleni z
ON n.ID_Zaposleni = z.ID_Zaposleni
GROUP BY n.ID_Zaposleni
ORDER BY COUNT(n.ID_Narocilo) DESC
LIMIT 1;
-- Izpišite številke naročil, ki so bila obdelana 22.3.2002.
-- ;
SELECT COUNT(*)
FROM narocilo
WHERE Datum = "2002-3-22";
-- Izpišite izdelke, količine in cene za naročilo, ki je bilo dne 3.1.2002 obdelano za stranko V naravo d.o.o..
-- ;
SELECT i.Izdelek, nd.Kolicina, nd.Cena
FROM narocilo n JOIN narocilodetajl nd
ON n.ID_Narocilo = nd.ID_Narocilo
JOIN izdelki i
ON nd.ID_Izdelek = i.ID_Izdelek
JOIN stranke s
ON n.ID_Stranka =  s.ID_Stranka
WHERE n.Datum = '2002-1-3' AND s.Ime = 'V naravo d.o.o.';

-- Pripravite poizvedbo, ki pripravi povzetek računa za naročilo 10622. Na povzetku naj bo znesek, ki je osnova za DDV, znesek DDV (20%) in skupni znesek računa in ime Stranke.
SELECT i.Cena, i.cena * 0.2 AS DDV, i.Cena * 1.2 AS "skupni znesek računa" , s.Ime AS "ime Stranke"
FROM narocilo n JOIN narocilodetajl nd
ON n.ID_Narocilo = nd.ID_Narocilo
JOIN izdelki i 
ON i.ID_Izdelek = nd.ID_Izdelek 
JOIN stranke s 
ON s.ID_Stranka = n.ID_Stranka
WHERE n.ID_Narocilo = 10622;
-- Prikažite skupni promet po strankah. Spisek naj bo urejen padajoče po prometu.

-- Prikažite ime stranke in promet za najboljše tri stranke, ki so leta 2002 opravile največ prometa. Namig: WHERE YEAR(Datum) = 2002
-- Izpišite imena izdelkov, cene in povprečno ceno izdelkov.
-- Katere enake izdelke sta kupili stranki Zagon in Aktiva d.o.o.?
-- Katere izdelke je kupila stranka Zagon, ne pa tudi Aktiva d.o.o.?
-- Z izdelki katere kategorije je bilo opravljenega največ prometa? Koliko?
-- Kateri zaposleni (priimek in ime) imajo opravka s strankami?
-- Kateri zaposleni v oddelku Prodaja ne delajo z nobeno stranko?
-- Izpišite ime in priimek zaposlenega in ime stranke s katero sodeluje, če zaposleni ne sodeluje z nobeno stranko se v izpisu vidi Null.

-- Razvrstite osebe od najstarejše do najmlajše.
SELECT *
FROM rojstni_dnevi
order BY rojstni_dan asc;
-- Izpišite dve najmlajši ženski in dva najstarejša moška.
(SELECT *
FROM rojstni_dnevi
WHERE spol = 'Ž'
order BY rojstni_dan desc LIMIT 2)
union
(SELECT *
FROM rojstni_dnevi
WHERE spol = 'M'
order BY rojstni_dan asc LIMIT 2);
-- Izpišite vse, ki bodo imeli rojstni dan v naslednjih 90 dneh.



SELECT dayofyear(concat(YEAR("2024-11-28"), "-12-31")) FROM rojstni_dnevi;


SELECT rojstni_dan, dayofyear(rojstni_dan), dayofyear(rojstni_dan) - DAYOFYEAR(CURDATE())
,IF(dayofyear(rojstni_dan) - DAYOFYEAR(CURDATE()) >= 0, dayofyear(rojstni_dan) - DAYOFYEAR(CURDATE()), dayofyear(concat(YEAR(CURDATE()), "-12-31")) + (dayofyear(rojstni_dan) - DAYOFYEAR(CURDATE()))) AS diff
FROM rojstni_dnevi
WHERE dayofyear(rojstni_dan) > DAYOFYEAR(CURDATE()) OR
 dayofyear(rojstni_dan) + dayofyear(concat(YEAR(CURDATE()), "-12-31")) < DAYOFYEAR(CURDATE()) + 90
 ORDER BY diff;



-- SELECT *, DATEDIFF(MAKEDATE(2023,dayofyear(rojstni_dan)), CURDATE())
-- FROM rojstni_dnevi
-- WHERE (DATEDIFF(MAKEDATE(2023,dayofyear(rojstni_dan)), CURDATE()) BETWEEN 0 AND 90) 
-- OR (DATEDIFF(MAKEDATE(2024,dayofyear(rojstni_dan)), CURDATE()) BETWEEN 0 AND 90);


SELECT DATEDIFF("2017-01-01", "2016-12-24");
SELECT CURDATE();

-- Poiščite vse, ki so stari med 10000 in 20000 dnevi.
SELECT *, DATEDIFF(CURDATE(), rojstni_dan)
FROM rojstni_dnevi
#WHERE ((day(CURDATE()) + MONTH(CURDATE())*30 + YEAR(CURDATE())*365) - (day(rojstni_dan) + MONTH(rojstni_dan)*30 + YEAR(rojstni_dan)*365)) > 10000 AND ((day(CURDATE()) + MONTH(CURDATE())*30 + YEAR(CURDATE())*365) - (day(rojstni_dan) + MONTH(rojstni_dan)*30 + YEAR(rojstni_dan)*365)) < 20000
WHERE DATEDIFF(CURDATE(), rojstni_dan) BETWEEN 10000 AND 20000
ORDER BY 6 ASC;
-- Poiščite vse, ki so rojeni med drugo svetovno vojno in niso rojeni meseca septembra. (1939-09-01 do 1945-09-02)
SELECT *
FROM rojstni_dnevi;
#WHERE (year(rojstni_dan) > 1938 AND MONTH(rojstni_dan) > 9 )  AND (YEAR(rojstni_dan) < 1946  and MOnth(rojstni_dan) < 9); 
#WHERE date(rojstni_dan) BETWEEN DATE('1939-10-0') AND DATE('1945-8-31');
#WHERE year(DATEDIFF((CURDATE() , 1939-10-01))) BETWEEN 78 and 83;
-- Koliko oseb je rojenih v posameznem mesecu?
SELECT month(rojstni_dan), COUNT(*)
FROM rojstni_dnevi
GROUP BY month(rojstni_dan)
order BY 1;
-- Izpišite mesece, v katerih je bilo rojeno vsaj sedem oseb.
SELECT month(rojstni_dan), COUNT(*)
FROM rojstni_dnevi
GROUP BY month(rojstni_dan)
HAVING COUNT(*)>= 7;
-- Izpišite vse pare oseb, ki so bili rojeni manj kot 15 dni narazen.
SELECT *
FROM rojstni_dnevi r1, rojstni_dnevi r2
WHERE abs(DATEDIFF(MAKEDATE(2023,dayofyear(r1.rojstni_dan)), MAKEDATE(2023, dayofyear(r2.rojstni_dan)))) < 15
AND r1.id  < r2.id;
-- Izpišite vse pare oseb, katerih rojstni dnevi se razlikujejo za manj kot 5 dni.
SELECT * 
FROM rojstni_dnevi r1, rojstni_dnevi r2
WHERE abs(DATEDIFF(MAKEDATE(2023,dayofyear(r1.rojstni_dan)), MAKEDATE(2023, dayofyear(r2.rojstni_dan)))) BETWEEN 0 AND 5 
AND r1.id  < r2.id;
-- Koliko dni ste stari vi?
SELECT abs(DATEDIFF("2005-5-14", CURDATE()));
-- Izpiši vse, ki so bili rojeni v petek trinajstega.
SELECT *
FROM rojstni_dnevi
WHERE DAY(rojstni_dan) = 13 AND DAYOFWEEK(rojstni_dan) = 6;#dayname(friday)