*** Settings ***
Library     SeleniumLibrary
Library     JSONLibrary
Library     DateTime
Library     ../ExternalKeywords/UserKeywords.py
Library     ../ExternalKeywords/Excel/ReadExcell.py
Library     ../ExternalKeywords/Common.py

*** Variables ***
${Browser}      Chrome
${URL}          http://www.thetestingworld.com/testings

*** Keywords ***
Start Browser And Maximize
    ${option_chrome} =  Close Chrome PopUp
    Open Browser    ${URL}      ${Browser}
    Maximize Browser Window

Enter Credentials
    [Arguments]     ${userName}     ${email}      ${password}
    Input Text    //input[@name='fld_username']    ${userName}
    Input Text    //input[@name="fld_email" and @type='email']      ${email}
    Input Text    name:fld_password    ${password}

Close Chrome PopUp
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --disable-search-engine-choice-screen
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-logging
    Call Method    ${chrome_options}    add_argument    --log-level\=3

    RETURN  ${chrome_options}

Close Browser Window
    Close Browser

Before Each Test Suite
    Log To Console    Befor Each Test Suite

After Each Test Suite
    Log To Console    After Each Test Suite

Create Folder at Runtime
    [Arguments]    ${foldername}    ${subfoldername}
    UserKeywords.create_folder      ${foldername}
    UserKeywords.create_sub_folder      ${subfoldername}
    
Concatenate UserName and Password
    [Arguments]     ${name}     ${pw}
    ${val}=     concatenate_two_values    ${name}    ${pw}
    Log    ${val}

Get value Json Locator Data SansArret
    [Documentation]    Chrgement du fichier json des locators
    ...    Arguments:
    ...        aNom ==> Le nom de l'id de localisation de l'objet de la page
    [Arguments]    ${aNom}
    [Tags]    Technique
    ${DataLocatorJson}    Get Json Locator Data

    ${ValueLocatorJson}    get value from json    ${DataLocatorJson}    ${aNom}
    ${ValueLocatorJsonLg}=    Get Length    ${ValueLocatorJson}
    IF    ${ValueLocatorJsonLg} == 0
        TraitementStatusSansArret    FAIL    présent dans le json des Locators    ${aNom}    ""    'List 'ValueLocatorJson' has no item in index 0.'
        BuiltIn.Run Keyword And Continue On Failure    get value from json    ${DataLocatorJson}    ""    fail_on_empty=${True}
        RETURN    ${EMPTY}
    ELSE
        RETURN    ${ValueLocatorJson}[0]
    END

TraitementStatusSansArret
    [Documentation]    Gestion des messages selon le traitement et le statut
    ...    Arguments:
    ...        aStatus     ==> Le statut du traitement
    ...        aTraitement ==> Le libellé message du traitement
    ...        aNom ==> Le chemin dans les fichiers json
    ...        aLocator    ==> L'id de localisation de l'objet de la page
    ...        aStackTrace ==> La stack trace erreur
    [Arguments]    ${aStatus}    ${aTraitement}    ${aNom}    ${aLocator}    ${aStackTrace}
    [Tags]    Technique

    ${Message}    BuiltIn.Set Variable    ${PREV_TEST_NAME}: L'element ${aNom} ayant le locator '${aLocator}' n'est pas ${aTraitement} dans la page

    IF    '${aStatus}' == 'FAIL'
        Capture Step ScreenShot    ${aStatus}
        #Capture Step Element ScreenShot    ${aStatus}    ${aLocator}
        Log Report    ${Message}    ERROR
    ELSE
        ${Message}    BuiltIn.Set Variable    ${PREV_TEST_NAME}: L'element  ayant le locator'${aLocator}' est ${aTraitement} dans la page
        Log To Console    ${Message}
    END

Get Json Locator Data
    [Documentation]    Chrgement du fichier json des locators
    ${DataLocatorJson}         Load JSON from file         ./JsonFiles/Elements.json   encoding=utf-8
    RETURN          ${DataLocatorJson}

Log Report
    [Documentation]    Création du message dans le Rapport
    ...    Arguments:
    ...        aMessage  ==> Le message du traitement
    ...        level     ==> ERREUR / INFO / WARN ...
    [Arguments]    ${message}    ${level}
    [Tags]    Technique
    BuiltIn.Log    ${message}    level=${level}    console=False

Capture Step ScreenShot
    [Documentation]    Capture avec règle de nommage du fichier
    ...    Le step permet d'identifier l'étape et de faire plusieurs captures par test
    ...    Arguments:
    ...        step ==> Etat du traitement = FAIL
    [Arguments]    ${step}
    ${dt}    DateTime.Get Current Date    result_format=%Y%m%d_%H%M%S%f

    ${filename}    Common.Clean String Filename    ${dt}_${TEST NAME}_${step}
    #Log Console    ${step}    INFO
    IF    '${step}' == 'FAIL'
    #IF    '''${step}''' == 'FAIL'
        SeleniumLibrary.Capture Page Screenshot    ${OUTPUT DIR}${/}${filename}.png
        #${html}    SeleniumLibrary.Get Source
        #OperatingSystem.Create File    path=${OUTPUT DIR}${/}${filename}.html    content=${html}    encoding=UTF-8
    END

Read Number of Rows
    [Arguments]     ${sheetname}
    ${maxRow}=    ReadExcell.fetch_number_of_rows    ${sheetname}
    RETURN  ${maxRow}

Read Excel Data Cell
    [Arguments]     ${sheetname}    ${row}     ${cell}
    ${cell_val}=   ReadExcell.fetch_cell_data     ${sheetname}    ${row}     ${cell}
    RETURN  ${cell_val}
