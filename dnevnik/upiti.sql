-- Приказати све податке о ученицима.
SELECT * FROM ucenik;
-- Приказати све податке о ученицима који се зову Петар
SELECT * FROM ucenik WHERE ime = 'Петар';
-- Приказати све податке о ученицима који се зову Петар Петровић
SELECT * FROM ucenik WHERE ime = 'Петар' AND prezime = 'Петровић';
-- Приказати све податке о ученицима који се зову Петар или се презивају Петровић
SELECT * FROM ucenik WHERE ime = 'Петар' OR prezime = 'Петровић';
-- Приказати све податке о ученицима који се презивају Петровић, али се не зову Петар
SELECT * FROM ucenik WHERE (NOT ime = 'Петар') AND prezime = 'Петровић';
SELECT * FROM ucenik WHERE ime != 'Петар' AND prezime = 'Петровић';
-- Приказати све податке о ученицима чије презиме почиње на П
SELECT * FROM ucenik WHERE prezime LIKE 'П%';
-- Приказати све податке о учениицма који су рођени после првог јуна 2007
SELECT * FROM ucenik WHERE datum_rodjenja > '2007-06-01';
-- Приказати све податке о ученицима који су рођени током 2007 године
SELECT * FROM ucenik WHERE '2007-01-01' <= datum_rodjenja AND datum_rodjenja <= '2007-12-31';
SELECT * FROM ucenik WHERE datum_rodjenja BETWEEN '2007-01-01' AND '2007-12-31';
SELECT * FROM ucenik WHERE strftime('%Y', datum_rodjenja) = '2007';
-- Приказати имена и презимена свих ученика
SELECT ime, prezime FROM ucenik; 
-- Приказати имена и презимена ученика чије се презиме не завршава на ић
SELECT ime, prezime FROM ucenik WHERE NOT (prezime LIKE '%ић');
-- Приказати све податке о ученицима у азбучном редоследу презимена и имена
SELECT prezime, ime FROM ucenik ORDER BY prezime ASC, ime ASC;
-- Приказати број ученика у табели
SELECT COUNT(*) FROM ucenik;
-- Приказати све податке о предметима у другом разреду
SELECT * FROM predmet WHERE razred = 2;
-- Приказати све податке о предметима у прва два разреда
SELECT * FROM predmet WHERE razred <= 2;
-- Приказати укупан број предмета у првом разред
SELECT COUNT(*) FROM predmet WHERE razred = 1;
-- Приказати број предмета у сваком од разреда
SELECT razred, COUNT(*) as broj_predmeta FROM predmet GROUP BY razred;
-- Приказати просечну оцену из предмета са идентификатором 1
SELECT AVG(ocena) FROM ocena WHERE id_predmet=1;
-- Приказати најнижу оцену на писменом задатку из математике одржаном 18. маја 2021.
SELECT MIN(ocena) FROM ocena WHERE id_predmet=1 AND datum='2021-05-18' AND vrsta='писмени задатак';
-- Приказати датум када је у дневник уписана последња оцена из српског језика за први разред
SELECT MAX(datum) FROM ocena WHERE id_predmet=2;
-- Приказати све оцене у читљивом формату (тако да се виде име и презиме ученика и назив предмета)
SELECT p.naziv, u.ime, u.prezime, o.ocena, o.datum, o.vrsta FROM ocena o JOIN predmet p ON o.id_predmet = p.id JOIN ucenik u ON o.id_ucenik = u.id;
-- Приказати све податке о предмету са идентификатором 1 у читљивом формату
SELECT p.naziv, u.ime, u.prezime, o.ocena, o.datum, o.vrsta FROM ocena o JOIN predmet p ON o.id_predmet = p.id JOIN ucenik u ON o.id_ucenik = u.id WHERE p.id = 1;
-- Приказати све оцене на писменим задацима из предмета првог разреда у читљивом формату
SELECT p.naziv, u.ime, u.prezime, o.ocena, o.datum, o.vrsta FROM ocena o JOIN predmet p ON o.id_predmet = p.id JOIN ucenik u ON o.id_ucenik = u.id WHERE p.razred = 1 AND vrsta = 'писмени задатак';
-- Приказати просечне оцене из свих предмета (уређене опадајуће по просечној оецни)
SELECT naziv, AVG(ocena) AS prosek FROM ocena JOIN predmet on ocena.id_predmet = predmet.id GROUP BY predmet.id ORDER BY prosek DESC;
-- Приказати просечне оцене из свих предмета из првог разреда
SELECT naziv, AVG(ocena) AS prosek FROM ocena JOIN predmet on ocena.id_predmet = predmet.id WHERE razred = 1 GROUP BY predmet.id;
-- Приказати просечне оцене за све предмете код којих је просечна оцена бар 4.00
SELECT naziv, AVG(ocena) AS prosek FROM ocena JOIN predmet on ocena.id_predmet = predmet.id GROUP BY predmet.id HAVING prosek >= 4;
-- Приказати просечне оцене на писменим задацима за све предмете код којих је просечна оцена на писменим задацима бар 4.00
SELECT naziv, AVG(ocena) AS prosek FROM ocena JOIN predmet on ocena.id_predmet = predmet.id WHERE ocena.vrsta = 'писмени задатак' GROUP BY predmet.id HAVING prosek >= 4;
-- Приказати број оцена из сваког предмета
SELECT id_predmet, COUNT(*) FROM ocena GROUP BY id_predmet;
-- Приказати просечне оцене за оне предмете који имају бар 3 оцене
SELECT id_predmet, AVG(ocena) FROM ocena GROUP BY id_predmet HAVING COUNT(*) >= 3;
-- Приказати број предмета код којих је просечна оцена већа од 3.50
SELECT COUNT(*) FROM (SELECT id_predmet FROM OCENA GROUP BY id_predmet HAVING AVG(ocena) >= 3.5);
-- Приказати укупан број изостанака за свако одељење
SELECT razred, odeljenje, COUNT(*) FROM ucenik JOIN izostanak on ucenik.id = izostanak.id_ucenik GROUP BY razred, odeljenje;
-- Приказати укупан број неоправданих изостанака за сваки разред
SELECT razred, COUNT(*) FROM ucenik JOIN izostanak on ucenik.id = izostanak.id_ucenik WHERE status = 'неоправдан' GROUP BY razred;
-- Приказати имена ученика који имају неоправдане изостанке
SELECT id, ime, prezime FROM ucenik WHERE EXISTS (SELECT * FROM izostanak WHERE izostanak.id_ucenik = ucenik.id AND status = 'неоправдан');
SELECT id, ime, prezime FROM ucenik JOIN izostanak on izostanak.id_ucenik = ucenik.id WHERE status = 'неоправдан' GROUP BY ucenik.id;
-- Приказати имена ученика који немају нерегулисаних изостанака
SELECT id, ime, prezime FROM ucenik WHERE NOT EXISTS (SELECT * FROM izostanak WHERE izostanak.id_ucenik = ucenik.id AND status = 'нерегулисан');
-- Приказати највећи број остварених оправданих изостанака
SELECT MAX(broj) FROM (SELECT COUNT(*) AS broj FROM izostanak WHERE status = 'оправдан' GROUP BY id_ucenik);
-- За свако одељење приказати највећи број оправданих изостанака
SELECT razred, odeljenje, MAX(broj_opravdanih) FROM (SELECT ucenik.id, razred, odeljenje, COUNT(*) as broj_opravdanih FROM izostanak JOIN ucenik on izostanak.id_ucenik = ucenik.id WHERE status = 'оправдан' GROUP BY ucenik.id) GROUP BY razred, odeljenje
