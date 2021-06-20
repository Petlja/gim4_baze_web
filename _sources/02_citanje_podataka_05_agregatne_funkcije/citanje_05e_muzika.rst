Агрегатне функције и груписање -- музика
----------------------------------------


.. questionnote::

   Израчунати колико укупно гигабајта заузимају све композиције.

.. code-block:: sql

   SELECT SUM(Milliseconds) / (1024.0 * 1024.0 * 1024.0) AS GBTotal
   FROM track;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "GBTotal"

   "1.2840871140360832"

.. questionnote::

   Одредити колико милисекунди траје најкраћа, а колико најдужа композиција.

.. code-block:: sql

   SELECT Min(Milliseconds) AS Shortest, Max(Milliseconds) AS Longest
   FROM track;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Shortest", "Longest"

   "1071", "5286953"

.. questionnote::

   Одредити укупан број жанрова.

.. code-block:: sql

   SELECT COUNT(*)
   FROM genre;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "COUNT(*)"

   "25"

.. questionnote::

   Одредити број различитих албума који садрже песме.

.. code-block:: sql

   SELECT COUNT(DISTINCT AlbumId)
   FROM Track;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "COUNT(DISTINCT AlbumId)"

   "347"

.. questionnote::

   Одредити број албума у табели албума.

.. code-block:: sql

   SELECT COUNT(*)
   FROM Album;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "COUNT(*)"

   "347"

.. questionnote::

   Одредити број композиција сваког жанра.

.. code-block:: sql

   SELECT GenreId, COUNT(*)
   FROM track
   GROUP BY GenreId;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "GenreId", "COUNT(*)"

   "1", "1297"
   "2", "130"
   "3", "374"
   "4", "332"
   "5", "12"
   ..., ...

.. questionnote::

   Одредити укупну дужину свих песама на сваком албуму. Списак уредити
   по укупној дужини, од најкраћих, до најдужих албума.


.. code-block:: sql

   SELECT AlbumId, SUM(Milliseconds) AS TotalMs
   FROM track
   GROUP BY AlbumId
   ORDER BY TotalMs;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "AlbumId", "TotalMs"

   "340", "51780"
   "345", "66639"
   "318", "101293"
   "328", "110266"
   "315", "120000"
   ..., ...

.. questionnote::

   Одредити највећи број песама на некој листи.


.. code-block:: sql

   SELECT COUNT(*) AS Count
   FROM playlist_track
   GROUP BY PlaylistId
   ORDER BY Count DESC
   LIMIT 1;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Count"

   "3290"

