*** Settings ***
Documentation       Users route test suite

Resource            ../resources/Base.robot


*** Test Cases ***
Add new user
    ${user}    Factory New User

    Remove User    ${user}

    ${response}    POST User    ${user}
    Status Should Be    201    ${response}

    # get the id value from API's response and store it inside a variable
    ${user_id}    Set Variable    ${response.json()}[id]
    Should Be True    ${user_id} > 0

Get user data
    ${user}    Factory Get User
    # Remove User    ${user}
    POST User    ${user}

    ${token}    Get Token    ${user}
    ${response}    GET User    ${token}
    Status Should Be    200    ${response}

    Should Be Equal As Strings    ${user}[name]    ${response.json()}[name]
    Should Be Equal As Strings    ${user}[email]    ${response.json()}[email]

    Should Be Equal As Strings    None    ${response.json()}[whatsapp]
    Should Be Equal As Strings    None    ${response.json()}[avatar]
    Should Be Equal As Strings    False    ${response.json()}[is_geek]
