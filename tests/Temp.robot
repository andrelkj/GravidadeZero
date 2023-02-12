*** Settings ***
Documentation       Temp

Library             Collections


*** Test Cases ***
Working with Lists
    @{avengers}    Create List    Tony Stark    Kamalakhan    Steve Rogers

    Append To List    ${avengers}    Bruce Banner
    Append To List    ${avengers}    Scot Lang

    FOR    ${a}    IN    @{avengers}
        Log To Console    ${a}
    END

    @{avengers2}    Create List    Tony Stark    Miss Marvel    Steve Rogers    Bruce Banner    Scot Lang

    Lists Should Be Equal    ${avengers}    ${avengers2}    
