Пројекција и рестрикција -- музика
----------------------------------

.. questionnote::

   Прикажи све називе извођача.

.. code-block:: sql

   SELECT name
   FROM artist;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name"

   AC/DC
   Accept
   Aerosmith
   Alanis Morissette
   Alice In Chains
   ...

.. questionnote::

   Прикажи све називе песама са албума чији је идентификатор 1.

.. code-block:: sql

   SELECT name
   FROM track
   WHERE AlbumId = 1;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name"

   For Those About To Rock (We Salute You)
   Put The Finger On You
   Let's Get It Up
   Inject The Venom
   Snowballed
   ...

