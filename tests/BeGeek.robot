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
    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    User Should Be Logged In    ${user}

    # When submitting the form to become a Geek (service provider)

    # Then I should see the success message
