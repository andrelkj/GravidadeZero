*** Settings ***
Documentation       Signup Test Suite

Resource            ../resources/Base.robot

Test Setup          Start Section
Test Teardown       Finish Section


*** Test Cases ***
Register a new user
# Entering test data mass
    ${user}    Factory User    faker

# Armazena o usuário na variável e reutiliza ele onde mencionado
    Set Suite Variable    ${user}

# Once I enter register page
    Go To Signup Form

# When entering input information
    # Checkpoint - going to register page
    Fill Signup Form    ${user}

# And submiting valid information
    Submit Signut Form

# Then I should register the user and see the welcome message
    User Should Be Registered

Duplicate User
    [Tags]    attempt_signup

    # pre-conditiions for the test case to work
    ${user}    Factory User    faker
    Add User From Database    ${user}

    Go To Signup Form
    Fill Signup Form    ${user}
    Submit Signut Form
    Modal Content Should Be    Já temos um usuário com o e-mail informado.

Wrong Email
    [Tags]    attempt_signup

    ${user}    Factory User    wrong_email

    Go To Signup Form
    Fill Signup Form    ${user}
    Submit Signut Form
    Alert Span Should Be    O email está estranho

Required Fields
    [Tags]    attempt_signup    required_fields
# Template shouldn't be used here because it will execute the hole process 4 times instead of validating all at once

    @{expected_alerts}    Create List
    ...    Cadê o seu nome?
    ...    E o sobrenome?
    ...    O email é importante também!
    ...    Agora só falta a senha!

    Go To Signup Form
    Submit Signut Form
    Alert Spans Should Be    ${expected_alerts}

Short Password
    [Tags]    attempt_signup    short_pass
    [Template]    Signup With Short Password
    1
    12
    123
    1234
    12345
    a
    a2
    ab3
    ab3c
    a23bc
    -1
    acb#1


*** Keywords ***
Signup With Short Password
    [Arguments]    ${short_pass}

    ${user}    Create Dictionary
    ...    name=Test    lastname=User
    ...    email=test@email.com
    ...    password=${short_pass}

    Go To Signup Form
    Fill Signup Form    ${user}
    Submit Signut Form
    Alert Span Should Be    Informe uma senha com pelo menos 6 caracteres
