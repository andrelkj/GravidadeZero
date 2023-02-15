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
