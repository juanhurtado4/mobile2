def display_status(status_code, json=None):
    return (json, status_code, None)


def check_user(username, password):
        users_collection = app.db.users
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
                return display_status(401)

        return wrapper


def post(self):
        '''
        Creates a new user

        '''
        new_user = request.json
        email = new_user['email']
        password = new_user['password']

        users_collection = app.db.users
        # users = users_collection.find_one( {"_id": ObjectId(result.inserted_id)} )
        user = users_collection.find_one({"email": email})

        # if email != user['email']:
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

        users_collection = app.db.users
        email = request.authorization.username
        user = users_collection.find_one({"email": email})
        user.pop('password')
        return (user, 200, None)
