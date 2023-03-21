*** Settings ***
Documentation       Base test

Library             RequestsLibrary
Library             factories/Users.py
Resource            routes/SessionsRoute.robot
Resource            routes/UsersRoute.robot
Resource            routes/GeeksRoute.robot
Resource            Helpers.robot


*** Variables ***
${API_USERS}    https://geeks-api-andre.fly.dev
${API_GEEKS}    https://geeks-api-andre.fly.dev
