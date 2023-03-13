*** Settings ***
Documentation       Helpers

Resource            Base.robot


*** Keywords ***
Get Token
    [Arguments]    ${user}

    # Getting the user token
    ${payload}    Create Dictionary    email=${user}[email]    password=${user}[password]

    ${response}    POST Session    ${payload}
    ${result}    Set Variable    ${EMPTY}

    IF    "200" in "${response}"
        # We also need to inform the Bearer carrier as well
        ${result}    Set Variable    Bearer ${response.json()}[token]
    END

    [Return]    ${result}

Remove User
    [Arguments]    ${user}

    ${token}    Get Token    ${user}    

    IF    "${token}"
        # Delete from /user
        DELETE User    ${token}
    END
