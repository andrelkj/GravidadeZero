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
- [Usefull terminal commands](#usefull-terminal-commands)
  - [chmod +x run.sh](#chmod-x-runsh)
- [Important links](#important-links)

---
# Notes

Here we're going to automate the web application [Getgeeks](https://geeks-web-andre.fly.dev/signup) geratered using Fly that is connect to a PostgreSQL database. We're also using ElephantSQL to manage our database.

We'll use Gherkin to define our test scenarios following Behaviour Driven Development (BDD) standards. 

BDD is a colaborative specification technique where development driven scenarios are written considering the final users` point of view in order to give a better undertanding and clear informations to facilitate development and also testing after all. BDD is used to guide the development, not only testing automation and should be defined before starting the development. 

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

We'll use *PascalCase* in here to define files and *snake_case* to define methods,

## Actions

It's very important to consider the creation of actions for repetitive steps from the start in order to arrange the code properly and make it easier to use the same actions in different scenarios. 

**Note:**
<p>One way of doing it is by considering each step of the BDD as a action.</p>

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
Arguments can be used to reduce reuse and facilitate code maintenance once it's necessary to update and/or change only one element. For example:

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

Factories are used to avoid the need of entering all testing set of information individually for each element. It works by defining a factory (factory_user) and then defining all arguments (test dough) inside a varible (user) which will be returned as response. **For example:** [Users factory](resources/factories/Users.py)

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
It is possible to define several steps inside a keyword and then use template to indicate that the test case should follow those steps one at a time following exactly what is defined inside the keyword. This allows us to repeat several cenários changing only the test variable.

**Important:** template will only work if all conditions are exactly equal to one another

---
# Database.robot
Here we're creating a task that will return the application to default. Meaning that after running all database entered information will be deleted and the application will run as if it was the first time.

**Important:** always disconnect from data base after finishing the task. (BEST PRACTICE)

**Note:** always consider password_dash instead of password while dealing with databases as it uses encripted passwords

---
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
# Important links
- [Web application](https://geeks-web-andre.fly.dev/signup)
- [ElephantSQL](https://api.elephantsql.com/console/51ccfaa2-d261-4503-b858-da3b75125790/browser?#)
- [QAcademy course](https://app.qacademy.io/area/produto/item/149046)
- [Faker Library](https://pypi.org/project/Faker/)