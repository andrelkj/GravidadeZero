*** Comments ***
# create database connections


*** Settings ***
Documentation       Database Helpers

Library             DatabaseLibrary
Library             factories/Users.py


*** Keywords ***
Connect To Postgres
    Connect To Database    psycopg2
    # Database
    ...    dubneckp
    # Username
    ...    dubneckp
    # Password
    ...    ee8Q5gfemekDwIRgt5DdgU01wK8hoYqp
    # Database pathway (URL)
    ...    babar.db.elephantsql.com
    # Port - Default port to PostgreSQL is 5432
    ...    5432

Reset Env
    Execute SQL String    DELETE from public.geeks;
    Execute SQL String    DELETE from public.users;

Insert User
    [Arguments]    ${u}
    # password must be encripted to a successfull login
    ${hashed_pass}    Get Hashed Pass    ${u}[password]

    ${q}    Set Variable
    ...    INSERT INTO public.users (name, email, password_hash, is_geek) values ('${u}[name] ${u}[lastname]', '${u}[email]', '${hashed_pass}', false)

    Execute SQL String    ${q}

Users Seed
    ${users}    Users To Insert DB

    FOR    ${user}    IN    @{users}
        Insert User    ${user}
    END
