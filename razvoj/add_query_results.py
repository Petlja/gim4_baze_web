import sys, os, glob
import sqlite3 as sql
import traceback

import locale
locale.setlocale(locale.LC_ALL, '')

def collate_UNICODE(str1, str2):
    return locale.strcoll(str1, str2)

def process_file(filename):
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

                try:
                    db_file = os.path.join(BASE_DIR, 'dnevnik', 'app', 'dnevnik.db')
                    con = sql.connect(db_file)
                    con.create_collation("UNICODE", collate_UNICODE)
                    cur = con.cursor();
                    cur.execute(query)
                
                    print(file=f)
                    print("Извршавањем упита добија се следећи резултат:", file=f)
                    print(file=f)
                    print(".. csv-table::", file=f)
                    names = list(map(lambda x: x[0], cur.description))
                    print("   :header: ", ", ".join(map(lambda x: '"' + x + '"', names)), file=f)
                    print(file=f)
                    nr = 0
                    for row in cur.fetchall():
                        nr += 1
                        if nr > 5:
                            print("  ", ", ".join(map(lambda x: "...", row)), file=f)
                            break

                        print("  ", ", ".join(map(lambda x: str(x) if x is not None else "NULL", row)), file=f)
                    con.close();
                except:
                    print("Error executing query:", query, file=sys.stderr)
                    # traceback.print_exc()
                    
                print(file=f)
            i += 1
    


BASE_DIR = os.path.dirname(os.path.abspath(__file__))

if len(sys.argv) < 2:
    sys.exit("Source directory or a source file path expected")

dirent = os.path.abspath(sys.argv[1])

if dirent.endswith(".rst_"):
    process_file(dirent)
else:
    path = os.path.join(dirent, "**/*.rst_")
    for filename in glob.iglob(path, recursive=True):
        process_file(filename)
