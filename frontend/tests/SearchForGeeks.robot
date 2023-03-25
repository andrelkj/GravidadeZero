*** Settings ***
Documentation       Search for Geeks Test Suite

Resource            ../resources/Base.robot

Test Setup          Start Session
Test Teardown       After Test


*** Test Cases ***
Search for Alien Geek
    ${alien}    Factory User    search_alien
    Create Geek Profile Service    ${alien}

    ${searcher}    Factory User    searcher
    Do Login    ${searcher}

    Go To Geeks
    Fill Search Form    Sim    Matricial a fita colorida
    Submit Search Form

    Geek Should Be Found    ${alien}
    Alien Icon Should Be Visible
