*** Settings ***
Library     SeleniumLibrary
Library     ExcelLibrary
Library     make_excel

*** Variables ***
${browser}    chrome
${url}    https://www.booster4web.com/map-location/
${expected_result}     "22/1 Sukhumvit 55 (Soi Thong Lo), Klong Tonnua, Vadhana, Bangkok 10110"
${search_button}    xpath=//*[@class="input-group-addon hand"]
${path_excel_reader}   D:/robot_sc/reader_excel.xlsx
${new_excel}            D:/robot_sc/lat_long_excel.xlsx
${sheet_name}            Sheet1
${value_from}
${latitude}         id:txtLat
${longtitude}       id:txtLng

*** Keywords ***
เปิดเว็บ
    Open Browser     ${url}     ${browser}

คลิกค้นหา
    Click Element   ${search_button}
รอโหลด
    Wait Until Element Is Visible    id=txtSearchText
    Wait Until Element Is Visible    ${search_button}
รอละติจูดและลองติจูด
    Wait Until Element Is Visible    id:txtLat
    Wait Until Element Is Visible    id:txtLng
    
ทดสอบอ่านค่า
    Open Excel Document     ${path_excel_reader}   ${sheet_name}
    Make Excel File         ${new_excel}
    Add Value       ${new_excel}        A1      google_addresss
    Add Value       ${new_excel}        B1      latitude
    Add Value       ${new_excel}        C1      longtitude
    :FOR    ${i}    IN RANGE    2   152
    \   ${value_from}   Read Excel Cell     ${i}       1
    \   Input Text    id=txtSearchText       ${value_from}
    \   รอโหลด
    \   คลิกค้นหา
    \   Sleep   5s
    \   รอละติจูดและลองติจูด
    \   Add Value       ${new_excel}        A${i}   ${value_from}
    \   ${latitude}     Get Text       id:txtLat
    \   Add Value       ${new_excel}        B${i}   ${latitude}
    \   ${longtitude}   Get Text       id:txtLng
    \   Add Value       ${new_excel}        C${i}   ${longtitude}
    \   รอโหลด
    
    
*** Test Cases ***
Search case
    เปิดเว็บ
    รอโหลด
    ทดสอบอ่านค่า