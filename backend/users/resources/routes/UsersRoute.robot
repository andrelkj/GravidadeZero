*** Settings ***
Documentation    Users route

Resource    ../Base.robot

*** Keywords ***
POST User
    [Arguments]    ${payload}

    ${response}    POST    ${API_USERS}/users    json=${payload}    expected_status=any

    [Return]    ${response}
