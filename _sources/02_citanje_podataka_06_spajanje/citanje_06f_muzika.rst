.. -*- mode: rst -*-

Спајање --- музика
..................

.. questionnote::

   Прикажи називе свих песама и њихове жанрове.


.. code-block:: sql

   SELECT track.Name, genre.Name
   FROM track JOIN
        genre ON track.GenreId = genre.GenreID;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "Name"

   "For Those About To Rock (We Salute You)", "Rock"
   "Balls to the Wall", "Rock"
   "Fast As a Shark", "Rock"
   "Restless and Wild", "Rock"
   "Princess of the Dawn", "Rock"
   ..., ...

.. questionnote::

   Прикажи називе свих џез композиција (жанр је ``Jazz``).


.. code-block:: sql

   SELECT track.Name
   FROM track JOIN
        genre ON track.GenreId = genre.GenreID
   WHERE genre.Name = 'Jazz';

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name"

   "Desafinado"
   "Garota De Ipanema"
   "Samba De Uma Nota Só (One Note Samba)"
   "Por Causa De Você"
   "Ligia"
   ...


.. questionnote::

   Приказати списак композиција који садржи назив извођача и назив композиције.
   
.. code-block:: sql

   SELECT artist.Name, track.Name
   FROM track JOIN
        album ON track.AlbumId = album.AlbumId JOIN
        artist ON artist.ArtistId = album.ArtistId;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "Name"

   "AC/DC", "For Those About To Rock (We Salute You)"
   "Accept", "Balls to the Wall"
   "Accept", "Fast As a Shark"
   "Accept", "Restless and Wild"
   "Accept", "Princess of the Dawn"
   ..., ...

.. questionnote::
   
   За сваког извођача приказати укупнан број снимљених минута,
   заокружен на две децимале.

.. code-block:: sql

   SELECT artist.Name, round(SUM(track.Milliseconds) / (1000.0 * 60.0), 2) AS Minutes
   FROM track JOIN
        album ON track.AlbumId = album.AlbumId JOIN
        artist ON artist.ArtistId = album.ArtistId
   GROUP BY artist.ArtistId;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "Minutes"

   "AC/DC", "80.89"
   "Accept", "20.01"
   "Aerosmith", "73.53"
   "Alanis Morissette", "57.52"
   "Alice In Chains", "54.16"
   ..., ...


.. questionnote::

   Прикажи називе свих поп композиција (жанр је ``Pop``) које су
   снимљене у формату (``AAC``).

.. code-block:: sql

   SELECT track.Name
   FROM track JOIN
        genre ON track.GenreId = genre.GenreId JOIN
        media_type ON track.MediaTypeId = media_type.MediaTypeId
   WHERE genre.Name = 'Pop' AND media_type.Name LIKE '%AAC%';

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name"

   "Instant Karma"
   "#9 Dream"
   "Mother"
   "Give Peace a Chance"
   "Cold Turkey"
   ...

.. questionnote::

   За сваког извођача приказати број композиција снимљених у MPEG
   формату. Занемарити оне извођаче који имају мање од 5 таквих
   композиција.

.. code-block:: sql
                
   SELECT artist.Name, COUNT(*) AS Num
   FROM track JOIN
        album ON track.AlbumId = album.AlbumId JOIN
        artist ON artist.ArtistId = album.ArtistId JOIN
        media_type ON track.MediaTypeId = media_type.MediaTypeId
   WHERE media_type.Name LIKE '%MPEG%'
   GROUP BY artist.ArtistId
   HAVING Num >= 5;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "Num"

   "AC/DC", "18"
   "Aerosmith", "15"
   "Alanis Morissette", "13"
   "Alice In Chains", "12"
   "Antônio Carlos Jobim", "31"
   ..., ...

   
.. questionnote::

   Прикажи називе свих песама групе Queen.
   
.. code-block:: sql

   SELECT track.Name
   FROM track JOIN
        album ON track.AlbumId = album.AlbumId JOIN
        artist ON artist.ArtistId = album.ArtistId
   WHERE artist.Name = 'Queen';

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name"

   "A Kind Of Magic"
   "Under Pressure"
   "Radio GA GA"
   "I Want It All"
   "I Want To Break Free"
   ...

.. questionnote::

   За сваки жанр приказати назив жанра и просечно трајање композиције
   у секундама (уредити опадајуће по трајању).

   
.. code-block:: sql

   SELECT genre.Name, round(AVG(Milliseconds / 1000)) AS AverageMilliseconds
   FROM track JOIN
        genre ON track.GenreId = genre.GenreId
   GROUP BY genre.GenreId
   ORDER BY AverageMilliseconds DESC;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "AverageMilliseconds"

   "Sci Fi & Fantasy", "2911.0"
   "Science Fiction", "2625.0"
   "Drama", "2575.0"
   "TV Shows", "2145.0"
   "Comedy", "1585.0"
   ..., ...

.. questionnote::

   Приказати укупну дужину свих композиција групе ``Metallica``.

.. code-block:: sql

   SELECT SUM(Milliseconds) AS MetallicaMs
   FROM track JOIN
        album ON track.AlbumId = album.AlbumId JOIN
        artist ON artist.ArtistId = album.ArtistId
   WHERE artist.Name = 'Metallica';

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "MetallicaMs"

   "38916130"

.. questionnote::

   Приказати извођаче којима је просечна дужина трајања композиције
   између 3 и 4 минута.

.. code-block:: sql

   SELECT artist.Name, round(AVG(Milliseconds / (1000.0 * 60.0)), 2) AS AverageMinutes
   FROM track JOIN
        album ON track.AlbumId = album.AlbumId JOIN
        artist ON artist.ArtistId = album.ArtistId
   GROUP BY artist.ArtistId
   HAVING AverageMinutes BETWEEN 3.0 AND 4.0;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "AverageMinutes"

   "Antônio Carlos Jobim", "3.83"
   "Body Count", "3.13"
   "Buddy Guy", "4.0"
   "Caetano Veloso", "3.79"
   "Chico Buarque", "3.86"
   ..., ...

   
.. questionnote::

   За сваког уметника/групу који има 5 или више албума приказати број
   албума (резултат приказати сортирано по броју албума, опадајуће)
   
.. code-block:: sql

   SELECT artist.Name, COUNT(*) AS AlbumCount
   FROM artist JOIN
        album ON artist.ArtistId = album.ArtistId
   GROUP BY artist.ArtistId
   HAVING AlbumCount >= 5
   ORDER BY AlbumCount DESC;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "AlbumCount"

   "Iron Maiden", "21"
   "Led Zeppelin", "14"
   "Deep Purple", "11"
   "Metallica", "10"
   "U2", "10"
   ..., ...


.. questionnote::

   За сваког извођача који је снимао композиције у неколико различитих
   жанрова приказати број жанрова у којима је снимао композиције.
   
.. code-block:: sql
   
   SELECT artist.Name, count(DISTINCT track.GenreId) AS NumGenres
   FROM track JOIN
        album ON track.AlbumId = album.AlbumId JOIN
        artist ON artist.ArtistId = album.ArtistId
   GROUP BY artist.ArtistId
   HAVING NumGenres > 1
   ORDER BY NumGenres DESC;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "NumGenres"

   "Iron Maiden", "4"
   "Battlestar Galactica", "3"
   "Lenny Kravitz", "3"
   "Jamiroquai", "3"
   "Gilberto Gil", "3"
   ..., ...

   
.. questionnote::

   Приказати називе свих различитих жанрова компоизиција групе ``Iron
   Maiden``.
   
.. code-block:: sql
   
   SELECT DISTINCT genre.Name
   FROM track JOIN
        album ON track.AlbumId = album.AlbumId JOIN
        artist ON artist.ArtistId = album.ArtistId JOIN
        genre ON genre.GenreId = track.GenreId
   WHERE artist.Name = 'Iron Maiden';

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name"

   "Rock"
   "Metal"
   "Heavy Metal"
   "Blues"

