*** Settings ***
Resource          ../resources/keywords.robot
Resource          ../resources/variables.robot

*** Test Cases ***
Check Number Of Products Displayed
    #open browser and maximize the window
    Open Browser and Maximize    ${URL}    ${BROWSER}


    #get page products names
    ${FIRST_PAGE_PRODUCTS_NAMES}=    Get Card Elements Text
    Log to console    FIRST_PAGE_PRODUCTS_NAMES: ${FIRST_PAGE_PRODUCTS_NAMES}

    # Navigate to next page and wait until new elements are loaded
    Navigate and Wait for New Page

    #get page products names
    ${SECOND_PAGE_PRODUCTS_NAMES}=    Get Card Elements Text
    Log to console    SECOND_PAGE_PRODUCTS_NAMES: ${SECOND_PAGE_PRODUCTS_NAMES}

    # Merge All products and log
    ${ALL_PRODUCTS_NAMES}=    Merge Lists    ${FIRST_PAGE_PRODUCTS_NAMES}    ${SECOND_PAGE_PRODUCTS_NAMES}
    ${ALL_PRODUCTS_NAMES_COUNT}=     Get Length    ${ALL_PRODUCTS_NAMES}
    Log to console    all products: ${ALL_PRODUCTS_NAMES}
    Log to console    all products length:${ALL_PRODUCTS_NAMES_COUNT}


    #assert actual count is equal to expected count
    Should Be Equal As Integers    ${ALL_PRODUCTS_NAMES_COUNT}    ${NUMBER_OF_EXPECTED_PRODUCTS}

    #close browser
    Close Browser