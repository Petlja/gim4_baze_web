import os
import sqlite3 as sql
from app import app
from flask import render_template, request

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

def procitaj_sve_ucenike(razred):
    con = sql.connect(os.path.join(BASE_DIR, 'dnevnik.db'))
    cur = con.cursor();
    if razred:
        cur.execute(r'SELECT * FROM ucenik WHERE razred=?', (razred,))
    else:
        cur.execute(r'SELECT * FROM ucenik')
    ucenici = []
    for row in cur.fetchall():
        ucenici.append({'ime': row[1], 'prezime': row[2]})
    con.close()
    return ucenici


@app.route('/')
@app.route('/index')
def index():
    razred = request.args.get('razred', None, int)
    ucenici = procitaj_sve_ucenike(razred)
    return render_template('index.html', razred=razred, ucenici=ucenici)
