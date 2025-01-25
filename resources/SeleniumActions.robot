*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Resource          ../resources/variables.robot
Resource          ../resources/locators.robot


*** Keywords ***
#method takes url and opens Maximize browser window
Open Browser and Maximize
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

#A generic wait method for the elements
Wait for Element to Be Visible and Enabled
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${WAIT_TIME}
    Wait Until Element Is Enabled    ${locator}    ${WAIT_TIME}

#method that takes an locatre and get elements
Get Elements Text
    [Arguments]    ${locator}
   Wait for Element to Be Visible and Enabled    ${locator}
   ${elements}=    Get WebElements    ${locator}
    ${text_list}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${text_list}    ${text}
    END
    RETURN    ${text_list}

Get Element Text
     [Arguments]    ${locator}
     Wait for Element to Be Visible and Enabled    ${locator}
     ${WEB_ELEMENT} =    Get WebElement    ${locator}
     ${TEXT}=    Get text    ${WEB_ELEMENT}
     RETURN    ${TEXT}
