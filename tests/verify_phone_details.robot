*** Settings ***
Resource          ../resources/variables.robot
Resource          ../resources/Helper.robot


*** Variables ***
${product_name}    HTC One M9

${EXPECTED_PHONE_NAME}    HTC One M9
${EXPECTED_PRICE}    $700 *includes tax
${EXPECTED_DESCRIPTION}    The HTC One M9 is powered by 1.5GHz octa-core Qualcomm Snapdragon 810 processor and it comes with 3GB of RAM. The phone packs 32GB of internal storage that can be expanded up to 128GB via a microSD card.



*** Test Cases ***

Verify Phone Details
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


    # assert texts with expected data
    Should be equal as strings    ${PHONE_NAME_TEXT}     ${EXPECTED_PHONE_NAME}
    Should be equal as strings    ${PHONE_PRICE_TEXT}     ${EXPECTED_PRICE}
    Should be equal as strings    ${PHONE_DESCRIPTION_TEXT}     ${EXPECTED_DESCRIPTION}

    #close browser
    Close Browser

