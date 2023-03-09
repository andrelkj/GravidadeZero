*** Settings ***
Documentation    Base test

Library    RequestsLibrary

Resource    routes/SessionsRoute.robot
Resource    routes/UsersRoute.robot

*** Variables ***
${API_USERS}    https://geeks-api-andre.fly.dev