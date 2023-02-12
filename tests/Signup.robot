*** Settings ***
Documentation       Signup Test Suite

Resource            ../resources/Base.robot
Resource            ../resources/Actions.robot
Resource            ../resources/Helpers.robot

Test Setup          Start Section
Test Teardown       Finish Section


*** Test Cases ***
Register a new user
# Entering test data mass
    ${user}    Factory User

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
    ${user}    Factory User
    Add User From Database    ${user}

    Go To Signup Form
    Fill Signup Form    ${user}
    Submit Signut Form
    Modal Content Should Be    Já temos um usuário com o e-mail informado.

Wrong Email
    [Tags]    attempt_signup

    ${user}    Factory Wrong Email

    Go To Signup Form
    Fill Signup Form    ${user}
    Submit Signut Form
    Field Notiication Should Be    O email está estranho

Empty Fields
    [Tags]    attempt_signup    required_fields

    Go To Signup Form
    Submit Signut Form
    Field Notiication Should Be    Cadê o seu nome?
    Field Notiication Should Be    E o sobrenome?
    Field Notiication Should Be    O email é importante também!
    Field Notiication Should Be    Agora só falta a senha!