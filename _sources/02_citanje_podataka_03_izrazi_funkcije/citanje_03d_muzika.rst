Изрази и функције - задаци (музика)
-----------------------------------

.. questionnote::

   Приказати називе свих песама које трају више од 4 и по минута.
   
.. code-block:: sql

   SELECT name
   FROM track
   WHERE Milliseconds > 4.5 * 60 * 1000;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name"
   :align: left

   "For Those About To Rock (We Salute You)"
   "Balls to the Wall"
   "Princess of the Dawn"
   "Spellbound"
   "Go Down"
   ...

.. questionnote::

   Приказати називе свих песама и њихову величину у мегабајтима
   заокружену на две децимале.

.. code-block:: sql

   SELECT name, round(Bytes / (1024 * 1024), 2) AS Mb
   FROM track;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "Mb"
   :align: left

   "For Those About To Rock (We Salute You)", "10.0"
   "Balls to the Wall", "5.0"
   "Fast As a Shark", "3.0"
   "Restless and Wild", "4.0"
   "Princess of the Dawn", "5.0"
   ..., ...

.. questionnote::

   Приказати називе свих композиција, њихово трајање у секундама и
   ознаке да дужине. Кратке (short) су оне које су краће од три
   минута, средње (medium) су оне између 3 и 6 минута, а дуге (long)
   оне које су дуже од 6 минута).

   
.. code-block:: sql

   SELECT Name, round(Milliseconds / 1000) AS Seconds,
          CASE
             WHEN Milliseconds < 3 * 60 * 1000 THEN 'short'
             WHEN Milliseconds < 6 * 60 * 1000 THEN 'medium'
             ELSE 'long'
          END AS Length
   FROM track;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "Seconds", "Length"
   :align: left

   "For Those About To Rock (We Salute You)", "343.0", "medium"
   "Balls to the Wall", "342.0", "medium"
   "Fast As a Shark", "230.0", "medium"
   "Restless and Wild", "252.0", "medium"
   "Princess of the Dawn", "375.0", "long"
   ..., ..., ...

.. questionnote::

   За сваку песму приказати идентификатор, назив и трајање у минутама
   и секундама.
   
.. code-block:: sql

   SELECT TrackId, Name,
          CAST (round(Milliseconds / 1000) AS INTEGER) / 60 AS Minutes,
          CAST (round(Milliseconds / 1000) AS INTEGER) % 60 AS Seconds
   FROM track;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "TrackId", "Name", "Minutes", "Seconds"
   :align: left

   "1", "For Those About To Rock (We Salute You)", "5", "43"
   "2", "Balls to the Wall", "5", "42"
   "3", "Fast As a Shark", "3", "50"
   "4", "Restless and Wild", "4", "12"
   "5", "Princess of the Dawn", "6", "15"
   ..., ..., ..., ...

