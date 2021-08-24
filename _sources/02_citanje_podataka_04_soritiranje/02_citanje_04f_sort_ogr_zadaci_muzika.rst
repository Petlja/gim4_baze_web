Сортирање и ограничавање - музика
---------------------------------

У наставку ћемо приказати неколико упита над базом продавнице музичких
композиција.

.. questionnote::

   Приказати податке о три композиције које заузимају највише бајтова.

.. code-block:: sql

   SELECT *
   FROM track
   ORDER BY Bytes DESC
   LIMIT 3;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "TrackId", "Name", "AlbumId", "MediaTypeId", "GenreId", "Milliseconds", "Bytes", "UnitPrice"
   :align: left

   "3224", "Through a Looking Glass", "229", "3", "21", "5088838", "1059546140", "1.99"
   "2820", "Occupation / Precipice", "227", "3", "19", "5286953", "1054423946", "1.99"
   "3236", "The Young Lords", "253", "3", "20", "2863571", "587051735", "1.99"

.. questionnote::

   Приказати податке о композицијама уређене по степену компресије
   (броју бајтова по једној секунди).

.. code-block:: sql

   SELECT *, Bytes / (Milliseconds / 1000) AS CompressionRatio
   FROM track
   ORDER BY CompressionRatio DESC
   LIMIT 3;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "TrackId", "Name", "AlbumId", "MediaTypeId", "GenreId", "Milliseconds", "Bytes", "UnitPrice", "CompressionRatio"
   :align: left

   "2844", "Better Halves", "228", "3", "21", "2573031", "549353481", "1.99", "213506"
   "3179", "Sexual Harassment", "250", "3", "19", "1294541", "273069146", "1.99", "211027"
   "2832", "The Woman King", "227", "3", "18", "2626376", "552893447", "1.99", "210545"

.. questionnote::

   Приказати све различите албуме тј. њихове идентификаторе на којима
   се јављају композиције дуже од 10 минута.

.. code-block:: sql

   SELECT DISTINCT AlbumId
   FROM track
   WHERE Milliseconds >= 10 * 60 * 1000;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "AlbumId"
   :align: left

   "16"
   "30"
   "31"
   "35"
   "43"
   ...


Вежба
.....
   
Покушајте да самостално напишете наредних неколико упита.

.. questionnote::

   Приказати списак назива свих албума сортирано по називима албума у
   абецедном реду.

.. dbpetlja:: db_sortiranje_zadaci_muzika_01
   :dbfile: music.sql
   :solutionquery: SELECT Title
                   FROM Album
                   ORDER BY Title
   

.. questionnote::

   Приказати податке о свим купцима из САД сортирано по називу града
   из којег долазе.

.. dbpetlja:: db_sortiranje_zadaci_muzika_02
   :dbfile: music.sql
   :solutionquery: SELECT *
                   FROM Customer
                   WHERE Country = 'USA'
                   ORDER BY City

                   
.. questionnote::

   Приказати имена, презимена и датуме рођења три најмлађа запослена у
   компанији.
   
.. dbpetlja:: db_sortiranje_zadaci_muzika_03
   :dbfile: music.sql
   :solutionquery: SELECT Name, BirthDate
                   FROM employee
                   ORDER BY BirthDate DESC
                   LIMIT 3

.. questionnote::

   Исписати ознаке различитих држава у САД из којих долазе купци.
   
.. dbpetlja:: db_sortiranje_zadaci_muzika_04
   :dbfile: music.sql
   :solutionquery: SELECT DISTINCT State
                   FROM Customer
                   WHERE Country = 'USA'
                   