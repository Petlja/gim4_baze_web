.. -*- mode: rst -*-

Рестрикција након груписања (HAVING)
....................................

Када се израчунају статистике по групама, можемо пожелети да поново
филтрирамо податке тј. да одаберемо које групе желимо да буду
приказане на основу вредности израчунатих статистика. На пример,
можемо израчунати број ученика у сваком одељењу и затим приказати само
она одељења која имају више од 30 ученика. За то се може користити
клаузула ``HAVING``. Дакле, клаузулу ``WHERE`` користимо да бисмо
извршили филтрирање података пре груписања, а ``HAVING`` након
груписања и израчунавања агрегатних статистика.


.. questionnote::

   Приказати одељења у којима има више од 30 ученика.

 
.. code-block:: sql
   
   SELECT razred, odeljenje, COUNT(*) as broj_ucenika
   FROM ucenik
   GROUP BY razred, odeljenje
   HAVING broj_ucenika >= 30;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "razred", "odeljenje", "broj_ucenika"

   1, 2, 33
   2, 1, 32
   3, 1, 33
   4, 3, 30


Упит може да садржи двоструко филтрирање (и ``WHERE`` и ``HAVING``).
   
.. questionnote::

   Приказати одељења у којима има више од 20 девојчица.
   
.. code-block:: sql
   
   SELECT razred, odeljenje, COUNT(*) as broj_devojcica
   FROM ucenik
   WHERE pol = 'ж'
   GROUP BY razred, odeljenje
   HAVING broj_devojcica > 20;

Извршавањем упита добија се следећи резултат:

.. csv-table::
   :header:  "razred", "odeljenje", "broj_devojcica"

   1, 1, 27
   1, 2, 22

