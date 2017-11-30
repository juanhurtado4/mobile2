from flask import Flask, request

from pymongo import MongoClient

import pdb

import json


app = Flask(__name__)

app.config['DEBUG'] = True

mongo = MongoClient('localhost, 27017')

app.db = mongo.test


class User(Resource):

    def post(self):
      pass

    def get(self, myobject_id):
      pass
