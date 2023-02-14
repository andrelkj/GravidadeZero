# Returns the application to default (before having entered data) and configuring database environment
*** Settings ***
Documentation    Delorean

Resource         ../resources/Database.robot

*** Tasks ***
Back to the Past
    Connect To Postgres
    Reset Env
    Users Seed
    Disconnect From Database