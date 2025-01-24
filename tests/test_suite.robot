*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Resource          ../resources/keywords.robot
Resource          ../resources/variables.robot
Resource          ../resources/locators.robot

*** Variables ***
${URL}            https://www.demoblaze.com/
${BROWSER}        Chrome
${WAIT_TIME}      15
${NUMBER_OF_EXPECTED_PRODUCTS}    15
${INFINITE_NUMBER}     100000
${PHONES_BUTTON}  xpath=//*[@onclick="byCat('phone')"]
${NEXT_BUTTON}    xpath=//*[contains(@id,'next2')]

${TARGET_PHONE_ELEMENT}    xpath=//a[text()='{product_name}']
${product_name}    HTC One M9


${PRODUCT_NAME_IN_PAGE}    xpath=//h2[@class='name']
${PRODUCT_PRICE}    xpath=//h3[@class='price-container']
${PRODUCT_DESCRIPTION}    xpath=//div[@id='more-information']//p


${EXPECTED_PHONE_NAME}    HTC One M9
${EXPECTED_PRICE}    $700 *includes tax
${EXPECTED_DESCRIPTION}    The HTC One M9 is powered by 1.5GHz octa-core Qualcomm Snapdragon 810 processor and it comes with 3GB of RAM. The phone packs 32GB of internal storage that can be expanded up to 128GB via a microSD card.



*** Test Cases ***

Verify Phone Details
   #open browser and maximize the window
    Open Browser and Maximize    ${URL}    ${BROWSER}

    #wait until phone button visible
    Wait Until Element Is Visible    ${PHONES_BUTTON}    ${WAIT_TIME}

    #click on phone button
    Click Element    ${PHONES_BUTTON}

    # Wait until page contains the word "Phones"
    Wait Until Page Contains    Phones    ${WAIT_TIME}

    #get the xpath of the target phone by string replacement
    ${formatted_xpath} =    Replace String    ${TARGET_PHONE_ELEMENT}    {product_name}    ${product_name}
    Log To Console    ${formatted_xpath}


    # wait for elements to be visible and enabled
    Wait Until Element Is Visible   ${formatted_xpath}    ${WAIT_TIME}
    Wait Until Element Is Enabled    ${formatted_xpath}    ${WAIT_TIME}

    #get phone element
    ${phone_element} =    Get WebElement    ${formatted_xpath}

    #click on phone element
    Click Element    ${phone_element}

    #wait until elements are visible and enabled
    Wait Until Element Is Visible   ${PRODUCT_NAME_IN_PAGE}      ${WAIT_TIME}
    Wait Until Element Is Enabled   ${PRODUCT_NAME_IN_PAGE}      ${WAIT_TIME}

    #get needed elements
    ${PHONE_NAME} =    Get WebElement    ${PRODUCT_NAME_IN_PAGE}
    ${PHONE_PRICE} =    Get WebElement    ${PRODUCT_PRICE}
    ${PHONE_DESCRIPTION} =    Get WebElement    ${PRODUCT_DESCRIPTION}

    #get texts of elements
    ${PHONE_NAME_TEXT}=    Get text    ${PHONE_NAME}
    ${PHONE_PRICE_TEXT}=    Get text    ${PHONE_PRICE}
    ${PHONE_DESCRIPTION_TEXT}=    Get text    ${PHONE_DESCRIPTION}


    Log To Console     ${PHONE_NAME_TEXT}
    Log To Console     ${PHONE_PRICE_TEXT}
    Log To Console     ${PHONE_DESCRIPTION_TEXT}

    # assert texts with expected data
    Should be equal as strings    ${PHONE_NAME_TEXT}     ${EXPECTED_PHONE_NAME}
    Should be equal as strings    ${PHONE_PRICE_TEXT}     ${EXPECTED_PRICE}
    Should be equal as strings    ${PHONE_DESCRIPTION_TEXT}     ${EXPECTED_DESCRIPTION}

    #close browser
    Close Browser

