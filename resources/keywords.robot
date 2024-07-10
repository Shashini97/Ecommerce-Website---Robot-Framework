*** Settings ***
Library    SeleniumLibrary
Variables    ../variables.py


*** Variables ***

*** Keywords ***
# login
loginToTheApplication
    click link    xpath://a[contains(text(),'Log in')]
    input text    id:Email    ${user_email}
    input text    id:Password    ${user_password}
    click element    xpath://button[contains(text(),'Log in')]
    Sleep    2s
    ${"logout_button"}    set variable    xpath://a[contains(text(),'Log out')]
    Page Should Contain Link    ${"logout_button"}


logout
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

Mandatory field validation
    click link    xpath://a[contains(text(),'Register')]
    click element    id:register-button
    page should contain element    id:FirstName-error
    page should contain element    id:LastName-error
    page should contain element    id:Email-error
    page should contain element    id:ConfirmPassword-error

# registration
Register
    click link    xpath://a[contains(text(),'Register')]
    ${gender-xpath}=    set variable If    '${user_gender} = "Female"'    id=gender-female    id:gender-male    
    Click Element  ${gender-xpath}
    input text    id:FirstName    ${user_first_name}
    input text    id:LastName    ${user_last_name}
    select from list by label    DateOfBirthDay    ${user_date_of_birth_day}
    select from list by Value    DateOfBirthMonth    ${user_date_of_birth_month}
    select from list by label    DateOfBirthYear    ${user_date_of_birth_year}
    input text    id:Email    ${user_email}
    input text    id:Company    ${user_company}
    select checkbox    Newsletter
    input text    id:Password    ${user_password}
    input text    id:ConfirmPassword    ${user_confirm_password}
    click element    id:register-button
    Page Should Contain element    xpath://div[contains(text(),'Your registration completed')]
    Sleep    1s
    click link    xpath://a[contains(text(),'Log out')]
    Page Should Contain Link    xpath://a[contains(text(),'Log in')]

Registration form field validation
    click link    xpath://a[contains(text(),'Register')]
    ${gender-xpath}=    set variable If    '${user_gender} = "Female"'    id=gender-female    id:gender-male    
    Click Element  ${gender-xpath}
    input text    id:FirstName    ${user_first_name}
    input text    id:LastName    ${user_last_name}
    select from list by label    DateOfBirthDay    ${user_date_of_birth_day}
    select from list by label    DateOfBirthMonth    ${user_date_of_birth_month}
    select from list by label    DateOfBirthYear    ${user_date_of_birth_year}
    input text    id:Email    hbhkbkb
    input text    id:Company    ${user_company}
    select checkbox    Newsletter
    input text    id:Password    ${user_password}
    input text    id:ConfirmPassword    Tester@123
    click element    id:register-button
    page should contain element    id:Email-error
    page should contain element    id:ConfirmPassword-error
    
# myaccount page
Navigate to my account
    click link    xpath://a[contains(text(),'My account')]
    Sleep    1s
    page should contain element    xpath://h1[contains(text(),'My account - Customer info')]

Verify the data in the my account
    Verify the gender
    ${first_name}=    Get Value    id:FirstName
    ${last_name}=    Get Value    id:LastName
    ${birth_day}=    Get Value    name:DateOfBirthDay
    ${birth_month}=    Get Value    name:DateOfBirthMonth
    ${birth_year}=    Get Value    name:DateOfBirthYear
    ${email}=    Get Value    id:Email
    ${company_name}=    Get Value    id:Company
    ${newsletter_checkbox}=    Get Value    name:Newsletter

    Should Be Equal    ${first_name}    ${user_first_name}
    Should Be Equal    ${last_name}    ${user_last_name}
    Should Be Equal    ${birth_day}    ${user_date_of_birth_day}
    Should Be Equal    ${birth_month}    ${user_date_of_birth_month}
    Should Be Equal    ${birth_year}    ${user_date_of_birth_year}
    Should Be Equal    ${email}    ${user_email}
    Should Be Equal    ${company_name}    ${user_company}
    Should Be Equal    ${newsletter_checkbox}    ${user_newsletter}

Verify the gender
    ${gender_option_male}=    Get Element Attribute   id:gender-male     checked
    ${gender_option_female}=    Get Element Attribute   id=gender-female     checked
    Run Keyword If    "${user_gender}"==    "Male"    Should Be true    ${gender_option_male}    'Male is not selected'
    Run Keyword If    "${user_gender}"==    "Female"    Should Be true    ${gender_option_female}    'Female is not selected'








