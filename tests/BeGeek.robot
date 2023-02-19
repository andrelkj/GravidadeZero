*** Settings ***
Documentation       BeGeek Test Suite

Resource            ../resources/Base.robot
Library             Users

Test Setup          Start Section
Test Teardown       Finish Section


*** Test Cases ***
Be a Geek
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

Short Description
    ${user}    Factory User    short_desc
    Do Login    ${user}

    Go To Geek Form
    Fill Geek Form    ${user}[geek_profile]
    Submit Geek Form

    Alert Span Should Be    A descrição deve ter no minimo 80 caracteres

Lobg Description
    [Tags]    long_desc

    ${user}    Factory User    long_desc
    Do Login    ${user}

    Go To Geek Form
    Fill Geek Form    ${user}[geek_profile]
    Submit Geek Form

    Alert Span Should Be    A descrição deve ter no máximo 255 caracteres
