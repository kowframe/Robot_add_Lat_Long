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
${path_new_excel}            D:/robot_sc/lat_long_excel.xlsx
${check_value_excel}    D:/robot_sc/check_value_excel.xlsx
${sheet_name}            Sheet1
${value_from}
${check_latitude}
${check_longtitude}
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
    Make Excel File         ${check_value_excel}
    Add Value       ${check_value_excel}        A1      CHECK_VALUE
    :FOR    ${i}    IN RANGE    2   152
    \   ${value_from}   Read Excel Cell     ${i}       1
    \   ${check_latitude}      Read Excel Cell     ${i}       2
    \   ${check_longtitude}     Read Excel Cell     ${i}       3
    \   Input Text    id=txtSearchText       ${value_from}
    \   คลิกค้นหา
    \   Sleep   5s
    \   รอละติจูดและลองติจูด
    \   ${latitude}     Get Text       id:txtLat
    \   ${status_lat}     Run Keyword And Return Status   Should Be Equal     ${latitude}     ${check_latitude}
    \   ${longtitude}   Get Text       id:txtLng
    \   ${status_long}      Run Keyword And Return Status   Should Be Equal     ${longtitude}       ${check_longtitude}
    \   Run Keyword If      ${status_lat} == True and ${status_long} == True    Add Value       ${check_value_excel}        A${i}   Correct      ELSE    Add Value       ${check_value_excel}        A${i}   Mistake
    \   รอโหลด
    
*** Test Cases ***
Search case
    เปิดเว็บ
    รอโหลด
    ทดสอบอ่านค่า