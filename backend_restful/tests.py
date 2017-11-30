import users
import unittest
import json
# import bcrypt
import base64
from pymongo import MongoClient


class TripPlannerTestCase(unittest.TestCase):
    def setUp(self):

      self.app = users.app.test_client()
      # Run app in testing mode to retrieve exceptions and stack traces
      users.app.config['TESTING'] = True

      mongo = MongoClient('localhost', 27017)
      global db

      # Reduce encryption workloads for tests
      # users.app.bcrypt_rounds = 4

      db = mongo.trip_planner_test
      users.app.db = db

      db.drop_collection('users')
      db.drop_collection('trips')

    # User tests, fill with test methods
    def testCreateUser(self):
        pass

    def test_getting_a_user(self):

    ## Post 2 users to database
        self.app.post('/user/',
                        headers=None,
                        data=json.dumps(dict(
                            name="Eliel Gordon",
                            email="eliel@example.com"
                            )),
                        content_type='application/json')

                            ## 3 Make a get request to fetch the posted user

        response = self.app.get('/user/',
            query_string=dict(email="eliel@example.com")
            )
            # Decode reponse

            ## Actual test to see if GET request was succesful
            ## Here we check the status code
        self.assertEqual(response.status_code, 200)

if __name__ == '__main__':
    unittest.main()
