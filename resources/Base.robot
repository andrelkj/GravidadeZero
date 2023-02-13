*** Settings ***
Documentation       Base Test

Library             Browser
Library             Collections
Library             factories/Users.py
Resource            actions/AuthActions.robot
Resource            actions/SignupActions.robot
Resource            Database.robot
Resource            Helpers.robot


*** Variables ***
${BASE_URL}     https://geeks-web-andre.fly.dev


*** Keywords ***
Start Section
    New Browser    chromium    headless=false    slowMo=00:00:00
    New Page    ${BASE_URL}

Finish Section
    Take Screenshot
