*** Settings ***
Documentation       Users route test suite

Resource            ../resources/Base.robot


*** Test Cases ***
Add new user
    ${user}    Factory New User

    Remove User    ${user}

    ${response}    POST User    ${user}
    Status Should Be    201    ${response}

    # get the id value from API's response and store it inside a variable
    ${user_id}    Set Variable    ${response.json()}[id]
    Should Be True    ${user_id} > 0
