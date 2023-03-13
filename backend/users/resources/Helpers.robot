*** Settings ***
Documentation       Helpers

Resource            Base.robot


*** Keywords ***
Remove User
    [Arguments]    ${user}

    # Getting the user token
    ${payload}    Create Dictionary    email=${user}[email]    password=${user}[password]
    ${response}    POST Session    ${payload}

    IF    "200" in "${response}"
        # We also need to inform the Bearer carrier as well
        ${token}    Set Variable    Bearer ${response.json()}[token]

        # Delete from /user
        DELETE User    ${token}
    END
