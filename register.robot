*** Settings ***
Documentation       I should be able to register a client

Resource            base.robot

Test Setup          Start Section
Test Teardown       End Section


*** Test Cases ***
Should register a client

# Once I enter register page
    Click    css=span a[href="/signup"]

# When entering input information
    # Checkpoint - going to register page
    Wait For Elements State    .signup-form h1    visible    5
    Fill Text    input[id="name"]    Name1
    Fill Text    input[id="lastname"]    Lastname1
    Fill Text    input[id="email"]    email@test1.com
    Fill Text    input[id="password"]    pwd123

# And submiting valid information
    Click    css=.submit-button

# Then I should register the user and see the welcome message
    Wait For Elements State    
...    css=div p >> text="Agora você faz parte da Getgeeks. Tenha uma ótima experiência."
