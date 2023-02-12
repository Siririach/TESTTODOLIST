*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}    https://abhigyank.github.io/To-Do-List/
${ADDBUTTON}  xpath=//button[@class='mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored']
${MENUTODOTASKS}  //*[contains(text(),'To-Do Tasks')]
${DELETEBUTTON}  xpath=//*[@class="mdl-button mdl-js-button mdl-js-ripple-effect delete"
${CHECKBOX}  xpath=//*[@class="mdl-checkbox__ripple-container mdl-js-ripple-effect mdl-ripple--center"]
${MENUCOMPLETE}  //*[contains(text(),'Completed')]

*** Test Cases ***
Add transaction
    [Tags]  Add
    Add transaction  ${URL}    ${BROWSER}
    Click Element  ${MENUTODOTASKS}
    sleep  2s
    FOR  ${INDEX}  IN RANGE  3
        ${TEXTINDEX}=  Evaluate  ${INDEX} + 1
        Verify Text  xpath=//*[@id="text-${TEXTINDEX}"]  TUMTEST${INDEX}
    END

Delete transaction
    [Tags]  Delete
    Add transaction  ${URL}    ${BROWSER}
    Click Element  ${MENUTODOTASKS}
    sleep  2s
    Click Element  ${DELETEBUTTON} and @id="3"]
    Click Element  ${DELETEBUTTON} and @id="2"]
    Click Element  ${DELETEBUTTON} and @id="1"]
    sleep  2s
    FOR  ${INDEX}  IN RANGE  3
        ${TEXTINDEX}=  Evaluate  ${INDEX} + 1
        Not Visible  xpath=//*[@id="text-${TEXTINDEX}"]  TUMTEST${INDEX}
    END

Complete transaction
    [Tags]  Complete
    Add transaction  ${URL}    ${BROWSER}
    Click Element  ${MENUTODOTASKS}
    sleep  2s
    FOR  ${INDEX}  IN RANGE  1
        Click Element  ${CHECKBOX}
        Sleep  1s
    END
    Click Element  ${MENUCOMPLETE}
    Sleep  3s
    Verify Text  xpath=//*[@class="mdl-list__item-primary-content"]  doneTUMTEST0

*** Keywords ***
Add transaction
    [Arguments]  ${URL}  ${BROWSER}
    Open Browser  ${URL}    ${BROWSER}
    FOR  ${INDEX}  IN RANGE  3
        Input Text  id=new-task  TUMTEST${INDEX}
        Click Element   ${ADDBUTTON}
    END
Verify Text
    [Arguments]  ${locator}  ${expectedString}
    ${Somevariable}=    Get Text     ${locator}
    Should Be Equal       ${Somevariable}      ${expectedString}
Not Visible
    [Arguments]  ${locator}  ${expectedString}
    Element Should Not Be Visible  ${locator}  ${expectedString}

