from pymongo import MongoClient
import bcrypt
#import ssl

client = MongoClient('mongodb+srv://qax:xperience@cluster0.5jpw4ah.mongodb.net/?retryWrites=true&w=majority') #,ssl_cert_reqs=ssl.CERT_NONE)
#mongodb+srv://qax:<password>@cluster0.5jpw4ah.mongodb.net/?retryWrites=true&w=majority

db = client['markdb']

def remove_user_by_email(user_email):
    users = db['users']
    users.delete_many({'email': user_email})
    print('Removendo o email ' + user_email)

def insert_user(user):
    users = db['users']

    hashed = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))

    doc = {
        'name': user['name'],
        'email': user['email'],
        'password': hashed
    }

    users.insert_one(doc)
    print(doc)