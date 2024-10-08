*** Settings ***
Resource    ../../Resources/Resources1.resource
*** Variables ***

*** Test Cases ***
Test Case in BDD format
    Given Start Browser And Maximize
     ${Locator_username}    Resources1.Get value Json Locator Data SansArret    [Registration][username_textbox]
    ${Locator_email}    Resources1.Get value Json Locator Data SansArret    [Registration][email_textbox]
    When Input Text    ${Locator_username}    Seyf
    And Input Text    ${Locator_email}       seyf.Ben@gmail.fr
    Then Close Browser
