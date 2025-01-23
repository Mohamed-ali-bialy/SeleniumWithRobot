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

#spicial method to get displayed card names
Get Card Elements Text
   Wait for Element to Be Visible and Enabled    ${PRODUCT_CARDS_LOCATOR}
   ${elements}=    Get WebElements    ${PRODUCT_CARDS_LOCATOR}
    ${text_list}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${text_list}    ${text}
    END
    RETURN    ${text_list}


# a next navigation method with check until new card are loaded
Navigate and Wait for New Page
    ${old_elements}=    Get WebElements    ${old_elements_locator}
    Click Element    ${next_button_locator}
    FOR    ${counter}    IN RANGE    0    ${INFINITE_NUMBER}
        ${new_elements}=    Get WebElements    ${old_elements_locator}
        Exit For Loop If    '${old_elements}' != '${new_elements}'
    END


# mering two method function
Merge Lists
    [Arguments]    ${list1}    ${list2}
    ${merged_list}=    Create List
    FOR    ${item}    IN    @{list1}
        Append To List    ${merged_list}    ${item}
    END
    FOR    ${item}    IN    @{list2}
        Append To List    ${merged_list}    ${item}
    END
    RETURN    ${merged_list}