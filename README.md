# Summary
- [Summary](#summary)
- [Notes](#notes)
- [Structure](#structure)
  - [Actions](#actions)
  - [Factories](#factories)
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

**For example:**
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

## Factories

Factories are used to avoid the need of entering all testing set of information individually for each element. It works by defining a factory (factory_user) and then defining all arguments (test dough) inside a varible (user) which will be returned as response. **For example:**

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

---
# Important links
- [Web application](https://geeks-web-andre.fly.dev/signup)
- [ElephantSQL](https://api.elephantsql.com/console/51ccfaa2-d261-4503-b858-da3b75125790/browser?#)
- [QAcademy course](https://app.qacademy.io/area/produto/item/149046)