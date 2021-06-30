Угнежђени упити -- музика
.........................

.. questionnote::

   Приказати дигитални формат који је доминантан (највише бајтова је у
   том формату).

.. code-block:: sql

   SELECT Name, MAX(Bytes)
   FROM (SELECT media_type.Name, SUM(Bytes) AS Bytes
         FROM track JOIN
              media_type ON track.MediaTypeId = media_type.MediaTypeId);

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "MAX(Bytes)"
   :align: left

   "MPEG audio file", "117386255350"


.. questionnote::

   Одредити назив плејлисте на којој има највише песама.

.. code-block:: sql

   SELECT Name, MAX(Count)
   FROM (SELECT playlist.Name, COUNT(*) AS Count
         FROM playlist_track JOIN
              playlist ON playlist.PlaylistId = playlist_track.PlaylistId
         GROUP BY playlist.PlaylistId);

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name", "MAX(Count)"
   :align: left

   "Music", "3290"

.. questionnote::

   Приказати називе свих извођача који су снимали блуз (``Blues``)
   композиције.

.. code-block:: sql

   SELECT Name
   FROM artist
   WHERE EXISTS (SELECT *
                 FROM track JOIN
                      album ON track.AlbumId = album.AlbumId JOIN
                      genre ON track.GenreId = genre.GenreId
                 WHERE album.ArtistId = artist.ArtistId AND genre.Name = 'Blues');

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name"
   :align: left

   "Buddy Guy"
   "Eric Clapton"
   "Iron Maiden"
   "Stevie Ray Vaughan & Double Trouble"
   "The Black Crowes"

