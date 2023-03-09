*** Settings ***
Documentation       Users route test suite

Resource            ../resources/Base.robot

*** Test Cases ***
Add new user

  ${payload}    Factory New User

  ${response}    POST User    ${payload}
  Status Should Be    201    ${response}