*** Settings ***
Resource    ../../Resources/Resources1.resource

*** Variables ***
${var}  https://www.thetestingworld.com

*** Test Cases ***
Test Case in TDD Excel
    Open Browser    ${var}  Chrome
    Maximize Browser Window
    ${row}=     Resources1.Read Number of Rows    LoginData
    Log To Console    ${row}
    Click Element    //a[text()='Quick Demo']
    Sleep    2s

    FOR    ${i}    IN RANGE    1    ${row}+1
        ${username}=     Resources1.Read Excel Data Cell    LoginData     ${i}   1
        ${password}=     Resources1.Read Excel Data Cell    LoginData     ${i}   2
        Input Text    //input[@id="wdform_1_element_first2"]    ${username}
        Input Text    //input[@id='wdform_1_element_last2']    ${password}
        Click Button    //button[text()='Submit']
        Sleep    2s
        Handle Alert    ACCEPT
    END



