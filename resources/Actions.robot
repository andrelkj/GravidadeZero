*** Settings ***
Documentation       Actions

Resource            Base.robot


*** Keywords ***
Go To Signup Form
    Go To    ${BASE_URL}

    Wait For Elements State    css=.signup-form h1 >> text="Cadastro"    visible    5

Fill Signup Form
    [Arguments]    ${user}

    Fill Text    input[id="name"]    ${user}[name]
    Fill Text    input[id="lastname"]    ${user}[lastname]
    Fill Text    input[id="email"]    ${user}[email]
    Fill Text    input[id="password"]    ${user}[password]

Submit Signut Form
    Click    css=.submit-button >> text="Cadastrar"

User Should Be Registered
    ${expect_message}    Set Variable
    ...    css=div p >> text="Agora você faz parte da Getgeeks. Tenha uma ótima experiência."

    Wait For Elements State    ${expect_message}    visible    5

Modal Content Should Be
    [Arguments]    ${expected_text}

    ${title}    Set Variable    css=.swal2-title
    ${container}    Set Variable    css=.swal2-html-container

    Wait For Elements State    ${title}    visible    5
    Get Text    ${title}    equal    Oops...

    Wait For Elements State    ${container}    visible    5
    Get Text    ${container}    equal    ${expected_text}

Field Notiication Should Be
    [Arguments]    ${expected_notice}

    Wait For Elements State    css=span[class=error] >> text=${expected_notice}    visible    5
