*** Settings ***
Documentation       Session route test suite

Resource            ../resources/Base.robot
Resource            ../resources/routes/SessionsRoute.robot


*** Variables ***
&{inv_pass}         email=test@email.com    password=abc123
&{inv_email}        email=test#email.com    password=abc123
&{email_404}        email=test@error.com    password=abc123
&{empty_email}      email=${EMPTY}    password=abc123
&{wo_email}         password=abc123
&{empty_pass}       email=test@email.com    password=${EMPTY}
&{wo_pass}          email=test@email.com


*** Test Cases ***
User session
# Given that I have a registered user
    ${payload}    Create Dictionary    name=Kate Bishop    email=kate@hotmail.com    password=pwd123
    POST User    ${payload}

    ${payload}    Create Dictionary    email=kate@hotmail.com    password=pwd123

# When executing a POST request to /session
    ${response}    POST Session    ${payload}

# Then the status code should be 200
    Status Should Be    200    ${response}

# And the token should be generated
    # Gets the token length and store it inside the size variable to furter validation
    ${size}    Get Length    ${response.json()}[token]

    # Get Length function returns an integer number data type while Should Be Equal function expects a string so we need to convert it to integer as well
    ${expected_size}    Convert To Integer    140

    Should Be Equal    ${expected_size}    ${size}

# And the generated token should expire in 10 days
    Should Be Equal    10d    ${response.json()}[expires_in]

Should Not Get Token
    [Template]    Attempt POST Session

    ${inv_pass}    401    Unauthorized
    ${inv_email}    400    Incorrect email
    ${email_404}    401    Unauthorized
    ${empty_email}    400    Required email
    ${wo_email}    400    Required email
    ${empty_pass}    400    Required pass
    ${wo_pass}    400    Required pass


*** Keywords ***
Attempt POST Session
    [Arguments]    ${payload}    ${status_code}    ${error_message}

    ${response}    POST Session    ${payload}

    Status Should Be    ${status_code}    ${response}
    Should Be Equal    ${error_message}    ${response.json()}[error]
