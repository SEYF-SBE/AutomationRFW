*** Settings ***
Library    SeleniumLibrary
Resource    ../../Resources/Resources1.resource

Test Setup      Start Browser And Maximize
Test Teardown   Close Browser Window



*** Variables ***
${Browser}      Chrome
${Url}          https://www.thetestingworld.com/testings/

*** Test Cases ***
Robot Fetch Data
   #Create Folder at Runtime     Testing     Algeria
    Concatenate User Name and Password    Testing     Algeria
