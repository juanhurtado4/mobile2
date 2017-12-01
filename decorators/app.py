import json
import pdb
from flask import Flask, request, jsonify, make_response
from pymongo import MongoClient
from bson import Binary, Code
from bson.json_util import dumps
from flask_restful import Resource, Api
import bcrypt

app = Flask(__name__)
mongo = MongoClient(
    'mongodb://trip_username:NewYorkCity@ds161169.mlab.com:61169/trip_planner_production_best')

app.db = mongo.trip_planner_production_best
api = Api(app)
app.bcrypt_rounds = 12

users_collection = app.db.users_collection


def display_response(status_code, json=None):
    return (json, status_code, None)

def check_user(username, password):
        users_collection = app.db.users_collection
        user = users_collection.find_one({'email': username})

        if user is None:
            return False

        if bcrypt.checkpw(password.encode('utf-8'), user['password']):
            user.pop('password')
            return True
        else:
            return False

def request_auth(http_method):
        def wrapper(*args, **kwargs):
            email = request.authorization.username
            password = request.authorization.password

            if check_user(email, password) == True:
                return http_method(*args, **kwargs)

            else:
                return display_response(401)

        return wrapper


class Collections:
    def __init__(self):
        self.user_collection = app.db.users_collection
        self.trip_collection = app.db.trips


class Users(Resource, Collections):
    def post(self):
        '''
        Creates a new user
        '''
        new_user = request.json
        email = new_user['email']
        password = new_user['password']

        user = users_collection.find_one({"email": email})

        if user is None:
            encoded_password = password.encode('utf-8')

            hashed_password = bcrypt.hashpw(
                encoded_password, bcrypt.gensalt(app.bcrypt_rounds)
            )
            new_user['password'] = hashed_password
            results = users_collection.insert_one(new_user)
            new_user.pop('password')
            return(new_user, 200, None)
        else:
            return("Email is already taken", 409, None)


    @request_auth
    def get(self):
        '''
        Shows all/specific users
        '''
        email = request.authorization.username
        user = self.users_collection.find_one({"email": email})
        user.pop('password')
        return (user, 200, None)


api.add_resource(Users, '/users')

if __name__=='__main__':
    app.run(debug=True)