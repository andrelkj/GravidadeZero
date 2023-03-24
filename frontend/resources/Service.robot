*** Settings ***
Documentation    Services API

Library    RequestsLibrary

*** Variables ***
${API_GATEWAY}    https://geeks-api-andre.fly.dev

*** Keywords ***
Get Token
    [Arguments]    ${user}

    ${payload}    Create Dictionary
    ...    email=${user}[email]
    ...    password=${user}[password]

    ${response}    POST    ${API_GATEWAY}/sessions    json=${payload}

    ${token}    Set Variable    Bearer ${response.json()}[token]

    [Return]    ${token}
