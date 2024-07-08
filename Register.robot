*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${browser}    chrome
${url}    https://demo.nopcommerce.com/


*** Test Cases ***
Register A New Customer
    open browser    ${url}    ${browser}
    maximize browser window
    Sleep    1s
    Mandatory field validation
    Register
    Registration form field validation
    close browser


*** Keywords ***
Mandatory field validation
    click link    xpath://a[contains(text(),'Register')]
    click element    id:register-button
    page should contain element    id:FirstName-error
    page should contain element    id:LastName-error
    page should contain element    id:Email-error
    page should contain element    id:ConfirmPassword-error

Register
    click link    xpath://a[contains(text(),'Register')]
    select radio button    Gender    F
    input text    id:FirstName    Shashini
    input text    id:LastName    Amasha
    select from list by label    DateOfBirthDay    17
    select from list by label    DateOfBirthMonth    January
    select from list by label    DateOfBirthYear    1997
    input text    id:Email    hellood@gmail.com
    input text    id:Company    Calcey
    select checkbox    Newsletter
    input text    id:Password    Test@123
    input text    id:ConfirmPassword    Test@123
    click element    id:register-button
    Page Should Contain element    xpath://div[contains(text(),'Your registration completed')]
    Sleep    1s
    click link    xpath://a[contains(text(),'Log out')]
    Page Should Contain Link    xpath://a[contains(text(),'Log in')]

Registration form field validation
    click link    xpath://a[contains(text(),'Register')]
    select radio button    Gender    F
    input text    id:FirstName    Shashini
    input text    id:LastName    Amasha
    select from list by label    DateOfBirthDay    17
    select from list by label    DateOfBirthMonth    January
    select from list by label    DateOfBirthYear    1997
    input text    id:Email    hbhkbkb
    input text    id:Company    Calcey
    select checkbox    Newsletter
    input text    id:Password    Test@123
    input text    id:ConfirmPassword    Tester@123
    click element    id:register-button
    page should contain element    id:Email-error
    page should contain element    id:ConfirmPassword-error
    






