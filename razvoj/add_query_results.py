import sys, os, glob
import sqlite3 as sql;

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

if len(sys.argv) < 2:
    sys.exit("Source directory expected")
else:
    dir = os.path.abspath(sys.argv[1])
path = os.path.join(dir, "**/*.rst_")
for filename in glob.iglob(path, recursive=True):
    with open(filename) as f:
       lines = f.readlines()

    with open(filename[:-1], "w") as f:
        i = 0
        while i < len(lines):
            print(lines[i], end="", file=f)
            if lines[i].startswith(".. code-block:: sql"):
                print(lines[i+1], end="", file=f)
                i += 2
                query = "";
                while i < len(lines) and lines[i].strip() != "":
                    print(lines[i], end="", file=f)
                    query += lines[i].strip() + " ";
                    i += 1

                if not query.startswith("SELECT"):
                    continue
            
                print(file=f)
                print("Извршавањем упита добија се следећи резултат:", file=f)
                print(file=f)
                print(".. csv-table::", file=f)
                db_file = os.path.join(BASE_DIR, 'dnevnik', 'app', 'dnevnik.db')
                con = sql.connect(db_file)
                cur = con.cursor();
                cur.execute(query)
                names = list(map(lambda x: x[0], cur.description))
                print("   :header: ", ", ".join(map(lambda x: '"' + x + '"', names)), file=f)
                print(file=f)
                nr = 0
                for row in cur.fetchall():
                    nr += 1
                    if nr >= 5:
                        print("  ", ", ".join(map(lambda x: "...", row)), file=f)
                        break

                    print("  ", ", ".join(map(lambda x: str(x) if x else "NULL", row)), file=f)
                con.close();
                print(file=f)
        
            i += 1
