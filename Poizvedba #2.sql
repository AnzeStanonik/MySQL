DROP DATABASE atp;
CREATE DATABASE atp;
USE atp;
CREATE TABLE atp(
RANK INT,
country CHAR(3),
player VARCHAR(59),
age INT,
tourn_played INT,
points INT ) DEFAULT CHARSET = UTF8;

LOAD DATA INFILE "C:\\Users\\Miha\\Downloads\\Zvezek1.csv"
INTO TABLE atp
CHARACTER SET UTF8
FIELDS TERMINATED BY ";"
LINES TERMINATED BY "\r\n"
IGNORE 1 LINES;

SELECT *
from atp
INTO OUTFILE "atp.txt";

SELECT *
FROM atp
INTO OUTFILE "C:\\Users\\Miha\\Downloads\\atp.txt"
CHARACTER SET UTF8
FIELDS TERMINATED BY "|"
LINES TERMINATED BY "%";

USE atp;
CREATE TABLE osebe (
ID_osebe INT PRIMARY KEY,
ime VARCHAR(59),
priimek VARCHAR (59) ) DEFAULT CHARSET = UTF8;

USE atp;
CREATE TABLE delovni_nalog(
ID_oddelka INT,
ID_naloga INT,
PRIMARY KEY (ID_oddelka,ID_naloga)) DEFAULT CHARSET = UTF8;

USE atp;
CREATE TABLE naročilo(
ID_naročila INT PRIMARY KEY,
ID_osebe INT,
foreign KEY (ID_osebe)
REFERENCES osebe(ID_osebe),
izdelek VARCHAR(89),
kolicina int) DEFAULT CHARSET = UTF8;

INSERT INTO osebe
VALUES(1, "Anže", "Stanonik");

INSERT INTO naročilo
VALUES(1,1,"Tipkovnica",1);

-- DELETE FROM osebe
-- WHERE ime = "Anže";

-- INSERT INTO naročilo
-- VALUES(2,2,"Miška",1);
