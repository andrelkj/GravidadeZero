*** Settings ***
Documentation       Login Test Suite

Resource            ../resources/Base.robot

Test Setup          Start Section
Test Teardown       Finish Section


*** Test Cases ***
User Login
    ${user}    Factory User Login

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    User Should Be Logged In    ${user}

Incorrect Pass
    [Tags]    incorrect_pass
# A template may be used in here but as it will have only 2 different cases it may not be necessary
    # [Template]    User not found
    # test@user.com    abc123
    # wrong_email@user.com    pwd123

    ${user}    Create Dictionary    email=test@user.com    password=abc123

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Modal Content Should Be    Usuário e/ou senha inválidos.

# *** Keywords ***

User not found
    [Tags]    user_404
    # [Arguments]    ${email}    ${password}

    # ${user}    Create Dictionary    email=${email}    password=${password}
    ${user}    Create Dictionary    email=test_404@email.com    password=pwd123

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Modal Content Should Be    Usuário e/ou senha inválidos.

Incorrect Email
    [Tags]    incorrect_email

    ${user}    Create Dictionary    email=invalid.email.com    password=pwd123

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Should Be Type Email

Required Email
    [Tags]    required_fields

    ${user}    Create Dictionary    email=${EMPTY}    password=abc123

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Alert Span Should Be    E-mail obrigatório

Required Password
    [Tags]    required_fields

    ${user}    Create Dictionary    email=test@email.com    password=${EMPTY}

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Alert Span Should Be    Senha obrigatória

Required Fields
    [Tags]    required_fields

    @{expected_alerts}    Create List
    ...    E-mail obrigatório
    ...    Senha obrigatória

    Go To Login Page
    Submit Credentials
    Alert Spans Should Be    ${expected_alerts}
