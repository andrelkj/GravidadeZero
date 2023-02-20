*** Settings ***
Documentation       BeGeek Test Suite

Resource            ../resources/Base.robot
Library             Users

Test Setup          Start Session
Test Teardown       Finish Session


*** Test Cases ***
Be a Geek
    [Tags]    smoke

    # Given that I have a common user
    ${user}    Factory User    be_geek

    # And I log in the plataform Getgeeks
    Do Login    ${user}

    # When submitting the form to become a Geek (service provider)
    Go To Geek Form
    Fill Geek Form    ${user}[geek_profile]
    Submit Geek Form

    # Then I should see the success message
    Geek Form Should Be Success
