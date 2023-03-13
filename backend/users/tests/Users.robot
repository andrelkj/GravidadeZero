*** Settings ***
Documentation       Users route test suite

Resource            ../resources/Base.robot


*** Test Cases ***
Add new user
    ${user}    Factory New User

    Remove User    ${user}

    ${response}    POST User    ${user}
    Status Should Be    201    ${response}
