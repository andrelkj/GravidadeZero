*** Settings ***
Documentation       Signup Actions

Resource            ../Base.robot


*** Keywords ***
Go To Signup Form
    Go To    ${BASE_URL}/signup

    Wait For Elements State    css=.signup-form h1 >> text="Cadastro"    visible    5

Fill Signup Form
    [Arguments]    ${user}

    Fill Text    input[id="name"]    ${user}[name]
    Fill Text    input[id="lastname"]    ${user}[lastname]
    Fill Text    input[id="email"]    ${user}[email]
    Fill Text    input[id="password"]    ${user}[password]

Submit Signut Form
    Click    css=.submit-button >> text="Cadastrar"
