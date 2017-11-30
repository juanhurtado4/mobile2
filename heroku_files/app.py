from flask import Flask, request

from pymongo import MongoClient # Step 1

from bson import Binary, Code
from bson.json_util import dumps

import pdb

import json


app = Flask(__name__)

app.config['DEBUG'] = True

mongo = MongoClient('localhost, 27017') # Step 2

app.db = mongo.test # Step 3

@app.route('/users')
def get_users():

    # 1 Get url params
    name = request.args.get('name')

    pdb.set_trace()

    # 2 Our users collection
    users_collection = app.db.users_collection

    # 3 Find one document in our users collection
    result = users_collection.find_one({'name': 'Kaichi'})

    # 4 Convert result to json, its initially a python dict
    json_result = dumps(result)

    # 5 Return the json as part of the response body
    return (None, 200, None)

@app.route('/courses', methods=['POST'])
def get_courses():
    return 'hello'




@app.route('/')
def hello_world():
    return 'Hello world!'

@app.route('/my_page')
def my_page():
    return "Welcome to Juan's my page!"

@app.route('/fav_pets', methods=['GET', 'POST'])
def fav_pets():
    pets = [
                {
                    'Dog': {'name': 'Pandora', 'sex': 'female', 'color': 'brown', 'breed': 'Pitbull'}
                },
                {
                    'Dog': {'name': 'Django', 'sex': 'male', 'color': 'black', 'breed': 'Rottweiler'}
                },
                {
                    'Rodent': {'name': 'Shogun', 'sex': 'male', 'color': 'brown', 'breed': 'Hamster'}
                }
            ]

    json_pets = json.dumps(pets)

    if request.method == 'POST':
        return (json_pets, 200, None)
    else:
        return (json_pets, 200, None)


if __name__=='__main__':
    app.run()
