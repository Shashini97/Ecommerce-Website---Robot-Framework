**** Settings ***
Library    SeleniumLibrary


*** Variables ***
${browser}    chrome
${url}    https://demo.nopcommerce.com/


*** Test Cases ***
LoginTest
    open browser    ${url}    ${browser}
    maximize browser window   
    Sleep    1s 
    loginToTheApplication
    loginToTheApplicationWithIncorectEmail
    loginToTheApplicationWithIncorectPassword
    close browser

*** Keywords ***
loginToTheApplication
    click link    xpath://a[contains(text(),'Log in')]
    input text    id:Email    test@test.com
    input text    id:Password    Test@123
    click element    xpath://button[contains(text(),'Log in')]
    Sleep    1s
    ${"logout_button"}    set variable    xpath://a[contains(text(),'Log out')]
    Page Should Contain Link    ${"logout_button"}
    Sleep    1s
    click link    ${"logout_button"}
    Page Should Contain Link    xpath://a[contains(text(),'Log in')]


loginToTheApplicationWithIncorectEmail
    click link    xpath://a[contains(text(),'Log in')]
    input text    id:Email    tesst@test.com
    input text    id:Password    Test@123
    click element    xpath://button[contains(text(),'Log in')]
    Sleep    1s
    Page Should Contain element    xpath://li[contains(text(),'No customer account found')]

loginToTheApplicationWithIncorectPassword
    click link    xpath://a[contains(text(),'Log in')]
    input text    id:Email    test@test.com
    input text    id:Password    Testt@123
    click element    xpath://button[contains(text(),'Log in')]
    Sleep    1s
    Page Should Contain element    xpath://li[contains(text(),'The credentials provided are incorrect')]

