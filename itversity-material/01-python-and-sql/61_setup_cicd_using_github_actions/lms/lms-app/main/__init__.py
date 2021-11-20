from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from db_init import get_db_uri


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = get_db_uri()
db = SQLAlchemy(app)

import routes