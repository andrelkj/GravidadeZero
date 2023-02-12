*** Settings ***
Documentation       Signup Test Suite

Resource            ../resources/Base.robot

Suite Setup         Signup Without Fill Form    # execute the setup once for suite and not for test as used before
Test Teardown       Finish Section

*** Test Cases ***
Name is required
    Alert Span Should Be    Cadê o seu nome?
Lastname is required
    Alert Span Should Be    -Remover esse texto- E o sobrenome?
Email is required
    Alert Span Should Be    O email é importante também!
Password is required
    Alert Span Should Be    Agora só falta a senha!

# Testing all forms all together using form
*** Keywords ***
Signup Without Fill Form

    Start Section
    Go To Signup Form
    Submit Signut Form