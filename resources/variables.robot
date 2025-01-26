*** Variables ***
${URL}            https://www.demoblaze.com/
${BROWSER}        Chrome
${WAIT_TIME}      15
${NUMBER_OF_EXPECTED_PRODUCTS}    15
${INFINITE_NUMBER}    100

# Product-related variables
${product_name}    HTC One M9
${EXPECTED_PHONE_NAME}    HTC One M9
${EXPECTED_PRICE}    $700 *includes tax
${EXPECTED_DESCRIPTION}    The HTC One M9 is powered by 1.5GHz octa-core Qualcomm Snapdragon 810 processor and it comes with 3GB of RAM. The phone packs 32GB of internal storage that can be expanded up to 128GB via a microSD card.

#Excel file variables
${excel_file_path}    ./DataFiles/products.xlsx
${PRODUCTS_SHEET_NAME}    Sheet1
${JSON_FILE_PATH}    ./DataFiles/productData.json
