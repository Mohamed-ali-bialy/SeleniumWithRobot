*** Settings ***
Resource          ../resources/variables.robot
Resource          ../resources/Helper.robot
Resource          ../resources/JsonHelper.robot

*** Variables ***
${product_name}    HTC One M9


*** Test Cases ***

Verify Phone Details With Json File
    #open browser and maximize the window
    Open Demoblaze HomePage

    # method to navigate into phones Page
    Navigate To Phones Page

    #open required phone page
    Open Phone Details Page    ${product_name}

    #get actual texts from phone page
    ${PHONE_NAME_TEXT} =    Get Phone Name From Details Page
    ${PHONE_PRICE_TEXT} =    Get Phone Price From Details Page
    ${PHONE_DESCRIPTION_TEXT} =    Get Phone Description From Details Page

    #log actual text
    Log To Console     ${PHONE_NAME_TEXT}
    Log To Console     ${PHONE_PRICE_TEXT}
    Log To Console     ${PHONE_DESCRIPTION_TEXT}

    #get expected data from json file and log To Console
    ${PRODUCT_JSON_BODY}=    Extract Product Data    ${JSON_FILE_PATH}    ${product_name}
    ${EXPECTED_PRICE_FROM_JSON}=    Extract Attribute From Json    ${PRODUCT_JSON_BODY}    price
    ${EXPECTED_DESCRIPTION_FROM_JSON}=    Extract Attribute From Json    ${PRODUCT_JSON_BODY}    description
    Log to console    PRODUCT_JSON_BODY:${PRODUCT_JSON_BODY}
    Log to console    PRICE FROM JSON:${EXPECTED_PRICE_FROM_JSON}
    Log to console    DESCRIPTION FROM JSON:${EXPECTED_DESCRIPTION_FROM_JSON}


    # assert texts with expected data
    Should be equal as strings    ${PHONE_PRICE_TEXT}     ${EXPECTED_PRICE_FROM_JSON}
    Should be equal as strings    ${PHONE_DESCRIPTION_TEXT}     ${EXPECTED_DESCRIPTION_FROM_JSON}

    #close browser
    Close Browser

