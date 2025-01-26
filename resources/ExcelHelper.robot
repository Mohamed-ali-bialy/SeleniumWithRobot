*** Settings ***
Library    RPA.Excel.Files
Library    Collections

*** Keywords ***
#method to read excel file
Read Worksheet And Return List
    [Arguments]    ${file_path}    ${sheet_name}
    Open Workbook    ${file_path}
    ${rows}=    Read Worksheet    ${sheet_name}    header=True
    Close Workbook
    [Return]    ${rows}

#method to get data of a spicefic column
Get Specific Column
    [Arguments]    ${file_path}    ${sheet_name}    ${column_name}
    Open Workbook    ${file_path}
    ${data}=    Read Worksheet    ${sheet_name}    header=True
    Close Workbook
    ${column_data}=    Create List
    FOR    ${row}    IN    @{data}
       Append To List    ${column_data}    ${row}[${column_name}]
    END
    RETURN    ${column_data}

#method to read excel file and get rows count
Open Excel and Count Rows
    [Arguments]    ${FILE_PATH}    ${SHEET_NAME}
    Log to console    Method Read Excel Count
    Open Workbook    ${FILE_PATH}
    ${rows}=    Read Worksheet    ${SHEET_NAME}    header=True
    ${row_count}=    Get Length    ${rows}
    Close Workbook
    RETURN    ${row_count}



