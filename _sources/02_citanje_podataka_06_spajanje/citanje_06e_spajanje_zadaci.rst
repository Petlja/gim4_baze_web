.. -*- mode: rst -*-

Спајање --- задаци (дневник)
............................

1. Приказати све регулисане изостанке у читљивом формату (у ком се
   види и име и презиме ученика).

.. code-block:: sql

   SELECT u.ime, u.prezime, i.datum, i.cas, i.status
   FROM izostanak i
        JOIN ucenik u ON i.id_ucenik = u.id
   WHERE i.status != 'нерегулисан';

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "ime", "prezime", "datum", "cas", "status"
   :align: left

   "Петар", "Петровић", "2021-05-14", "1", "оправдан"
   "Петар", "Петровић", "2021-05-14", "2", "неоправдан"
   "Јован", "Миленковић", "2021-06-01", "1", "неоправдан"
   "Петар", "Петровић", "2021-05-14", "3", "оправдан"
   "Гордана", "Сарић", "2021-06-01", "1", "оправдан"
   ..., ..., ..., ..., ...

2. За сваког ученика приказати списак предмета које похађа.

.. code-block:: sql

   SELECT u.ime, u.prezime, u.razred, u.odeljenje, p.naziv
   FROM ucenik u JOIN
        predmet p ON u.razred = p.razred;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "ime", "prezime", "razred", "odeljenje", "naziv"
   :align: left

   "Петар", "Петровић", "1", "1", "Математика"
   "Петар", "Петровић", "1", "1", "Рачунарство и информатика"
   "Петар", "Петровић", "1", "1", "Српски језик"
   "Петар", "Петровић", "1", "1", "Физика"
   "Милица", "Јовановић", "1", "1", "Математика"
   ..., ..., ..., ..., ...

3. Приказати у читљивом формату све оцене на контролним вежбама
   ученика одељења I2.

.. code-block:: sql

   SELECT u.ime, u.prezime, p.naziv, o.datum, o.ocena
   FROM ocena o
        JOIN ucenik u ON o.id_ucenik = u.id
        JOIN predmet p ON o.id_predmet = p.id
   WHERE u.razred = 1 AND u.odeljenje = 2 AND o.vrsta = 'контролна вежба';

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "ime", "prezime", "naziv", "datum", "ocena"
   :align: left

   "Јован", "Миленковић", "Математика", "2020-11-23", "2"
   "Јована", "Миленковић", "Математика", "2020-11-23", "5"
   "Ана", "Анђелковић", "Математика", "2020-11-23", "3"
   "Ксенија", "Ђукић", "Математика", "2020-11-23", "1"
   "Анабела", "Лазаревић", "Математика", "2020-11-23", "4"
   ..., ..., ..., ..., ...

4. Приказати просечну оцену на сваком писменом задатку у сваком
   одељењу (рачунати само писмене задатке које је истовремено радило
   бар 25 ученика).

.. code-block:: sql

   SELECT u.razred, u.odeljenje, p.naziv, o.datum, round(AVG(o.ocena), 2) AS prosek, COUNT(*) as broj
   FROM ocena o JOIN
        predmet p ON o.id_predmet = p.id JOIN
        ucenik u ON o.id_ucenik = u.id
   WHERE o.vrsta = 'писмени задатак'
   GROUP BY u.razred, u.odeljenje, p.id, o.datum
   HAVING broj >= 25;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "razred", "odeljenje", "naziv", "datum", "prosek", "broj"
   :align: left

   "1", "1", "Математика", "2020-10-15", "2.85", "26"
   "1", "1", "Српски језик", "2020-12-03", "4.14", "28"
   "1", "2", "Математика", "2020-10-15", "3.36", "33"
   "1", "2", "Српски језик", "2020-12-03", "3.97", "33"
   "1", "3", "Математика", "2020-10-16", "2.97", "29"
   ..., ..., ..., ..., ..., ...

5. За сваки предмет приказати месечни преглед броја петица (списак
   уредити по предметима у азбучном редоследу, а за сваки предмет, по
   месецима, растуће).

.. code-block:: sql

   SELECT p.naziv, p.razred, strftime('%m', o.datum) AS mesec, COUNT(*) AS broj
   FROM ocena o JOIN
        predmet p ON o.id_predmet = p.id
   WHERE o.ocena = 5
   GROUP BY p.id, mesec
   ORDER BY p.naziv, mesec;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "naziv", "razred", "mesec", "broj"
   :align: left

   "Математика", "1", "10", "19"
   "Математика", "4", "10", "1"
   "Математика", "1", "11", "24"
   "Рачунарство и информатика", "1", "11", "21"
   "Српски језик", "1", "11", "25"
   ..., ..., ..., ...


6. За свако одељење приказати укупан број неоправданих изостанака.

.. code-block:: sql

   SELECT razred, odeljenje, COUNT(*) AS broj
   FROM izostanak i JOIN
        ucenik u ON i.id_ucenik = u.id
   WHERE status = 'неоправдан'
   GROUP BY razred, odeljenje;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "razred", "odeljenje", "broj"
   :align: left

   "1", "1", "1"
   "1", "2", "1"
   "2", "1", "5"

7. Ситуација је алармантна када ученици неког одељења у неком месецу
   направе 5 или више неоправданих изостанака. Приказати све такве
   случајеве.

.. code-block:: sql

   SELECT razred, odeljenje, strftime('%m', datum) AS mesec, COUNT(*) AS broj
   FROM izostanak i JOIN
        ucenik u ON i.id_ucenik = u.id
   WHERE status = 'неоправдан'
   GROUP BY mesec, razred, odeljenje
   HAVING broj >= 5;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "razred", "odeljenje", "mesec", "broj"
   :align: left

   "2", "1", "03", "5"

8. За сваког ученика приказати просечну оцену из сваког предмета за
   који је добио бар две оцене (приказати имена и презимена ученика и
   називе предмета).
   
.. code-block:: sql

   SELECT u.ime, u.prezime, p.naziv, round(AVG(ocena), 2) AS prosek
   FROM ocena o JOIN
        ucenik u ON o.id_ucenik = u.id JOIN
        predmet p ON o.id_predmet = p.id
   GROUP BY u.id, p.id
   HAVING COUNT(*) >= 2;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "ime", "prezime", "naziv", "prosek"
   :align: left

   "Петар", "Петровић", "Математика", "2.5"
   "Петар", "Петровић", "Српски језик", "4.5"
   "Милица", "Јовановић", "Математика", "4.0"
   "Милица", "Јовановић", "Српски језик", "4.0"
   "Лидија", "Петровић", "Математика", "3.5"
   ..., ..., ..., ...

9. Рођендански парадокс нам говори да је у одељењу од 23 ученика
   вероватноћа да два ученика имају исти датум рођења скоро 50%. Зато
   се може очекивати да у већини одељења постоји бар два ученика
   рођених истог датума. Исписати све парове ученика из истог одељења
   рођених истог дана.

.. code-block:: sql
                
   SELECT u1.datum_rodjenja, u1.razred, u1.odeljenje,
          u1.id, u1.ime, u1.prezime,
          u2.id, u2.ime, u2.prezime
   FROM ucenik AS u1 JOIN 
        ucenik AS u2 ON 
           u1.razred = u2.razred AND u1.odeljenje = u2.odeljenje AND
           u1.datum_rodjenja = u2.datum_rodjenja AND u1.id < u2.id
   ORDER BY u1.razred, u1.odeljenje;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "datum_rodjenja", "razred", "odeljenje", "id", "ime", "prezime", "id", "ime", "prezime"
   :align: left

   "2006-12-14", "1", "1", "3", "Лидија", "Петровић", "35", "Павле", "Радивојевић"
   "2007-01-16", "1", "1", "15", "Елена", "Ђурђевић", "21", "Анђелија", "Богдановић"
   "2006-04-07", "1", "2", "6", "Јован", "Миленковић", "7", "Јована", "Миленковић"
   "2006-04-07", "1", "2", "6", "Јован", "Миленковић", "63", "Матеј", "Стевановић"
   "2006-04-07", "1", "2", "7", "Јована", "Миленковић", "63", "Матеј", "Стевановић"
   ..., ..., ..., ..., ..., ..., ..., ..., ...


10. Приказати број оцена из сваког предмета, укључујући и оне предмете
    из којих не постоји ни једна оцена. Резултат сортирати опадајуће
    по броју оцена.

.. code-block:: sql

   SELECT naziv, razred, COUNT(ocena) AS broj_ocena
   FROM predmet LEFT JOIN
        ocena ON predmet.id = ocena.id_predmet
   GROUP BY predmet.id
   ORDER BY broj_ocena DESC;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "naziv", "razred", "broj_ocena"
   :align: left

   "Српски језик", "1", "180"
   "Математика", "1", "178"
   "Рачунарство и информатика", "1", "88"
   "Математика", "4", "1"
   "Математика", "2", "0"
   ..., ..., ...

