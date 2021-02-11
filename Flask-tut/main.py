from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
import json
import os
import math
from flask_mail import Mail
from datetime import datetime


with open('config.json', 'r') as c:
    param = json.load(c)["parameters"]

local_server = True
app = Flask(__name__)
app.secret_key = 'super-secret-key'
app.config['UPLOAD_FOLDER'] =  param['upload_location']

app.config.update(
    MAIL_SERVER = 'smtp.gamil.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = param['gmail_user'],
    MAIL_PASSWORD = param['gmail_password']
)
mail = Mail(app)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = param['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = param['prod_uri']

db = SQLAlchemy(app)

class Contacts(db.Model):
    #sno, name, email, phone_num, msg, date
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(150), nullable=False)
    date = db.Column(db.String(12), nullable=True)


@app.route('/')
def home():
    post = Posts.query.filter_by().all()
    last = math.ceil(len(post) / int(param['no_of_posts']))                         #[0:param['no_of_posts']]
    page = request.args.get('page')
    if not str(page).isnumeric():
        page = 1

    page = int(page)
    post = post[(page-1) * int(param['no_of_posts']) : (page-1) * int(param['no_of_posts']) + int(param['no_of_posts'])]
    #pagination 
    #first
    if page == 1:
        prev = "#"
        nextpage = "/?page = " + str(page + 1) 
    elif  page == last :
        prev = "/?page = " + str(page - 1) 
        nextpage = "#"
    else:
        prev = "/?page = " + str(page - 1) 
        nextpage = "/?page = " + str(page + 1) 

    return(render_template('index.html', param = param, posts = post, prev = prev, next = nextpage))

@app.route('/about')
def about():
    return(render_template('about.html', param = param))
    #name = 'fiza'
    #return(render_template('about.html', namehtml = name))

@app.route('/contact', methods = ['GET', 'POST'])
def contact():
    if (request.method == 'POST'):
        #add entry to database
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phonenum')
        message = request.form.get('msg')

        entry = Contacts(name = name, email = email, phone_num = phone, msg = message, date = datetime.now())
        db.session.add(entry)
        db.session.commit()
        #mail.send_message('New message from ' + name + 'in KBlogs', sender = email, recipients = [param[gmail_user]], body = message + "\n" + phone)

    return(render_template('contact.html', param = param))

class Posts(db.Model):
    #sno,name, title, slug, content, date
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(20), nullable=False)
    content = db.Column(db.String(10000), nullable=False)
    img_file = db.Column(db.String(60), nullable=True)
    date = db.Column(db.String(12), nullable=True)

@app.route('/post/<string:post_slug>', methods = ["GET"])
def post_route(post_slug):
    post = Posts.query.filter_by(slug = post_slug).first()
    return(render_template('post.html', param = param, post = post))

@app.route('/postmain', methods = ['GET', 'POST'])
def postmain():
    if (request.method == 'POST'):
        #add entry to database
        name = request.form.get('name')
        title = request.form.get('title')
        slug = request.form.get('slug')
        content = request.form.get('content')
        image_file = request.form.get('imgfile')

        entry = Posts(name = name, title = title, slug = slug, content = content, img_file = image_file, date = datetime.now())
        db.session.add(entry)
        db.session.commit()
    return(render_template('postmain.html', param = param))

@app.route('/dashboard', methods = ['GET', 'POST'])
def login():
    if 'user' in session and session['user'] == param['admin_user']:
        post = Posts.query.all()
        return(render_template('dashboard.html', param = param, posts = post))

    if request.method == 'POST':
        #REDIRECT TO ADMIN PANEL
        username = request.form.get('uname')
        password = request.form.get('password')
        if username == param['admin_user'] and password == param['admin_password']:
            #set session variable
            session['user'] = username
            post = Posts.query.all()
            return(render_template('dashboard.html', param = param, posts = post))
        
    else:
        return(render_template('login.html', param = param))

@app.route('/edit/<string:sno>', methods = ['GET', 'POST'])
def edit(sno):
    if 'user' in session and session['user'] == param['admin_user']:
        if request.method == 'POST':
            box_title = request.form.get('title') 
            slug = request.form.get('slug') 
            content = request.form.get('content') 
            img_file = request.form.get('imgfile')
            date = datetime.now()

            if sno == '0':
                post = Posts(title = box_title, slug = slug, content = content, img_file = img_file, date = date)
                db.session.add(post)
                db.session.commit() 
            else:
                post = Posts.query.filter_by(sno = sno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.img_file = img_file
                post.date = date
                db.session.commit() 
                return(redirect('/edit/' + sno ))

        post = Posts.query.filter_by(sno = sno).first()
        return(render_template('edit.html', param = param, post = post))

@app.route('/uploader', methods = ['GET', 'POST'])
def uploader():
    if 'user' in session and session['user'] == param['admin_user']:
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return("Uploaded sucessfully")

@app.route('/logout')
def logout():
    session.pop('user')
    return(redirect('/dashboard'))

@app.route('/delete/<string:sno>', methods = ['GET', 'POST'])
def delete(sno):
    if 'user' in session and session['user'] == param['admin_user']:
        post = Posts.query.filter_by(sno = sno).first()
        db.session.delete(post)
        db.session.commit() 
    return(redirect('/dashboard'))



app.run(debug=True)