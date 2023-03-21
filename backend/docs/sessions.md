<!-- Here I'll document our found bugs using the Gherkin approach in order to share it with the development team -->

<!-- **Notes:** in the Gherking approach, users are considered in the third person since the front-end assumes the first person by performing the system's actions -->

# API Users

Autor: Web application, Mobile or any other front-end source

## Sessions

### User login

```
Given that the user submitted the login form with valid data
When sending a POST requirement for /sessions path
Then I should receive the status code 200
And a JWT token should be returned in the response
And the token should expire in 10 days
```

### Wrong password

```
Given that the user submitted the login form with invalid password
When sending a POST requirement for /sessions path
Then I should receive the status code 401
And an "Unauthorized" message should be returned
```

### Unexistent user

```
Given that the user submitted the login form with unexisting email
When sending a POST requirement for /sessions path
Then I should receive the status code 401
And an "Unauthorized" message should be returned
```

### Invalid email format

```
Given that the user submitted the login form with invalid email format
When sending a POST requirement for /sessions path
Then I should receive the status code 400
And an "Incorrect email" message should be returned
```

### Blank email

```
Given that the user submitted the login form with invalid email format
When sending a POST requirement for /sessions path
Then I should receive the status code 400
And an "Required email" message should be returned
```

### Without email field - Null email

```
Given that the user submitted the login form with invalid email format
When sending a POST requirement for /sessions path
Then I should receive the status code 400
And an "Required email" message should be returned
```

### Blank password

```
Given that the user submitted the login form with invalid email format
When sending a POST requirement for /sessions path
Then I should receive the status code 400
And an "Required pass" message should be returned
```

### Without password field - Null password

```
Given that the user submitted the login form with invalid email format
When sending a POST requirement for /sessions path
Then I should receive the status code 400
And an "Required pass" message should be returned
```
