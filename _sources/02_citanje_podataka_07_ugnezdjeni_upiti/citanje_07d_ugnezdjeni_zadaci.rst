.. -*- mode: rst -*-

Угнежђени упити -- задаци (дневник)
...................................

1. Рођендански парадокс нам говори да је у одељењу од 23 ученика
вероватноћа да два ученика имају исти датум рођења преко 50%. Исписати
она одељења у којима постоји више ученика који су рођени у истом дану,
као и највећи број ученика који су рођени у једном дану.

.. code-block:: sql

   SELECT razred, odeljenje, MAX(broj) AS max_broj 
   FROM (SELECT razred, odeljenje, datum_rodjenja, COUNT(datum_rodjenja) AS broj
         FROM ucenik
         GROUP BY datum_rodjenja, razred, odeljenje)
   GROUP BY razred, odeljenje
   HAVING max_broj > 1
   ORDER BY razred, odeljenje;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "razred", "odeljenje", "max_broj"
   :align: left

   "1", "1", "2"
   "1", "2", "3"
   "2", "1", "2"
   "2", "2", "2"
   "2", "3", "2"
   ..., ..., ...

2. Приказати број оцена из математике свих ученика.

.. code-block:: sql
                
   SELECT u.id, u.ime, u.prezime, COUNT(*) AS broj_ocena_iz_matematike
   FROM ucenik u
        JOIN ocena o ON u.id = o.id_ucenik
   WHERE o.id_predmet IN (SELECT id FROM predmet WHERE naziv = 'Математика')
   GROUP BY u.id;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "id", "ime", "prezime", "broj_ocena_iz_matematike"
   :align: left

   "1", "Петар", "Петровић", "2"
   "2", "Милица", "Јовановић", "2"
   "3", "Лидија", "Петровић", "2"
   "6", "Јован", "Миленковић", "2"
   "7", "Јована", "Миленковић", "2"
   ..., ..., ..., ...

3. Приказати податке о ученицима који би по тренутним оценама имали
   закључену петицу из српског језика.

.. code-block:: sql
   
   SELECT u.id, u.ime, u.prezime, u.razred, u.odeljenje
   FROM ocena o JOIN
        ucenik u ON o.id_ucenik = u.id
   WHERE id_predmet IN (SELECT id
                        FROM predmet
                        WHERE naziv = 'Српски језик')
   GROUP BY u.id
   HAVING AVG(ocena) >= 4.5
   ORDER BY razred, odeljenje;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "id", "ime", "prezime", "razred", "odeljenje"
   :align: left

   "1", "Петар", "Петровић", "1", "1"
   "21", "Анђелија", "Богдановић", "1", "1"
   "24", "Ивана", "Пејчев", "1", "1"
   "31", "Милутин", "Травица", "1", "1"
   "7", "Јована", "Миленковић", "1", "2"
   ..., ..., ..., ..., ...

4. Приказати број изостанака свих ученика који би по тренутним оценама
   имали закључену петицу из математике.

.. code-block:: sql
   
   SELECT u.id, u.ime, u.prezime, COUNT(*) AS broj_izostanaka
   FROM izostanak i JOIN 
        ucenik u ON i.id_ucenik = u.id
   WHERE u.id IN (SELECT id_ucenik
                  FROM ocena
                  WHERE id_predmet IN (SELECT id
                                       FROM predmet
                                       WHERE naziv = 'Математика')
                  GROUP BY id_ucenik
                  HAVING AVG(ocena) >= 4.5)
   GROUP BY u.id;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "id", "ime", "prezime", "broj_izostanaka"
   :align: left

   "13", "Дуња", "Травица", "1"

