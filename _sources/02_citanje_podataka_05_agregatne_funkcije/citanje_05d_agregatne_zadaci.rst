.. -*- mode: rst -*-

Агрегатне функције и груписање -- задаци за вежбу
-------------------------------------------------

1. Под претпоставком да постоји 37 радних недеља, прикажи укупан
   годишњи фонд часова за све предмете из другог разреда.

.. code-block:: sql

   SELECT SUM(37 * fond) AS ukupan_godisnji_fond
   FROM predmet
   WHERE razred = 2;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "ukupan_godisnji_fond"

   370

2. Прикажи име и презиме ученика у одељењу IV1 који је први у дневнику
   (ученици се сортирају по азбучном редоследу).

.. code-block:: sql

   SELECT MIN((prezime || ' ' || ime) COLLATE UNICODE) AS prvi_u_dnevniku
   FROM ucenik
   WHERE razred = 4 AND odeljenje = 1;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "prvi_u_dnevniku"

   Васиљевић Дејан

3. Приказати просечну оцену, заокружену на две децимале, на писменом
   задатку из математике одржаном 15. октобра 2020. (та математика има
   идентификатор 1).

.. code-block:: sql

   SELECT round(AVG(ocena), 2) AS prosek
   FROM ocena
   WHERE id_predmet = 1 AND datum = '2020-10-15' AND vrsta = 'писмени задатак';

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "prosek"

   3.14

4. Приказати укупан број оправданих изостанака које је направио ученик
   са идентификатором 1.

.. code-block:: sql
                
   SELECT COUNT(*) AS broj_izostanaka
   FROM izostanak
   WHERE id_ucenik = 1 AND status = 'оправдан';

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "broj_izostanaka"

   2

5. За сваки датум одреди укупан број направљених изостанака.

.. code-block:: sql
                
   SELECT datum, COUNT(*) AS broj_izostanaka
   FROM izostanak
   GROUP BY datum;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "datum", "broj_izostanaka"

   2021-03-01, 2
   2021-03-02, 2
   2021-03-10, 1
   2021-03-15, 1
   2021-05-14, 5
   ..., ...

6. За сваки статус изостанака (оправдани, неоправдани, нерегулисани)
   одредити број изостанака у мају 2021. године.

.. code-block:: sql

   SELECT status, COUNT(*) AS broj
   FROM izostanak
   WHERE datum BETWEEN '2021-05-01' AND '2021-05-31'
   GROUP BY status;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "status", "broj"

   неоправдан, 1
   нерегулисан, 2
   оправдан, 2


7. За сваки статус изостанака одреди први и последњи датум када је
   изостанак направљен.

.. code-block:: sql

   SELECT status, MIN(datum) AS prvi, MAX(datum) AS poslednji
   FROM izostanak
   GROUP BY status;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "status", "prvi", "poslednji"

   неоправдан, 2021-03-01, 2021-06-01
   нерегулисан, 2021-05-14, 2021-06-01
   оправдан, 2021-03-02, 2021-06-01

8. За сваки месец приказати број ученика рођених у том месецу.

.. code-block:: sql

   SELECT strftime('%m', datum_rodjenja) AS mesec, COUNT(*) AS broj
   FROM ucenik
   GROUP BY mesec;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "mesec", "broj"

   01, 37
   02, 33
   03, 30
   04, 28
   05, 36
   ..., ...

9. За сваки месец у години приказати број јединица које су ученици
   добили током тог месеца.

.. code-block:: sql

   SELECT strftime('%m', datum) AS mesec, COUNT(*) AS broj
   FROM ocena
   WHERE ocena = 1
   GROUP BY mesec;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "mesec", "broj"

   10, 17
   11, 17

   
10. Прикажи датуме са мање од 10 направљених неоправданих изостанака.

.. code-block:: sql

   SELECT datum, COUNT(*) AS broj
   FROM izostanak
   GROUP BY datum
   HAVING broj < 10;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "datum", "broj"

   2021-03-01, 2
   2021-03-02, 2
   2021-03-10, 1
   2021-03-15, 1
   2021-05-14, 5
   ..., ...


11. За сваку контролну вежбу и за сваки писмени задатак који је у
    једном дану радило више од 15 ученика прикажи укупан број и просек
    оцена.

.. code-block:: sql

   SELECT id_predmet, vrsta, datum, COUNT(*) AS broj, round(AVG(ocena), 2) AS prosek
   FROM ocena
   WHERE vrsta in ('контролна вежба', 'писмени задатак')
   GROUP BY id_predmet, vrsta, datum
   HAVING broj >= 15;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "id_predmet", "vrsta", "datum", "broj", "prosek"

   1, контролна вежба, 2020-11-22, 57, 3.05
   1, контролна вежба, 2020-11-23, 33, 3.21
   1, писмени задатак, 2020-10-15, 59, 3.14
   1, писмени задатак, 2020-10-16, 29, 2.97
   2, контролна вежба, 2020-11-23, 90, 3.5
   ..., ..., ..., ..., ...

12. За свако женско име које носи више ученица приказати број ученица
    које носе то име (резултат сортирати опадајуће по броју ученица).

    
.. code-block:: sql

   SELECT ime, COUNT(*) AS broj
   FROM ucenik
   WHERE pol = 'ж'
   GROUP BY ime
   HAVING broj >= 2
   ORDER BY broj DESC;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "ime", "broj"

   Милица, 5
   Весна, 5
   Маша, 4
   Магдалена, 4
   Лидија, 4
   ..., ...


13. Приказати нека три најчешћа презимена.
    
.. code-block:: sql

   SELECT prezime, COUNT(*) AS broj_ucenika
   FROM ucenik
   GROUP BY prezime
   ORDER BY broj_ucenika DESC
   LIMIT 3;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "prezime", "broj_ucenika"

   Милић, 8
   Цветковић, 7
   Ристић, 7

