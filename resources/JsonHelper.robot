*** Settings ***
Library    OperatingSystem
Library    Collections
*** keywords ***

# a method to extract prodcut json body from json file
Extract Product Data
    [Arguments]    ${JSON_FILE_PATH}    ${JSON_PRODUCT_NAME}
    #get json file
    ${file_content}=    Get File    ${JSON_FILE_PATH}

    #get json body
    ${JSON_PRODUCTS}=    Evaluate    json.loads('''${file_content}''')    json

    # Access the data of a specific product
    ${PRODUCT_DATA}=    Get From Dictionary    ${JSON_PRODUCTS}    ${JSON_PRODUCT_NAME}

    RETURN    ${PRODUCT_DATA}

#method to get Attribute From Json body
Extract Attribute From Json
    [Arguments]    ${JSON_BODY}    ${ATTRIBUTE}

    # Access the data of a specific product
    ${RETURN_ATTRIBUTE}=    Get From Dictionary    ${JSON_BODY}    ${ATTRIBUTE}

    RETURN    ${RETURN_ATTRIBUTE}
