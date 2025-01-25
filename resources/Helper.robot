*** Settings ***
Resource          ../resources/variables.robot
Resource          ../resources/locators.robot
Resource          ../resources/SeleniumActions.robot

*** Keywords ***

Open Demoblaze HomePage
    Open Browser and Maximize    ${URL}    ${BROWSER}

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

# method to navigate into phones Page
Navigate To Phones Page
    #wait until phone button visible
    Wait Until Element Is Visible    ${PHONES_BUTTON}    ${WAIT_TIME}

    #click on phone button
    Click Element    ${PHONES_BUTTON}

    # Wait until page contains the word "Phones"
    Wait Until Page Contains    Phones    ${WAIT_TIME}

#method to click on phone
Open Phone Details Page
    [Arguments]    ${to_be_opened_phone_name}

    #get the xpath of the target phone by string replacement
    ${formatted_xpath} =    Replace String    ${TARGET_PHONE_ELEMENT}    {product_name}    ${to_be_opened_phone_name}

    # wait for elements to be visible and enabled
    Wait Until Element Is Visible   ${formatted_xpath}    ${WAIT_TIME}
    Wait Until Element Is Enabled    ${formatted_xpath}    ${WAIT_TIME}

    #get phone element
    ${phone_element} =    Get WebElement    ${formatted_xpath}

    #click on phone element
    Click Element    ${phone_element}

Get Phone Name From Details Page
   ${PHONE_NAME_TEXT}=    Get Element Text  ${PRODUCT_NAME_IN_PAGE}
   RETURN      ${PHONE_NAME_TEXT}


Get Phone Price From Details Page
   ${PHONE_PRICE_TEXT}=    Get Element Text  ${PRODUCT_PRICE}
   RETURN      ${PHONE_PRICE_TEXT}


Get Phone Description From Details Page
   ${PHONE_DESCRIPTION_TEXT}=    Get Element Text  ${PRODUCT_DESCRIPTION}
   RETURN      ${PHONE_DESCRIPTION_TEXT}



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
