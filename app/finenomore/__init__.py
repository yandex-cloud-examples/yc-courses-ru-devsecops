import os
import json
import datetime
import socket
import base64
import string
import random
import psycopg2
from pathlib import Path

from flask import Flask
from flask import request
from flask import jsonify
from flask import render_template

from flask_bootstrap import Bootstrap5

def create_app():
  app = Flask(__name__)
  bootstrap = Bootstrap5(app)

  def get_cursor():
    conn = psycopg2.connect(host="postgres",
      database="finenomore",
      user="finenomore",
      password="LTAIsupersecretkeyfordat")
    
    conn.set_session(autocommit=True)

    return conn.cursor()

  @app.route("/")
  def root():
    return render_template('index.html')

  @app.route("/api/search/", methods=["POST"])
  def api_search():
    content = request.json
    rows = []
    if 'number' in content:
      number = content['number']
      cur = get_cursor()
      try:
        cur.execute(f"SELECT * FROM fines WHERE number_id IN (SELECT id FROM numbers WHERE LOWER(number) = LOWER('{number}'));")
        rows = cur.fetchall()
      except:
        return jsonify({ "result": "Database error" }), 500
    
    return jsonify({ "result": rows })

  @app.route("/number/", methods=["GET"])
  def number():
    number = request.args.get('n')
    rows = []
    if number:
      cur = get_cursor()
      try:
        cur.execute(f"SELECT * FROM fines WHERE number_id IN (SELECT id FROM numbers WHERE LOWER(number) = LOWER('{number}'));")
        rows = cur.fetchall()
      except:
        pass
    
    return render_template('search.html', number = number, rows = rows)

  @app.route("/status/")
  def status():
    return jsonify({ "status": "ok", "database": get_cursor().connection.status })

  return app
