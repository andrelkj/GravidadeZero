*** Settings ***
Documentation       Base

Library             Browser
Library             factories/Users.py

Resource    Actions.robot
Resource    Database.robot
Resource    Helpers.robot


*** Variables ***
${BASE_URL}     https://geeks-web-andre.fly.dev/signup


*** Keywords ***
Start Section
    New Browser    chromium    headless=false    slowMo=00:00:00
    New Page    ${BASE_URL}

Finish Section
    Take Screenshot
