*** Settings ***
Documentation       Search for Geeks Test Suite

Resource            ../resources/Base.robot

Test Setup          Start Session
Test Teardown       After Test

*** Test Cases ***
Search for Alien Geek
    ${alien}    Factory User   search_alien

    Get Token    ${alien}