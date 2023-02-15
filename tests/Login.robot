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

Required email
    [Tags]    required_fields

    ${user}    Create Dictionary    email=    password=pwd123

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Should Return Required Message    E-mail obrigatório

Required password
    [Tags]    required_fields

    ${user}    Create Dictionary    email=test@email.com    password=

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Should Return Required Message    Senha obrigatória

Required fields
    [Tags]    required_fields

    ${user}    Create Dictionary    email=    password=

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Should Return Required Message    E-mail obrigatório
    Should Return Required Message    Senha obrigatória
