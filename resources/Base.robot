*** Settings ***
Documentation       Base

Library             Browser
Library             factories/Users.py
Resource            Actions.robot


*** Keywords ***
Start Section
    New Browser    chromium    headless=false    slowMo=00:00:00.5
    New Page    https://geeks-web-andre.fly.dev

Finish Section
    Take Screenshot
