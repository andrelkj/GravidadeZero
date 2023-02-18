# Summary

- [Summary](#summary)
- [Notes](#notes)
- [Structure](#structure)
  - [Actions](#actions)
    - [Arguments](#arguments)
    - [Tags](#tags)
  - [Factories](#factories)
    - [Faker Library](#faker-library)
  - [Template](#template)
- [Database.robot](#databaserobot)
- [SignupRequired.robot](#signuprequiredrobot)
- [Temp.robot](#temprobot)
  - [Loops](#loops)
  - [Keywords](#keywords)
- [Login.robot](#loginrobot)
- [BeGeek.robot](#begeekrobot)
  - [Filling type input elements](#filling-type-input-elements)
  - [Filling type select elements](#filling-type-select-elements)
  - [Submitting geek form and message validation](#submitting-geek-form-and-message-validation)
- [Usefull terminal commands](#usefull-terminal-commands)
  - [Git](#git)
  - [chmod +x run.sh](#chmod-x-runsh)
- [Challenge 1 - module PRO](#challenge-1---module-pro)
  - [Automate 3 new test cases inside the login suite:](#automate-3-new-test-cases-inside-the-login-suite)
- [Important links](#important-links)

---

# Notes

Here we're going to automate the web application [Getgeeks](https://geeks-web-andre.fly.dev/) geratered using Fly that is connect to a PostgreSQL database. We're also using ElephantSQL to manage our database.

We'll use Gherkin to define our test scenarios following Behaviour Driven Development (BDD) standards.

BDD is a colaborative specification technique where development driven scenarios are written considering the final users' point of view in order to give a better undertanding and clear informations to facilitate development and also testing after all. BDD is used to guide the development, not only testing automation and should be defined before starting the development.

**Example:** [Register notes](docs/signup.md)

```md
> Sendo um visitante que deseja contratar serviços de TI
> Posso fazer o meu cadastro
> Para que eu possa buscar por prestadores de serviços (Geeks)

##### Cenário: Cadastro de cliente

Dado que acesso a página de cadastro
Quando faço o meu cadastro com o nome completo, e-mail e senha
Então vejo a mensagem de boas vindas:
"Agora você faz parte da Getgeeks. Tenha uma ótima experiência."
```

We can list here our Sad scenarios, those cases that can lead to erros, as well:

```md
##### Cenário: E-mail duplicado

Dado que acesso a página de cadastro
Porem o meu e-mail já foi cadastrado
Quando faço o meu cadastro com o nome completo, e-mail e senha
Então vejo a mensagem de alerta:
"Oops! Já temos um usuário com o e-mail informado."

##### Cenário: Email com formato incorreto

Dado que acesso a página de cadastro
Quando faço o meu cadastro com um email incorreto
Então vejo a mensagem de alerta "O email está estranho"

##### Cenário: Campos obrigatórios

Dado que acesso a página de cadastro
Quando submeto o cadastro sem preencher o formulário
Então devo ver uma mensagem informando que todos os campos são obrigatórios
```

---

# Structure

We'll use _PascalCase_ in here to define files and _snake_case_ to define methods,

## Actions

It's very important to consider the creation of actions for repetitive steps from the start in order to arrange the code properly and make it easier to use the same actions in different scenarios.

**Note:**

<p>One way of doing it is by considering each step of the BDD as an action.</p>

**For example:** [Actions](resources/Actions.robot)

- Dado que acesso a página de cadastro

```
*** Keywords ***
Go to signup form
    Go To    https://geeks-web-andre.fly.dev/signup

    Wait For Elements State    .signup-form h1 >> text="Cadastro"    visible    5

```

- Quando faço o meu cadastro com o nome completo, e-mail e senha

```
# When entering input information
    # Checkpoint - going to register page
    Fill Signup Form    ${user}

# And submiting valid information
    Submit Signut Form
```

- Então vejo a mensagem de boas vindas:

```
# Then I should register the user and see the welcome message
    User Should Be Registered
```

**Important**

<p>One important thing to remember is that as actions will be defined inside a different file you need to add this as a Resource inside the Test case file and inside the Base file as well in order to integrate all the information.</p>

### Arguments

Arguments can be used to reduce reusage and facilitate code maintenance once it's necessary to update and/or change only one element. For example:

```
Modal Content Should Be
    [Arguments]    ${expected_text}

    ${title}    Set Variable    css=.swal2-title
    ${container}    Set Variable    css=.swal2-html-container

    Wait For Elements State    ${title}    visible    5
    Get Text    ${title}    equal    Oops...

    Wait For Elements State    ${container}    visible    5
    Get Text    ${container}    equal    ${expected_text}
```

### Tags

Tags can be used to identify one specific test case and allow you to run individual test cases by calling they're tags using:
`-i tag_name` before the test case name. For example:

```
Duplicate user
    [Tags]    dup_email

    Go To Signup Form
    Fill Signup Form    ${user}
    Submit Signut Form
    Modal Content Should Be    Já temos um usuário com o e-mail informado.
```

## Factories

Factories are used to avoid the need of entering all testing set of information individually for each element. It works by defining a factory (factory_user) and then defining all arguments (test dough) inside a variable (user) which will be returned as response. **For example:** [Users factory](resources/factories/Users.py)

```
# Defining test dough

def factory_user():
    user = {
        'name': 'Tony',
        'lastname': 'Stark',
        'email': 'tony@stark.com',
        'password': 'pwd123'
    }

    return user
```

Then we add this variable to an action, defining which argument to use for each case:

```
    Fill Text    input[id="name"]    ${user}[name]
    Fill Text    input[id="lastname"]    ${user}[lastname]
    Fill Text    input[id="email"]    ${user}[email]
    Fill Text    input[id="password"]    ${user}[password]
```

And finally we integrate this factory and insert it inside our test cases:

```
*** Test Cases ***
Register a new user
# Entering test data mass
    ${user}    Factory User

# Once I enter register page
    Go To Signup Form

# When entering input information
    # Checkpoint - going to register page
    Fill Signup Form    ${user}
```

### Faker Library

Faker is a python package used to create dynamic arguments, making it possible to test scenarios with different sets of information automatically created. This can be really usefull for scenarios where you need unique data like registering users, validating emails and so on.

To use it we just need to configure faker inside our factory file:
[Using Faker Library](https://pypi.org/project/Faker/)

```py
# Defining test dough

from faker  import  Faker
fake = Faker()

def factory_user():
    user = {
        'name': fake.first_name(),
        'lastname': fake.last_name(),
        'email': fake.free_email(),
        'password': 'pwd123'
    }

    return user
```

And then run the project again now using dynamic mass of test.

**Obs.:** using faker can create a massive amont of information inside the database, in order to avoid this we install 2 libraries:

- `pip install robotframework-databaselibrary` - Gives access to the database through robot
- `pip3 install psycopg2` - Connect to the postgreSQL database natively

## Template

It is possible to define several steps inside a keyword and then use template to indicate that the test case should follow those steps one at a time following exactly what is defined inside the keyword. This allows us to repeat several scenarios changing only the test variables.

To create a template we first need to define a new keyword with all desired steps:

```
*** Keywords ***
Signup With Short Password
    [Arguments]    ${short_pass}

    ${user}    Create Dictionary
    ...    name=Test    lastname=User
    ...    email=test@email.com
    ...    password=${short_pass}

    Go To Signup Form
    Fill Signup Form    ${user}
    Submit Signut Form
    Alert Span Should Be    Informe uma senha com pelo menos 6 caracteres
```

And then, call this template inside the test case that should reproduce the template behavior, informing all inputs as well:

```
Short Password
    [Tags]    attempt_signup    short_pass
    [Template]    Signup With Short Password
    1
    12
    123
    1234
    12345
    a
    a2
    ab3
    ab3c
    a23bc
    -1
    acb#1
```

**Important:** template will only work if all conditions are exactly equal to one another. Another way to add these repetitive structures, is by using suite setups that will be explained better in the Signup.robot section.

---

# Database.robot

Here we're creating a task that will return the application to default and then configurate all required information to run our tests. Meaning that after running all database entered information will be deleted and the application will run as if it was the first time.

**Important:** always disconnect from the database after finishing the task. (BEST PRACTICE)

**Note:** always consider password_dash instead of password while dealing with databases as it uses encripted passwords

For the register test cases we were using a forced hardcoded password inside the database.

```
Insert User
    [Arguments]    ${u}
# password must be encripted to a successfull login

    ${q}    Set Variable
    ...    INSERT INTO public.users (name, email, password_hash, is_geek) values ('${u}[name] ${u}[lastname]', '${u}[email]', '${u}[password]', false)

    Execute SQL String    ${q}
```

While creating the login test case it won't work because of the password integrity, so we'll need to now update our test to consider the encripted password instead of the hardcoded one.

---

# SignupRequired.robot

The use of templates are not recommended in same cases because it will run all the steps as they come. Using required fields as example the test case will open a new browser tab and start the hole process all over for each conditions, instead of validation all of them at once, even considering that they're all being shown in the same page.

One way to deal and improve templates is by defining a hole test suite using test cases and defining all steps inside a keyword. The key here is to use the `Suite Setup` as start point instead of the previous Test Setup. It will allow all test cases to run one after another without the need to close and open tabs every time.

**Example:**

```
*** Settings ***
Documentation       Signup Test Suite

Resource            ../resources/Base.robot

Suite Setup         Signup Without Fill Form    # execute the setup once for suite and not for test as used before
Test Teardown       Finish Section

*** Test Cases ***
Name is required
    Alert Span Should Be    Cadê o seu nome?
Lastname is required
    Alert Span Should Be    -Remover esse texto- E o sobrenome?
Email is required
    Alert Span Should Be    O email é importante também!
Password is required
    Alert Span Should Be    Agora só falta a senha!

# Testing all forms all together using form
*** Keywords ***
Signup Without Fill Form

    Start Section
    Go To Signup Form
    Submit Signut Form
```

---

# Temp.robot

Tabulation is essential for lists functioning

By using `@{name}` robot will consider this as a temporary element. Yet to call it as a variable we need to use the `${name}`

## Loops

It is possible to use FOR to create a loop that will be executed until there's no more element available to use

**Example:**

```
Working with Lists

    @{avengers}    Create List    Tony Stak    Kamalakhan    Steve Rogers

    Append To List    ${avengers}    Hulk

      FOR    ${a}    IN    @{avengers}
          Log To Console   ${a}

      END
```

**Note:** Here all individual list elements 'a' inside the avengers list will be logged into console one by one until there's no more elements available.

## Keywords

Append To List allows us to add a new element to the list. Example:

```
Working with Lists

    @{avengers}    Create List    Tony Stak    Kamalakhan    Steve Rogers

    Append To List    ${avengers}    Hulk

    Log To Console  ${avengers}[0]
    Log To Console  ${avengers}[1]
    Log To Console  ${avengers}[2]
```

**Important:** to use this arguments we need to import the library Collections from Robot

---

# Login.robot

Tooltip cannot be inspected as it isn't part of the code, instead it is a browser navigator response that cannot be used as selector. This happens when the input type is defined as email and one solution is to:

Create a new keyword to validate the element type inside the code:

```
Should Be Type Email
    Get Property    id=email    type    equal    email
```

And adding it to our test case:

```
Incorrect Email
    [Tags]    incorrect_email

    ${user}    Create Dictionary    email=invalid.format.com    password=pwd123

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Should Be Type Email
```

**Important:** global variables should be used wisely, but one best practice is to create a global variable for global elements that repeat themselves throughout the code. In this example we created the `${INPUT_PASS}` global variable as well just for a visual purpose.

---

# BeGeek.robot

Do Login variable is added in order to facilitate login functionality. The login helper cannot be used inside login test suite because we're validating the login process step by step, then we'll need separated steps to test all functionality coverage.

For the geek form we'll need to fill 5 different fields, in order to do it properly we'll update our test dough generator factory_user_be_geek by adding the sub-dictionary geek_profile inside Users.py:

```
def factory_user_be_geek():
    return {
        'name': 'Kim',
        'lastname': 'Dotcom',
        'email': 'kim@dot.com',
        'password': 'pwd123',
        'geek_profile': {
            'whats': '11999999999',
            'desc': 'Seu computador está lento? Reiniciando do nada? Talvez seja um vírus, ou algum hardware com defeito. Posso fazer a manutenção no seu PC, formatando, reinstalando o SO, trocando algum componente físico e porque não remover o baidu ou qualquer outro malware.',
            'printer_repair': 'Sim',
            'work': 'Remote',
            'cost': '100'
        }
```

To define the elements name we normally use those defined inside the HTML, for example:

Description's field HTML:

```html
<div class="sc-kstqJO hxBQUd">
  <label for="desc">Descrição</label><textarea id="desc"></textarea>
</div>
```

**Note:** here the id selector "desc" is used.

## Filling type input elements

```
Fill Geek Form
    [Arguments]    ${geek_profile}

    Fill Text    id=whatsapp    ${geek_profile}[whats]
    Fill Text    id=desc    ${geek_profile}[desc]

    Fill Text    id=cost    ${geek_profile}[cost]
```

## Filling type select elements

```
Fill Geek Form
    [Arguments]    ${geek_profile}

    Select Options By    id=printer_repair    value    ${geek_profile}[printer_repair]
    Select Options By    id=work    value    ${geek_profile}[work]
```

## Submitting geek form and message validation

First we'll define new keywords for the desired steps:

```
Submit Geek Form
    Click    css=button >> text=Quero ser um Geek

Geek Form Should Be Success
    ${expected_message}    Set Variable
    ...    Seu cadastro está na nossa lista de geeks. Agora é só ficar de olho no seu WhatsApp.

    Wait For Elements State    css=p >> text=${expected_message}    visible    5
```

Finally we'll add it to our, now complete, be a geek test case:

```
*** Test Cases ***
Be a Geek
    # Given that I have a common user
    ${user}    Factory User Be Geek

    # And I log in the plataform Getgeeks
    Do Login    ${user}

    # When submitting the form to become a Geek (service provider)
    Go To Geek Form
    Fill Geek Form    ${user}[geek_profile]
    Submit Geek Form

    # Then I should see the success message
    Geek Form Should Be Success
```

**Note:** the gherkin BDD usage here isn't considering the automation but the expected scenario behavior, that then guide the automation development. Differently from cucumber that needs structured language to define the automation steps, this method gives a more flexible way of steps description without lossing functionality and flow details.

# Usefull terminal commands

- robot -l NONE tasks/Delorean.robot - runs the file without generating log. It's mostly used for tasks.
- robot --help - show all possible commands with detailed description
- robot -o NONE - runs the file without generating output
- robot -r NONE - runs the file witout generating report
- robot -i tags_name - runs only test cases that contains the defined tag
- chmod +x run.sh - gives file "run.sh" permition to be executed. Turns the file executable. **Works for linux based terminals**
- ./run.sh - runs a file inside the actual file path
- run.bat - runs terminal shortcuts **This works for MS-DOS based terminals**
- .lower() - python method to turn text onto lower case only

## Git

git init - initialize the git repository
git status - return repository and files status
git add . - add all pending changes to the staged file
git commit -m 'message' - commit all staged changes and define a message to the commit
git pull - pull github updates to the local environment
git push - push local updates to the github environment

## chmod +x run.sh

files.sh only runs in linux compatible terminals, for terminals MS-DOS based we need to use a file.bat which will then need additional changes. **For example:**

Files path uses \ instead of /:

```
robot -l NONE -o NONE -r NONE tasks\Delorean.robot
robot -d ./logs tests\Signup.robot
```

And also a different way of calling it:

```
run.bat
```

---

# Challenge 1 - module PRO

## Automate 3 new test cases inside the login suite:

- Required email

Given that I an inside the login page
When the email field is empty
And I submit the login button
Then a required field message is displayed
"E-mail obrigatório"

- Required password

Given that I an inside the login page
When the password field is empty
And I submit the login button
Then a required field message is displayed
"Senha obrigatório"

- Required fields

Given that I an inside the login page
When both email and password fields are empty
And I submit the login button
Then a required field message is displayed for each field
"E-mail obrigatório" and "Senha obrigatório"

---

# Important links

- [Web application](https://geeks-web-andre.fly.dev/signup)
- [ElephantSQL](https://api.elephantsql.com/console/51ccfaa2-d261-4503-b858-da3b75125790/browser?#)
- [QAcademy course](https://app.qacademy.io/area/produto/item/149046)
- [Faker Library](https://pypi.org/project/Faker/)
