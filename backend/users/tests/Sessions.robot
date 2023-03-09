*** Settings ***
Documentation       Session route test suite

Resource    ../resources/Base.robot
Resource    ../resources/routes/SessionsRoute.robot


*** Test Cases ***
User session
    ${payload}    Create Dictionary    email=test@email.com    password=pwd123

    ${response}    POST Session    ${payload}

    Status Should Be    200    ${response}

    # Gets the token length and store it inside the size variable to furter validation
    ${size}    Get Length    ${response.json()}[token]

    # Get Length function returns an integer number data type while Should Be Equal function expects a string so we need to convert it to integer as well
    ${expected_size}    Convert To Integer    140

    Should Be Equal    ${expected_size}    ${size}
    Should Be Equal    10d    ${response.json()}[expires_in]

Wrong password
    ${payload}    Create Dictionary    email=test2@email.com    password=abc123

    ${response}    POST Session    ${payload}

    Status Should Be    401    ${response}
    Should Be Equal    Unauthorized    ${response.json()}[error]

User not found
    ${payload}    Create Dictionary    email=test2@error.com    password=abc123

    ${response}    POST Session    ${payload}

    Status Should Be    401    ${response}
    Should Be Equal    Unauthorized    ${response.json()}[error]

Incorrect email
    ${payload}    Create Dictionary    email=test2#error.com    password=abc123

    ${response}    POST Session    ${payload}

    Status Should Be    400    ${response}
    Should Be Equal    Incorrect email    ${response.json()}[error]

Empty email
    ${payload}    Create Dictionary    email=${EMPTY}    password=abc123

    ${response}    POST Session    ${payload}

    Status Should Be    400    ${response}
    Should Be Equal    Required email    ${response.json()}[error]

Without email
    ${payload}    Create Dictionary    password=abc123

    ${response}    POST Session    ${payload}

    Status Should Be    400    ${response}
    Should Be Equal    Required email    ${response.json()}[error]

Empty pass
    ${payload}    Create Dictionary    email=test2@email.com    password=${EMPTY}

    ${response}    POST Session    ${payload}

    Status Should Be    400    ${response}
    Should Be Equal    Required pass    ${response.json()}[error]

Without pass
    ${payload}    Create Dictionary    email=test2@email.com

    ${response}    POST Session    ${payload}

    Status Should Be    400    ${response}
    Should Be Equal    Required pass    ${response.json()}[error]
