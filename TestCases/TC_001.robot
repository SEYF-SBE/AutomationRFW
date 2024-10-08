*** Settings ***
Library     SeleniumLibrary
Library    Collections

*** Variables ***
${Browser}      Chrome
${URL}          http://www.thetestingworld.com/testings

*** Test Cases ***
TC_Variables
    ${var}  Set Variable    HelloWorld
    log to console  ${var}

TC Lists    
    @{myList}   Create list     Adib    Seyf    23      RTT
    ${listLenght}   Get Length    ${myList}
    Log To Console    ${myList}  
    Log To Console    ${listLenght}
    ${var} =    Get From List   ${myList}    2
    Log To Console    ${var}

TC Loop for Range
    @{myList}   Create list     Adib    Seyf    23      RTT
    ${var}    Get Length    ${myList}
    FOR    ${i}    IN RANGE    0    ${var}
        Log To Console   ${myList}[${i}]
    END

TC Loop forEach
    @{myList}   Create list     Adib    Seyf    23      RTT
    FOR    ${element}    IN    @{myList}
        Log To Console    ${element}
    END


TC RUN Keyword
    ${key_var} =    Set Variable    Log to console
    Run Keyword    ${key_var}       ADIB ADIB

TC Run Keyword If
    ${var} =    Set Variable    Yes
    Run Keyword If    '${var}'=='Yes'    Log To Console    Value Founded
    Run Keyword If    '${var}'=='No'    Log To Console    Value not Founded

TC Wait
    ${option_chrome} =  Close Chrome PopUp

    Open Browser    ${URL}      ${Browser}      options=${option_chrome}
    Maximize Browser Window
    ${speed} =  Get Selenium Speed
    Log To Console    ${speed}
    Set Selenium Speed    1s
    ${speed} =  Get Selenium Speed
    Log To Console    ${speed}
    Input Text    //input[@name='fld_username']    userName
    Input Text    //input[@name="fld_email" and @type='email']      email
    Sleep    1s
    Input Text    name:fld_password    password

TC TimeOut
    ${option_chrome} =  Close Chrome PopUp

    Open Browser    ${URL}      ${Browser}      options=${option_chrome}
    Maximize Browser Window
    Set Selenium Timeout    8s
    Input Text    //input[@name='fld_username']    userName
    Input Text    //input[@name="fld_email" and @type='email']      email
    Input Text    name:fld_password    password

TC wait element 
    ${option_chrome} =  Close Chrome PopUp

    Open Browser    ${URL}      ${Browser}      options=${option_chrome}
    Maximize Browser Window
    Set Browser Implicit Wait    20s
    Input Text    //input[@name='fld_username']    userName
    Input Text    //input[@name="fld_email" and @type='email']      email
    Input Text    name:fld_password    password

TC ScreenShot
    ${option_chrome} =  Close Chrome PopUp
    Open Browser    ${URL}      ${Browser}      options=${option_chrome}
    Maximize Browser Window
    Set Browser Implicit Wait    20s
    Input Text    //input[@name='fld_username']    userName
    Input Text    //input[@name="fld_email" and @type='email']      email
    Input Text    name:fld_password    password
    ${time} =   Evaluate    str(time.time())    time
    Set Screenshot Directory    ./log/ScreenShots_files
    Capture Page Screenshot     ${TEST NAME}_${time}_first.png

    Go To    https://www.google.com
    Capture Page Screenshot     ${TEST NAME}_${time}_google.png

    Go Back
    Capture Page Screenshot     ${TEST NAME}_${time}_testing.png

    Close Browser
TC JavaScript Execution
    ${option_chrome} =  Close Chrome PopUp
    Open Browser    ${URL}      ${Browser}      options=${option_chrome}
    Maximize Browser Window
    Set Browser Implicit Wait    20s
    Sleep    5s
    Execute Javascript  window.scrollTo(0,1000)
    Sleep    5s
    Scroll Element Into View    //a[@class="displayPopup"]
    Close Browser
    
TC Perform Mouse
    ${option_chrome} =  Close Chrome PopUp
    Open Browser    ${URL}      ${Browser}      options=${option_chrome}
    Maximize Browser Window
    Set Browser Implicit Wait    20s
    #Open Context Menu    //li[2]
    #Press Keys      None    left
    #Sleep    5s
    #Double Click Element    //li[1]
    #Sleep    2s
    # Scroll Element Into View    //input[@name='_txtUserName']//following::i[@class='fa fa-lock fa-2x']
    #Mouse Down    //input[@name="_txtUserName"]//following::i[@class="fa fa-lock fa-2x"]
    Sleep    3s
    Close Browser
TC Wait until Page Have Something
    ${option_chrome} =  Close Chrome PopUp
    Open Browser    https://thetestingworld.com      ${Browser}      options=${option_chrome}
    Maximize Browser Window
    Set Browser Implicit Wait    30s
    Wait Until Page Contains    Quick Demo
    Click Element    //a[contains(text(), 'Quick Demo')]
    Sleep    3s
    Wait Until Page Contains Element    //div[contains(text(), 'Customer Support')]
    Sleep    2s
    Close Browser

TC Wait to switch browser
    ${option_chrome} =  Close Chrome PopUp
    Open Browser    https://thetestingworld.com      ${Browser}      options=${option_chrome}
    Maximize Browser Window
    Open Browser    https://google.com  ${Browser}  options=${option_chrome}
    Maximize Browser Window
    Sleep    2s
    Switch Browser    1
    Sleep    2s
    Click Element    //a[contains(text(), 'Quick')]
    Sleep    2s
    Switch Browser    2
    Input Text    //textarea    Adib
    Press Keys  ENTER
    Sleep    2s

TC Switch Windows
    ${option_chrome} =  Close Chrome PopUp
    Open Browser    https://www.robotframework.org      ${Browser}      options=${option_chrome}
    Maximize Browser Window
    Scroll Element Into View    //div[@style='background-image: url("/img/sponsors/cgi.png");']
    Click Element    //div[@style='background-image: url("/img/sponsors/cgi.png");']
    Switch Window   Intelligent automation | CGI.com
    @{listwindows}     Get Window Handles
    FOR    ${element}    IN    @{listwindows}
        Log    ${element}
        Switch Window   ${element}
        ${url}  Get Location
        Log To Console    ${url}
    END

    Close All Browsers

*** Keywords ***


