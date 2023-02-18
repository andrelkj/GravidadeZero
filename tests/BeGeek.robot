*** Settings ***
Documentation       BeGeek Test Suite

Resource            ../resources/Base.robot

Test Setup          Start Section
Test Teardown       Finish Section


*** Test Cases ***
Be a Geek
    # Given that I have a common user
    ${user}    Factory User Be Geek

    # And I log in the plataform Getgeeks
    Do Login    ${user}

    # When submitting the form to become a Geek (service provider)
    Go To Geek Form
    Fill Geek Form    ${user}[geek_profile]
    Submit Geek Form

    # Then I should see the success message
    Geek Form Should Be Success


*** Keywords ***
Go To Geek Form
    Click    css=a[href="/be-geek"] >> text=Seja um Geek

    Wait For Elements State    css=.be-geek-form    visible    5
