*** Settings ***
Documentation       Session route test suite

Library             RequestsLibrary


*** Variables ***
${API_USERS}    https://geeks-api-andre.fly.dev


*** Test Cases ***
User session
    ${payload}    Create Dictionary    email=test2@email.com    password=pwd123

    ${response}    POST    ${API_USERS}/sessions    json=${payload}

    Status Should Be    200    ${response}

    # Gets the token length and store it inside the size variable to furter validation
    ${size}    Get Length    ${response.json()}[token]

    # Get Length function returns an integer number data type while Should Be Equal function expects a string so we need to convert it to integer as well
    ${expected_size}    Convert To Integer    140

    Should Be Equal    ${expected_size}    ${size}
    Should Be Equal    10d    ${response.json()}[expires_in]
