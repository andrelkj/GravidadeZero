# Returns the application to default (before having entered data)
*** Settings ***
Documentation    Delorean

Resource         ../resources/Database.robot

*** Tasks ***
Back to the Past
    Connect To Postgres
    Reset Env
    Disconnect From Database