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
GROUP BY ime;
-- 5.	Kateri glasbenik je najstarejši? 2t
-- 6.	V katerem bandu je David Gilmour in kakšno vlogo ima? 2t
-- 7.	Izpišite število bandov po posameznih žanrih. 2t
-- 8.	Izpiši vse slovenske bobnarje. 2t