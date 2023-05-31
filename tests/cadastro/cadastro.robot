*** Settings ***   
Resource    ${EXECDIR}/resources/base.robot   
Resource    ../resources/pages/signup.robot
Resource    ../resources/base.robot
  
#Library              RobotMongoDBLibrary.Find

*** Variables ***
#&{MONGODB}=   connection=mongodb+srv://qax:<xperience>@cluster0.5jpw4ah.mongodb.net/?retryWrites=true&w=majority    database=markdb   collection=users
#&{user}=        name=Thais Ota    email=thaisota@live.com        password=pwd123

*** Test Cases ***
Deve cadastrar um novo usuário
    &{user}        Create Dictionary    
    ...    name=Thais Ota    
    ...    email=thaisota@live.com       
    ...    password=pwd123  
    
    #Delete One        ${MONGODB}    
    Remove User By Email            ${user}[email]

    Start Session
    Go to signup
    Register user        ${user}
    Notice should be     Boas vindas ao Mark85, o seu gerenciador de tarefas.


Usuário duplicado
    [Tags]    dup
    
    &{user}        Create Dictionary    
    ...    name=Jean Gray    
    ...    email=fenix@xmen.com       
    ...    password=pwd123
    
    Create new user    ${user}

    Start Session
    Go to signup
    Register user        ${user}
    Notice should be     Oops! Já existe um cadastro com e-mail informado.


Nome deve ser obrigatório
    [Tags]    required
    
    &{user}         Create Dictionary
    ...    name=${EMPTY}
    ...    email=fenix@xmen.com
    ...    password=pwd123

    Start Session
    Go to signup
    Register user        ${user}
    Alert should be      Informe seu nome completo            


Email deve ser obrigatório
    [Tags]    required

    &{user}         Create Dictionary
    ...    name=Steve Jobs
    ...    email=${EMPTY}
    ...    password=pwd123

    Start Session
    Go to signup
    Register user        ${user}
    Alert should be      Informe seu e-email


Senha deve ser obrigatória
    [Tags]    required

    &{user}         Create Dictionary
    ...    name=Steve Jobs
    ...    email=jobs@apple.com
    ...    password=${EMPTY}

    Start Session
    Go to signup
    Register user        ${user}
    Alert should be      Informe uma senha com pelo menos 6 digitos

