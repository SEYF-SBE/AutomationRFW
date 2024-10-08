*** Settings ***
Library     SeleniumLibrary
Library     JSONLibrary
Resource    ../Resources/Resources1.resource

Suite Setup         Resources1.Before Each Test Suite
Test Setup          Resources1.Start Browser And Maximize
Test Teardown       Resources1.Close Browser Window
Suite Teardown      Resources1.After Each Test Suite
Default Tags        DFLT
Force Tags          ALL_TC

*** Test Cases ***
TC_001 Browser start and close
    Resources1.Start Browser And Maximize
    Close Browser
    
Robot First Test Case
    Resources1.Start Browser And Maximize
    ${Locator_username}    Resources1.Get value Json Locator Data SansArret    [Registration][username_textbox]
    ${Locator_email}    Resources1.Get value Json Locator Data SansArret    [Registration][email_textbox]
    Input Text    ${Locator_username}    Seyf
    Input Text    ${Locator_email}       seyf.Ben@gmail.fr
    Clear Element Text    ${Locator_username}
    Clear Element Text    ${Locator_email}
    Close Browser

TC Radio Test
    Resources1.Start Browser And Maximize
    Select Radio Button    add_type    office
    
TC Select CheckBox
    Resources1.Start Browser And Maximize
    Click Link          //a[text()='Read Detail']
    Click Element       //a[@class='close']
    Select Checkbox     //input[@value="Sign up"]//preceding::input[@name="terms"]
    Click Button        //input[@type="submit" and @value='Sign up']

TC Drowpdown
    Resources1.Start Browser And Maximize
    # Set Selenium Speed    3s
    Select From List By Index    //select[@name="sex"]      2
    Select From List By Value    //select[@id="countryId"]      3

TC Keywords In Test Case
    [Documentation]     this test case is to check registrition fonctionnality of application
    [Tags]              Smoke
    # [Timeout]           30s
    # [Setup]             Resources1.Start Browser And Maximize
    # [Teardown]          Resources1.Close Browser Window
    # Resources1.Start Browser And Maximize
    Resources1.Enter Credentials   Seyf    seyf.Ben@gmail.fr   12345

TC json resources
    ${Locator}    Resources1.Get value Json Locator Data SansArret    [Registration][username_textbox]
    Log Report    ${Locator}    info