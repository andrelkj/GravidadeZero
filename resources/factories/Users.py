# Defining test dough

import bcrypt
from faker import Faker
fake = Faker()


def get_hashed_pass(password):
    hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt(8))
    return hashed


def factory_user():
    return {
        'name': fake.first_name(),
        'lastname': fake.last_name(),
        'email': fake.free_email(),
        'password': 'pwd123'
    }


def factory_wrong_email():

    first_name = fake.first_name()

    return {
        'name': first_name,
        'lastname': fake.last_name(),
        # .lower() method turns all first_name text to lower case
        'email': first_name.lower() + '&gmail.com',
        'password': 'pwd123'
    }


def factory_user_login():
    return {
        'name': 'Test',
        'lastname': 'User',
        'email': 'test@email.com',
        'password': 'pwd123'
    }
