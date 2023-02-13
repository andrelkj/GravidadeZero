*** Settings ***
Documentation       Test Helpers

Resource    actions/SignupActions.robot

*** Keywords ***
Add User From Database
    [Arguments]    ${user}

    Connect To Postgres
    Insert User    ${user}
    Disconnect From Database
