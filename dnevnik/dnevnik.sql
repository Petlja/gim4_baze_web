--
-- File generated with SQLiteStudio v3.3.3 on Wed Jun 2 19:54:46 2021
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: izostanak
CREATE TABLE izostanak (id INTEGER PRIMARY KEY AUTOINCREMENT, id_ucenik REFERENCES ucenik (id) ON DELETE RESTRICT ON UPDATE RESTRICT, datum DATE, cas INT, status VARCHAR (15), UNIQUE (id_ucenik, datum, cas));
INSERT INTO izostanak (id, id_ucenik, datum, cas, status) VALUES (1, 1, '2021-05-14', 1, 'оправдан');
INSERT INTO izostanak (id, id_ucenik, datum, cas, status) VALUES (2, 1, '2021-05-14', 2, 'неоправдан');
INSERT INTO izostanak (id, id_ucenik, datum, cas, status) VALUES (3, 4, '2021-05-14', 1, 'нерегулисан');
INSERT INTO izostanak (id, id_ucenik, datum, cas, status) VALUES (4, 4, '2021-05-14', 2, 'нерегулисан');
INSERT INTO izostanak (id, id_ucenik, datum, cas, status) VALUES (5, 6, '2021-06-01', 1, 'неоправдан');
INSERT INTO izostanak (id, id_ucenik, datum, cas, status) VALUES (6, 1, '2021-05-14', 3, 'оправдан');
INSERT INTO izostanak (id, id_ucenik, datum, cas, status) VALUES (7, 8, '2021-06-01', 1, 'оправдан');
INSERT INTO izostanak (id, id_ucenik, datum, cas, status) VALUES (8, 8, '2021-06-01', 2, 'нерегулисан');

-- Table: ocena
CREATE TABLE ocena (id INTEGER PRIMARY KEY AUTOINCREMENT, id_predmet INTEGER REFERENCES predmet (id) ON DELETE RESTRICT ON UPDATE RESTRICT, id_ucenik INTEGER REFERENCES ucenik (id) ON DELETE RESTRICT ON UPDATE RESTRICT, ocena INT, datum DATE DEFAULT (date('now')) NOT NULL, vrsta VARCHAR (20));
INSERT INTO ocena (id, id_predmet, id_ucenik, ocena, datum, vrsta) VALUES (1, 1, 1, 5, '2021-05-18', 'писмени задатак');
INSERT INTO ocena (id, id_predmet, id_ucenik, ocena, datum, vrsta) VALUES (2, 1, 2, 4, '2021-05-18', 'писмени задатак');
INSERT INTO ocena (id, id_predmet, id_ucenik, ocena, datum, vrsta) VALUES (3, 1, 3, 2, '2021-05-18', 'писмени задатак');
INSERT INTO ocena (id, id_predmet, id_ucenik, ocena, datum, vrsta) VALUES (4, 6, 1, 5, '2021-05-23', 'контролна вежба');
INSERT INTO ocena (id, id_predmet, id_ucenik, ocena, datum, vrsta) VALUES (5, 6, 2, 3, '2021-05-23', 'контролна вебжа');
INSERT INTO ocena (id, id_predmet, id_ucenik, ocena, datum, vrsta) VALUES (6, 6, 3, 1, '2021-05-23', 'контролна вежба');
INSERT INTO ocena (id, id_predmet, id_ucenik, ocena, datum, vrsta) VALUES (7, 1, 6, 3, '2021-05-18', 'писмени задатак');
INSERT INTO ocena (id, id_predmet, id_ucenik, ocena, datum, vrsta) VALUES (8, 1, 7, 4, '2021-05-18', 'писмени задатак');
INSERT INTO ocena (id, id_predmet, id_ucenik, ocena, datum, vrsta) VALUES (9, 3, 3, 5, '2021-05-22', 'пројекат');
INSERT INTO ocena (id, id_predmet, id_ucenik, ocena, datum, vrsta) VALUES (10, 3, 2, 4, '2021-05-24', 'пројекат');

-- Table: predmet
CREATE TABLE predmet (id INTEGER PRIMARY KEY AUTOINCREMENT, naziv VARCHAR (30), razred INT);
INSERT INTO predmet (id, naziv, razred) VALUES (1, 'Математика', 1);
INSERT INTO predmet (id, naziv, razred) VALUES (2, 'Српски језик', 1);
INSERT INTO predmet (id, naziv, razred) VALUES (3, 'Рачунарство и информатика', 1);
INSERT INTO predmet (id, naziv, razred) VALUES (4, 'Математика', 2);
INSERT INTO predmet (id, naziv, razred) VALUES (5, 'Психологија', 2);
INSERT INTO predmet (id, naziv, razred) VALUES (6, 'Физика', 1);
INSERT INTO predmet (id, naziv, razred) VALUES (7, 'Физика', 2);

-- Table: ucenik
CREATE TABLE ucenik (id INTEGER PRIMARY KEY AUTOINCREMENT, ime VARCHAR (50), prezime VARCHAR (50), datum_rodjenja DATE, razred INT, odeljenje INT);
INSERT INTO ucenik (id, ime, prezime, datum_rodjenja, razred, odeljenje) VALUES (1, 'Петар', 'Петровић', '2007-07-01', 1, 1);
INSERT INTO ucenik (id, ime, prezime, datum_rodjenja, razred, odeljenje) VALUES (2, 'Милица', 'Јовановић', '2007-04-03', 1, 1);
INSERT INTO ucenik (id, ime, prezime, datum_rodjenja, razred, odeljenje) VALUES (3, 'Лидија', 'Петровић', '2007-12-14', 1, 1);
INSERT INTO ucenik (id, ime, prezime, datum_rodjenja, razred, odeljenje) VALUES (4, 'Петар', 'Миловановић', '2006-12-08', 2, 1);
INSERT INTO ucenik (id, ime, prezime, datum_rodjenja, razred, odeljenje) VALUES (5, 'Ана', 'Пекић', '2007-02-23', 2, 1);
INSERT INTO ucenik (id, ime, prezime, datum_rodjenja, razred, odeljenje) VALUES (6, 'Јован', 'Миленковић', '2007-04-07', 1, 2);
INSERT INTO ucenik (id, ime, prezime, datum_rodjenja, razred, odeljenje) VALUES (7, 'Јована', 'Миленковић', '2007-04-07', 1, 2);
INSERT INTO ucenik (id, ime, prezime, datum_rodjenja, razred, odeljenje) VALUES (8, 'Гордана', 'Сарић', '2008-01-03', 2, 1);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
