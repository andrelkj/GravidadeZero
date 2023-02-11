*** Settings ***
Documentation       Test Helpers

Resource    Actions.robot

*** Keywords ***
Add User From Database
    [Arguments]    ${user}

    Connect To Postgres
    Insert User    ${user}
    Disconnect From Database
