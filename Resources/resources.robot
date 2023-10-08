*** Settings ***
Library    OperatingSystem
Library    RequestsLibrary

*** Keywords ***
# Log my specific username and password 
#     [Arguments]    ${username}    ${password}
#     Log    ${username}
#     Log    ${password}

Log RestAPI Response to Console
    [Arguments]    ${response}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Log To Console    ${response.headers}

Clear Database
    POST    ${BASE_URL}/calculator/rakeDatabase
    Status Should Be    200

*** Variables ***
${BASE_URL}    http://localhost:8080
# ${MY-VARIAVLE}    my first variable

# @{LIST}    test1    test2    test 3

# &{DICTIONARY}    username=testuser    password=demo