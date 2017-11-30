from flask import Flask, request, jsonify, make_response
import json
from pymongo import MongoClient
from util import JSONEncoder
from flask_restful import Api, Resource

import pdb
app = Flask(__name__)

mongo = MongoClient('127.0.0.1, 27017')

## Setup Flask Restful
app.db = mongo.test
api = Api(app)


class User(Resource):
    def post(self):
      pass

    def get(self):
        name = request.args.get('name')
        users_collection = app.db.users
        user = users_collection.find_one({'name': name})

        if user is None:
            response = jsonify(data=[])
            response.status_code = 404
            return response
        else:
            return user
          # Get users collection


          # ## Serialize one user response
          # json_user = JSONEncoder().encode(result)
          # pdb.set_trace()
          # return (json_user, 200, {"Content-Type": "application/json"})
          # return (result, 200, None)

      # return ('{"Does not have name url param"}', 400, None)

    def patch(self):
        pass

    def delete(self):
        pass

api.add_resource(User, "/users")


@api.representation('application/json')
def output_json(data, code, headers=None):
    resp = make_response(JSONEncoder().encode(data), code)
    resp.headers.extend(headers or {})
    return resp

if __name__ == '__main__':
    # Turn this on in debug mode to get detailled information about request related exceptions: http://flask.pocoo.org/docs/0.10/config/
    app.config['TRAP_BAD_REQUEST_ERRORS'] = True
    app.run(debug=True)
