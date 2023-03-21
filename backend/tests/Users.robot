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

Remove user
    # Given that the user exists in the system
    ${user}    Factory Remove User
    # Remove User    ${user}
    POST User    ${user}

    # And I have this user token
    ${token}    Get Token    ${user}

    # When executing a delete request to /users
    ${response}    DELETE User    ${token}

    # Status code 204 (no contet) should be returned
    Status Should Be    204    ${response}

    # And while executing a new GET request to /users with the same token should return status code 404 (not found)
    ${response}    GET User    ${token}
    Status Should Be    404    ${response}

Update a user
    ${user}    Factory Update User
    POST User    ${user}[before]

    ${token}    Get Token    ${user}[before]

    ${response}    PUT User    ${token}    ${user}[after]

    Status Should Be    200    ${response}

    ${response}    GET User    ${token}

    Should Be Equal As Strings    ${user}[after][name]    ${response.json()}[name]
    Should Be Equal As Strings    ${user}[after][email]    ${response.json()}[email]

    Should Be Equal As Strings    ${user}[after][whatsapp]    ${response.json()}[whatsapp]
    Should Be Equal As Strings    ${user}[after][avatar]    ${response.json()}[avatar]
    Should Be Equal As Strings    False    ${response.json()}[is_geek]