*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections

*** Variables ***
${base_url}     http://localhost:8080

*** Test Cases ***
Scenario 1: Create new userAccounts(POST)
    create session  addUser   ${base_url}
    ${body}=    create dictionary   id=1  name=Generic Name   phone=999999999   email=genericname@company.com   address=Generic Street 42 Earth     country=Navarro     department=T21R
    ${header}=  create dictionary   Content-Type=application/json

    ${response}=    post request    addUser   /api/userAccounts/create     data=${body}    headers=${header}
    log to console  ${response.status_code}
    log to console  ${response.content}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    should be equal     ${status_code}      200

    ${res_boby}=    convert to string  ${response.content}
    should contain  ${res_boby}     User Account create success!!!


Scenario 2 Create second userAccounts(POST)
    create session  addSecondUser   ${base_url}
    ${body}=    create dictionary   id=2  name=Kuill   phone=99999999999999   email=genericname@company.com   address=Generic Street 42 Hoth     country=Arvala     department=T21R
    ${header}=  create dictionary   Content-Type=application/json

    ${response}=    post request    addUser   /api/userAccounts/create     data=${body}    headers=${header}
    log to console  ${response.status_code}
    log to console  ${response.content}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    should be equal     ${status_code}      400

    ${res_boby}=    convert to string  ${response.content}
    should contain  ${res_boby}     phone should be minimum 3 and maximum 12 characters long

Scenario 3 Update an existing userAccounts(PUT)
    create session  updateUser   ${base_url}

    ${body}=    create dictionary   id=1  name=Generic Name   phone=222222222   email=genericname@company.com   address=GGeneric Street 42 Earth     country=Navarro     department=T21R
    ${header}=  create dictionary   Content-Type=application/json

    ${response}=    put request    updateUser   /api/userAccounts/updateUserAccount/1     data=${body}    headers=${header}
    log to console  ${response.status_code}
    log to console  ${response.content}

    #Validations
    ${status_code}=     convert to string   ${response.status_code}
    should be equal     ${status_code}      200

    ${res_boby}=    convert to string  ${response.content}
    should contain  ${res_boby}     User Account with id 1 updated successful !!!


Scenario 4 Delete by ID (DELETE)
    create session  deleteUser   ${base_url}
    ${response}=    delete request  deleteUser    /api/userAccounts/userAccount/1

#Validations
    ${status_code}=     convert to string   ${response.status_code}
    should be equal     ${status_code}      200

    ${res_boby}=    convert to string  ${response.content}
    should contain  ${res_boby}     user Account 1 deleted


