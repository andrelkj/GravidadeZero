*** Settings ***
Documentation       Test Helpers

Resource    Actions.robot

*** Keywords ***
Add User
    [Arguments]    ${user}

    Go To Signup Form
    Fill Signup Form    ${user}
    Submit Signut Form
    User Should Be Registered
