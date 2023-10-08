*** Settings ***
Resource    ../Resources/resources.robot
Library    SeleniumLibrary
Library    ../Resources/CalculateRelief.py

*** Test Cases ***
Insert a single record of working class hero into database via API
    [Tags]    userstory1
    Clear Database
    ${body}=    Create Dictionary    birthday=12121991    gender=M    name=heroTwo    natid=123456    salary=123456    tax=1234
    ${headers}=    Create Dictionary    Content-Type=application/json   
    Log To Console    ${body}
    Log To Console    ${headers}
    ${response}=    POST    ${BASE_URL}/calculator/insert    json=${body}    headers=${headers}
    Log RestAPI Response to Console    ${response}

    # VALIDATIONS
    Should Be Equal As Integers     ${response.status_code}    202
    Should Be Equal As Strings    ${response.content}    Alright

    Clear Database


Insert multiple records of working class heros into database via API
    [Tags]    userstory2
    Clear Database
    ${hero1}=    Create Dictionary    birthday=12121991    gender=M    name=heroTwo    natid=123456    salary=123456    tax=1234
    ${hero2}=    Create Dictionary    birthday=12121991    gender=M    name=heroTwo    natid=123456    salary=123456    tax=1234
    ${hero3}=    Create Dictionary    birthday=12121991    gender=M    name=heroTwo    natid=123456    salary=123456    tax=1234
    ${body}=    Create List    ${hero1}    ${hero2}    ${hero3}
    ${headers}=    Create Dictionary    Content-Type=application/json
    Log To Console    ${body}
    ${response}=    POST    ${BASE_URL}/calculator/insertMultiple    json=${body}    headers=${headers}
    Log RestAPI Response to Console    ${response}

    # VALIDATIONS
    Should Be Equal As Integers    ${response.status_code}    202
    Should Be Equal As Strings    ${response.content}    Alright

    Clear Database

Upload a csv file via UI
    [Tags]    userstory3
    Clear Database
    Open Browser    ${BASE_URL}    chrome
    Maximize Browser Window
    ${input_portal}=    Get WebElement    //input[@class='custom-file-input']
    Choose File    ${input_portal}    ${CURDIR}${/}testdata.csv
    Click Element    //span[@class='input-group-text']
    Sleep    5

    # VALIDATIONS
    ${response}=    GET    ${BASE_URL}/calculator/taxRelief
    Log RestAPI Response to Console    ${response}
    Should Not Be Empty    ${response.json()}

    Clear Database
    
    
Query the amount of tax relief
    [Tags]    userstory4
    Clear Database
    # male
    ${hero1}=    Create Dictionary    birthday=10112007    gender=M    name=heroOne    natid=123456    salary=100123    tax=123
    # female
    ${hero2}=    Create Dictionary    birthday=12121991    gender=F    name=heroTwo    natid=123456    salary=100123    tax=123
    # relief is 2dp after calculating
    ${hero3}=    Create Dictionary    birthday=12121975    gender=M    name=heroThree    natid=123456    salary=123456    tax=123
    # relief amount less than 50 but more than 0
    ${hero4}=    Create Dictionary    birthday=09101947    gender=M    name=heroFour    natid=123456    salary=223    tax=123
    # more than 2dp before rounding, !!FAIL!! should be 67.00
    ${hero5}=    Create Dictionary    birthday=08101946    gender=M    name=heroFive    natid=123456    salary=1456.23    tax=123
    ${body}=    Create List    ${hero1}    ${hero2}    ${hero4}    ${hero3}    ${hero5}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST    ${BASE_URL}/calculator/insertMultiple    json=${body}    headers=${headers}
    ${response}=    GET    ${BASE_URL}/calculator/taxRelief
    Log RestAPI Response to Console    ${response}

    # VALIDATIONS
    FOR  ${hero}    ${hero_response}  IN ZIP   ${body}   ${response.json()}
        ${relief}    calculate_hero_relief_amount    ${hero}
        ${natid}    verify_natid    ${hero_response}[natid]
        Should Be Equal As Strings    ${hero_response}[relief]    ${relief}
        Should Be Equal As Strings    ${hero_response}[natid][4:]    ${natid}    
    END
    
    Clear Database

    

Button to dispense tax relief
    [Tags]    userstory5
    Open Browser    ${BASE_URL}    chrome
    Maximize Browser Window
    ${button}=    Get WebElement    //a[@class='btn btn-danger btn-block']
    ${style}=    Get Element Attribute    ${button}    background-color
    Log To Console    ${style}
    # not able to get button color
    ${text}=    Get Text    ${button}
    Log To Console    ${text}
    Element Text Should Be    ${button}    Dispense Now
    Click Button    ${button}
    Sleep    3
    Element Text Should Be    //div[@class='display-4 font-weight-bold']    Cash dispensed

    