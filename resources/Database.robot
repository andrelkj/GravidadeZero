*** Comments ***
# create database connections


*** Settings ***
Documentation       Database Helpers

Library             DatabaseLibrary


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
