.. -*- mode: rst -*-

Спајање --- музика
------------------

У наставку ћемо приказати неколико упита у којима се користи спајање,
а који читају податке из базе компаније која врши продају музичких
композиција.

.. questionnote::

   Прикажи називе свих песама и њихове жанрове.


.. code-block:: sql

   SELECT track.Name, genre.Name
   FROM track JOIN
        genre ON track.GenreId = genre.GenreID;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "Name"
   :align: left

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
   :align: left

   "Desafinado"
   "Garota De Ipanema"
   "Samba De Uma Nota Só (One Note Samba)"
   "Por Causa De Você"
   "Ligia"
   ...


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
   :align: left

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
   :align: left

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
   :align: left

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
   :align: left

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
   :align: left

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
   :align: left

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
   :align: left

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
   :align: left

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
   :align: left

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
   :align: left

   "Rock"
   "Metal"
   "Heavy Metal"
   "Blues"


.. questionnote::

   За сваког извођача приказати идентификатор, име и укупан број рок
   композиција које је снимио (ако није снимио ни једну, приказати
   нулу).

Пошто се тражи приказ броја композиција за све извођаче, а многи
извођачи нису снимили ниједну рок композицију, потребно је да
употребимо лево спајање.

.. code-block:: sql
                
   SELECT ar.Name, COUNT(t.Name) AS broj_rok_kompozicija
   FROM (artist ar JOIN
         album al ON ar.ArtistId = al.ArtistId)
   LEFT JOIN
        (track t JOIN
         genre g ON t.GenreId = g.GenreId AND g.Name = 'Rock') ON al.AlbumId = t.AlbumId
   GROUP BY ar.ArtistId
   ORDER BY broj_rok_kompozicija DESC   

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "broj_rok_kompozicija"
   :align: left

   "Led Zeppelin", "114"
   "U2", "112"
   "Deep Purple", "92"
   "Iron Maiden", "81"
   "Pearl Jam", "54"
   ..., ...

   
Вежба
.....

Покушај да наредних неколико упита напишеш самостално.

.. questionnote::

   Приказати списак композиција који садржи назив извођача и назив композиције.
   
.. dbpetlja:: db_spajanje_muzika_01
   :dbfile: music.sql
   :solutionquery: SELECT artist.Name, track.Name
                   FROM track JOIN
                        album ON track.AlbumId = album.AlbumId JOIN
                        artist ON artist.ArtistId = album.ArtistId;

.. questionnote::

   Приказати податке о томе који запослени подноси извештај ком
   запосленом у читљивом формату (у свакој врсти приказати
   идентификатор, име и презиме шефа, а затим идентификатор, име и
   презиме оног коме је та особа шеф).

.. dbpetlja:: db_spajanje_muzika_02
   :dbfile: music.sql
   :solutionquery: SELECT e1.EmployeeId, e1.FirstName, e1.LastName,
                          e2.EmployeeId, e2.FirstName, e2.LastName
                   FROM employee e1 JOIN
                        employee e2 ON e1.EmployeeId = e2.ReportsTo


                        
.. questionnote::

   Приказати имена купаца уз имена запослених који су задужени за
   њихову техничку подршку (сортирати списак по именима запослених, а
   за сваког запосленог по именима купаца).

   
.. dbpetlja:: db_spajanje_muzika_03
   :dbfile: music.sql
   :solutionquery: SELECT c.FirstName, c.LastName, e.FirstName, e.LastName
                   FROM customer c JOIN
                        employee e ON c.SupportRepId = e.EmployeeId
                        ORDER BY e.LastName, e.FirstName, c.LastName, c.FirstName
   
                        
.. questionnote::

   За сваки жанр приказати дужину најкраће и најдуже композиције.
   
.. dbpetlja:: db_spajanje_muzika_04
   :dbfile: music.sql
   :solutionquery: SELECT Name, Min(Milliseconds), Max(Milliseconds)
                   FROM genre g JOIN 
                        track t ON g.GenreId = t.GenreId
                   GROUP BY g.GenreId
    
.. questionnote::

   Приказати број ставки на свакој наруџбеници испорученој у Бразил
   (приказати идентификатор наруџбенице, име и презиме купца и број
   ставки). Резултате сортирати неопадајуће по броју ставки.

.. dbpetlja:: db_spajanje_muzika_05
   :dbfile: music.sql
   :solutionquery: SELECT i.InvoiceId, c.FirstName, c.LastName, COUNT(*) AS broj_stavki
                   FROM invoice i JOIN
                        invoice_item ii ON i.InvoiceId = ii.InvoiceId JOIN
                        customer c ON i.CustomerId = c.CustomerId
                   WHERE BillingCountry = 'Brazil'
                   GROUP BY i.InvoiceId
                   ORDER BY broj_stavki
                 
.. questionnote::

   Приказати имена, презимена и укупне износе наруџбина (заокружене на
   2 децимале) сваког купца за 3 купаца који су направили највеће
   износе наруџбина. Резултат приказати опадајуће по укупном износу.
   
.. dbpetlja:: db_spajanje_muzika_06
   :dbfile: music.sql
   :solutionquery: SELECT c.FirstName, c.LastName, ROUND(SUM(Total), 2) AS ukupan_iznos
                   FROM invoice i JOIN
                        customer c ON i.CustomerId = c.CustomerId
                   GROUP BY c.CustomerId
                   ORDER BY ukupan_iznos DESC
                   LIMIT 3

.. questionnote::

   За сваког запосленог прикази идентификатор, име, презиме, број
   запослених који њему подносе извештај (поље
   ``ReportsTo``). Приказати и оне запослене којима је тај број једнак
   нули.

   
.. dbpetlja:: db_spajanje_muzika_07
   :dbfile: music.sql
   :solutionquery: SELECT e1.EmployeeId, e1.FirstName, e1.LastName,
                          COUNT(e2.EmployeeId) AS broj_podredjenih
                   FROM employee e1 LEFT JOIN
                        employee e2 ON e1.EmployeeId = e2.ReportsTo
                   GROUP BY e1.EmployeeId
