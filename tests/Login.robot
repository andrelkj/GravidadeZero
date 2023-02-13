*** Settings ***
Documentation       Login Test Suite

Resource            ../resources/Base.robot

Test Setup          Start Section
Test Teardown       Finish Section


*** Test Cases ***
User Login
    Go To Login Page
    Fill Credentials    test@email.com    pwd123
    Submit Credentials
    User Should Be Logged In    Test User
