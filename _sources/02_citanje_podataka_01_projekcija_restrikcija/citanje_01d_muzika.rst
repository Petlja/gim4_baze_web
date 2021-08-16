Пројекција и селекција -- музика
--------------------------------

Прикажимо сада неколико упита над базом која садржи податке компанију
за продају музичких композиција.

.. questionnote::

   Прикажи све називе извођача.

.. code-block:: sql

   SELECT name
   FROM artist;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "Name"
   :align: left

   "AC/DC"
   "Accept"
   "Aerosmith"
   "Alanis Morissette"
   "Alice In Chains"
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
   :align: left

   "For Those About To Rock (We Salute You)"
   "Put The Finger On You"
   "Let's Get It Up"
   "Inject The Venom"
   "Snowballed"
   ...

.. questionnote::

   Прикажи сва имена и презимена запослених који су из Канаде.

.. code-block:: sql

   SELECT FirstName, LastName
   FROM employee
   WHERE Country = 'Canada';

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "FirstName", "LastName"
   :align: left

   "Andrew", "Adams"
   "Nancy", "Edwards"
   "Jane", "Peacock"
   "Margaret", "Park"
   "Steve", "Johnson"
   ..., ...


Пројекција и селекција -- задаци за вежбу (музика)
..................................................

Покушај сада самостално да решиш наредних неколико задатака.

.. questionnote::

   Прикажи називе свих албума извођача чији је идентификатор 1.

.. dbpetlja:: db_proj_restr_muz_01
   :dbfile: music.sql
   :solutionquery:  SELECT title FROM album WHERE artistId = 1;

.. questionnote::

   Прикажи идентификаторе, имена и презимена купаца који се зову ``Jack``.

.. dbpetlja:: db_proj_restr_muz_02
   :dbfile: music.sql
   :solutionquery:  SELECT CustomerId, FirstName, LastName  FROM customer WHERE FirstName = 'Jack';
                    
