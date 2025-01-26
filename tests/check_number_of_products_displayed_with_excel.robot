*** Settings ***
Resource          ../resources/variables.robot
Resource          ../resources/Helper.robot
Resource          ../resources/ExcelHelper.robot

*** Test Cases ***
Check Number Of Products Displayed

    #open browser and maximize the window
    Open Demoblaze HomePage

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


    #get expected data from excel sheet
    ${EXPECTED_PRODUCTS_NUMBER_FROM_EXCEL}=    Open Excel and Count Rows     ${excel_file_path}     ${PRODUCTS_SHEET_NAME}
    ${EXPECTED_PRODUCTS_NAMES_FROM_EXCEL}=    Get Specific Column     ${excel_file_path}     ${PRODUCTS_SHEET_NAME}    ProductName
    Log to console    EXPECTED_PRODUCTS_NUMBER_FROM_EXCEL:${EXPECTED_PRODUCTS_NUMBER_FROM_EXCEL}
    Log to console    EXPECTED_PRODUCTS_NAMES_FROM_EXCEL:${EXPECTED_PRODUCTS_NAMES_FROM_EXCEL}

    #assert actual count is equal to expected count
    Should Be Equal As Integers    ${ALL_PRODUCTS_NAMES_COUNT}    ${EXPECTED_PRODUCTS_NUMBER_FROM_EXCEL}
    #assert actual names with expected names
    Lists Should Be Equal    ${ALL_PRODUCTS_NAMES}    ${EXPECTED_PRODUCTS_NAMES_FROM_EXCEL}


    #close browser
    Close Browser