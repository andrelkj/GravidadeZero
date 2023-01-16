*** Settings ***
Documentation       Signup Test Suite

Resource            ../resources/Base.robot

Test Setup          Start Section
Test Teardown       Finish Section


*** Test Cases ***
Register a new user
# Entering test data mass
    ${user}    Factory User

# Once I enter register page
    Go To Signup Form

# When entering input information
    # Checkpoint - going to register page
    Fill Signup Form    ${user}

# And submiting valid information
    Submit Signut Form

# Then I should register the user and see the welcome message
    User Should Be Registered
