*** Settings ***
Documentation       Shared Actions

Resource            ../Base.robot


*** Keywords ***
Modal Content Should Be
    [Arguments]    ${expected_text}

    ${title}    Set Variable    css=.swal2-title
    ${container}    Set Variable    css=.swal2-html-container

    Wait For Elements State    ${title}    visible    5
    Get Text    ${title}    equal    Oops...

    Wait For Elements State    ${container}    visible    5
    Get Text    ${container}    equal    ${expected_text}

Alert Span Should Be
    [Arguments]    ${expected_alert}

    Wait For Elements State    css=span[class=error] >> text=${expected_alert}    visible    5

Alert Spans Should Be
    [Arguments]    ${expected_alerts}

    @{got_alerts}    Create List

    ${spans}    Get Elements
    ...    xpath=//span[@class="error"]
    # there's no need to use @{spans} in here because Get Elements already returns a ready to use list

    FOR    ${span}    IN    @{spans}
        ${text}    Get Text    ${span}
        Append To List    ${got_alerts}    ${text}
    END

    Lists Should Be Equal    ${expected_alerts}    ${got_alerts}
