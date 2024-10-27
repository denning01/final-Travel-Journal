from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime
from flask_cors import CORS
import os
app = Flask(__name__)
#adds a reource to enable CORS
CORS(app,resources={r'/*': {'origins': '*'}})
# Configurations
# app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///app.db'
app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL')
# postgresql://denning:1K8nPtTPgJsuFDhmfL3nEl48tl2DJpu3@dpg-csbupntds78s73bg9mk0-a.oregon-postgres.render.com/journal_app_ztyc  # Using SQLite for simplicity
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = 'your_jwt_secret_key'

# Extensions
db = SQLAlchemy(app)
migrate = Migrate(app, db)
jwt = JWTManager(app)

# Models

# User Model
class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    name = db.Column(db.String(120), nullable=False)
    description = db.Column(db.String(255), nullable=True)
    password = db.Column(db.String(128), nullable=False)

    posts = db.relationship('Post', backref='author', lazy=True)
    comments = db.relationship('Comment', backref='user', lazy=True)

    followers = db.relationship(
        'Follower',
        foreign_keys='Follower.followed_id',
        backref='followed',
        lazy=True
    )

    following = db.relationship(
        'Follower',
        foreign_keys='Follower.follower_id',
        backref='follower',
        lazy=True
    )

    def set_password(self, password):
        self.password = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password, password)
