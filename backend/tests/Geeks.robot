*** Settings ***
Documentation       Geek route test suite

Resource            ../resources/Base.robot
Library             Browser


*** Test Cases ***
Be a geek
# Given that we have a registered user
    ${user}    Factory Be Geek
    Remove User    ${user}

# And he is a normal user
    POST User    ${user}

# And the user have a valid token
    ${token}    Get Token    ${user}

# When executing a POST request to /geeks
    ${response}    POST Geek    ${token}    ${user}[geek_profile]

# Status code 201 should be returned
    Status Should Be    201    ${response}

# And searching for this user inside Users API
    ${response}    GET User    ${token}

# Then a geek profile should be returned
    Should Be Equal As Strings    ${user}[name]    ${response.json()}[name]
    Should Be Equal As Strings    ${user}[email]    ${response.json()}[email]

    Should Be Equal As Strings    ${user}[geek_profile][whatsapp]    ${response.json()}[whatsapp]
    Should Be Equal As Strings    ${user}[geek_profile][desc]    ${response.json()}[desc]

    # cost value is retuned as fload so we add a conversor to turn the input to float as well
    ${cost_float}    Convert To Number    ${user}[geek_profile][cost]
    ${got_float}    Convert To Number    ${response.json()}[cost]

    Should Be Equal    ${cost_float}    ${got_float}
    Should Be Equal As Strings    ${user}[geek_profile][printer_repair]    ${response.json()}[printer_repair]
    Should Be Equal As Strings    ${user}[geek_profile][work]    ${response.json()}[work]
    Should Be Equal As Strings    None    ${response.json()}[avatar]
    Should Be Equal As Strings    True    ${response.json()}[is_geek]

Get Geek List
    [Tags]    temp

    ${data}    Factory Search For Geeks

    FOR    ${geek}    IN    @{data}[geeks]
        POST User    ${geek}
        ${token}    Get Token    ${geek}

        POST Geek    ${token}    ${geek}[geek_profile]
    END

    POST User    ${data}[user]

    ${token}    Get Token    ${data}[user]

    ${response}    GET Geeks    ${token}
    Status Should Be    200    ${response}

    ${total}    Get Length    ${response.json()}[Geeks]
    Should Be True    ${total} > 0
