.. -*- mode: rst -*-

Уписивање података прочитаних из базе
.....................................

Постоји још један облик упита ``INSERT`` који омогућава да се
вредности које се уписују у табелу прочитају из базе коришћењем упита
``SELECT``.

.. code-block:: sql

   INSERT INTO tabela (kolona_1, ..., kolona_k)
   SELECT ...;


На пример, могли бисмо направити привремену табелу ``prosek`` са
колонама ``predmet_id``, ``naziv``, ``razred``, ``prosek`` и затим је
попунити коришћењем упита

.. code-block:: sql

   INSERT INTO prosek (predmet_id, naziv, razred, prosek)
   SELECT p.id, p.naziv, p.razred, AVG(o.ocena)
   FROM predmet p JOIN
        ocena o ON p.id = o.id_predmet
   GROUP BY p.id;

Ово можемо искористити и да упишемо оцену Анкици Павловић у једном кораку.

.. code-block:: sql
                
   INSERT INTO ocena (id_ucenik, id_predmet, datum, ocena, vrsta)
   SELECT *, '2020-10-01', 5, 'контролна вежба' FROM
      (SELECT id
       FROM ucenik
       WHERE ime = 'Аница' AND prezime = 'Павловић' AND razred = 4 AND odeljenje = 2), 
      (SELECT id
       FROM predmet
       WHERE naziv = 'Математика' AND razred = 4);

У клаузули ``FROM`` наводе се две табеле које су обе су резултат
угнежђених упита и имају једну врсту и једну колону. Гради се њихов
Декартов производ и тако се добија табела која садржи само једну врсту
која је уређени пар јединственог идентификатора ученице Анице Павловић
и јединственог идентификатора предмета математика у четвртом разреду.
Ти подаци се читају помоћу спољашњег ``SELECT *``, додају им се датум,
оцена и врста и онда се тако добијена врста уписује у табелу оцена
помоћу ``INSERT INTO``.
