### User Story - Client login

> Being a user trying to access the logged in environment
> Leaving empty fields
> Return required fields message

##### Scenario: Required email

Given that I an inside the login page
When the email field is empty
And I submit the login button
Then a required field message is displayed
"E-mail obrigatório"

##### Scenario: Required password

Given that I an inside the login page
When the password field is empty
And I submit the login button
Then a required field message is displayed
"Senha obrigatória"

##### Scenario: Required fields

Given that I an inside the login page
When both email and password fields are empty
And I submit the login button
Then a required field message is displayed for each field
"E-mail obrigatório" and "Senha obrigatória"

### Notes

Fill Credentials is not necessary once we'bb be testing the input validation without entered data.

A list was created with all expected alerts:

```
  @{expected_alerts}    Create List
  ...    E-mail obrigatório
  ...    Senha obrigatória
```

**Note:** the list usage is important in here because both cases will be tested even if one of them fail.

Then we reused the variable Alert Spans Should Be to validate the elements inside the list of alerts

```
  Go To Login Page
  Submit Credentials
  Alert Spans Should Be    ${expected_alerts}
```

Both Alert Span Should Be and Alert Spans Should Be we're transfered to SharedActions file once they're now shared between the login and signup test suites
