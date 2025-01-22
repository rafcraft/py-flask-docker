from flask import Flask, render_template, flash, request
from flask_migrate import Migrate
from flask_bootstrap import Bootstrap
from flask_socketio import SocketIO, emit
from flask_sqlalchemy import SQLAlchemy
from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField
from wtforms.validators import DataRequired
from sqlalchemy import TIMESTAMP
from dotenv import load_dotenv
import os

load_dotenv()

db_user = os.getenv('DB_USER')
db_password = os.getenv('DB_PASSWORD')
db_host = os.getenv('DB_HOST')
db_name = os.getenv('DB_NAME')

app = Flask(__name__)
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')
app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+pymysql://{db_user}:{db_password}@{db_host}/{db_name}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

bootstrap = Bootstrap(app)
socketio = SocketIO(app)
db = SQLAlchemy(app)
migrate = Migrate(app, db)

class Form(db.Model):
    __tablename__ = 'form'
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(255), nullable=False)
    name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    message = db.Column(db.Text, nullable=False)

class Message(db.Model):
    __tablename__ = 'messages'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), nullable=False)
    message = db.Column(db.Text, nullable=False)
    data = db.Column(TIMESTAMP(timezone=True), server_default=db.func.now())

class MyForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired()])
    name = StringField('Imię', validators=[DataRequired()])
    last_name = StringField('Nazwisko', validators=[DataRequired()])
    message = TextAreaField('Wiadomość', validators=[DataRequired()])

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/chat')
def chat():
    messages = Message.query.order_by(Message.id.asc()).limit(20).all()
    return render_template('chat.html', messages=messages)

@app.route('/form', methods=['GET', 'POST'])
def form():
    form1 = MyForm()
    if form1.validate_on_submit():
        new_form = Form(
            email=form1.email.data,
            name=form1.name.data,
            last_name=form1.last_name.data,
            message=form1.message.data
        )
        db.session.add(new_form)
        db.session.commit()
        flash('Dane zostały zapisane pomyślnie!', 'success')
    return render_template('form.html', form=form1)

@socketio.on('connect')
def handle_connect():
    print('Połączono z klientem:', request.sid)

@socketio.on('message')
def handle_message(data):
    new_message = Message(username=data['name'], message=data['message'])
    db.session.add(new_message)
    db.session.commit()
    emit('message', {'name': data['name'], 'message': data['message']}, broadcast=True)

@socketio.on('disconnect')
def handle_disconnect():
    print('Rozłączono z klientem:', request.sid)

@app.teardown_appcontext
def shutdown_session(exception=None):
    db.session.remove()
