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
    
    Remove User By Email        ${user}[email]
    #Delete One        ${MONGODB}    

    Start Session
    Go to signup
    Register user           ${user}
    Notice should be        Boas vindas ao Mark85, o seu gerenciador de tarefas.


Usuário duplicado
    [Tags]    dup
    
    &{user}        Create Dictionary    
    ...    name=Jean Gray    
    ...    email=fenix@xmen.com       
    ...    password=pwd123
    
    Remove User By Email        ${user}[email]
    
    Start Session
    Go to signup
    Register user        ${user}
    Register user        ${user}
    Notice should be        Oops! Já existe um cadastro com e-mail informado.


Nome deve ser obrigatório
    [Tags]    nomeobr
    &{user}   Create Dictionary
    ...    name=
    ...    email=abc@abc.com
    ...    password=999

    Start Session
    Go to signup
    Register User        ${user}
    Alert should be        Informe seu nome completo             

Email deve ser obrigatório
    [Tags]    emailobr

    &{user}=        Create Dictionary    
    ...    name=Thais Ota
    ...    email=
    ...    password=888
         
    Start Session
    Go to signup
    Register user       ${user}
    Alert should be     Informe seu e-email

Senha deve ser obrigatória
    [Tags]    senhaobr

    &{user}=        Create Dictionary    
    ...    name=Thais Ota
    ...    email=abc@abc.com    
    ...    password=
         
    Start Session
    Go to signup
    Register user       ${user}
    Alert should be     Informe uma senha com pelo menos 6 digitos