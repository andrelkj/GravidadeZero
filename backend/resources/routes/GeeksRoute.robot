*** Settings ***
Documentation       Geeks route

Resource            ../Base.robot


*** Keywords ***
POST Geek
    [Arguments]    ${token}    ${payload}

    ${headers}    Create Dictionary    Authorization=${token}

    ${response}    POST    ${API_GEEKS}/geeks    json=${payload}    headers=${headers}    expected_status=any
    RETURN    ${response}

GET Geeks
    [Arguments]    ${token}

    ${headers}    Create Dictionary    Authorization=${token}

    ${response}    GET    ${API_GEEKS}/geeks    headers=${headers}    expected_status=any
    RETURN    ${response}