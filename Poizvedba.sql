DROP DATABASE maraton;
CREATE DATABASE maraton;
USE maraton;
CREATE TABLE tek 
(	mesto INT,
	stevilo INT,
	ime VARCHAR(50),
	država CHAR(3) DEFAULT "SLO",
	klub VARCHAR(59) DEFAULT Null,
	rezultat TIME
)default CHARSET = utf8;

LOAD DATA INFILE "C:\\Users\\Miha\\Desktop\\Neww.txt"
INTO TABLE tek
CHARacter SET UTF8
FIELDS TERMINATED BY "\t"
LINES TERMINATED BY "\r\n";

ALTER TABLE tek
ADD COLUMN slika BLOB;

ALTER TABLE tek
ADD COLUMN datum_rojstva DATE;

INSERT INTO tek 
VALUEs (51, 344, "Anže", "SLO", NULL, "02:11:22", NULL, "2005-05-14");

INSERT INTO tek (slika)
SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\\Users\\Miha\\Desktop\\prenos.jfif', Single_Blob) as img

DELETE FROM tek
WHERE mesto > 40;

SELECT *
from tek
INTO OUTFILE "C:\\Users\\Miha\\Desktop\\Izvoz2.txt"
CHARACTER SET UTF8
FIELDs TERMINATED BY "&%"
LINES TERMINATED BY "\n"


