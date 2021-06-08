import sys, os
import sqlite3 as sql;

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

lines = sys.stdin.readlines()

i = 0
while i < len(lines):
    print(lines[i], end="")
    if lines[i].startswith(".. code-block:: sql"):
        print(lines[i+1], end="")
        i += 2
        query = "";
        while i < len(lines) and lines[i].strip() != "":
            print(lines[i], end="")
            query += lines[i].strip() + " ";
            i += 1

        print()
        print("Извршавањем упита добија се следећи резултат")
        print()
        print(".. csv-table::")
        con = sql.connect(os.path.join(BASE_DIR, 'dnevnik', 'dnevnik.db'))
        cur = con.cursor();
        cur.execute(query)
        names = list(map(lambda x: x[0], cur.description))
        print("   :header: ", ", ".join(map(lambda x: '"' + x + '"', names)))
        print()
        nr = 0
        for row in cur.fetchall():
            nr += 1
            if nr >= 5:
                print("  ", ", ".join(map(lambda x: "...", row)))
                break

            print("  ", ", ".join(map(str, row)))
        con.close();
        print()
        
    i += 1
