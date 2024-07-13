*** Settings ***
Library    SeleniumLibrary
Library    String
Library    BuiltIn
Resource  variables.robot
Library    FakerLibrary


*** Variables ***


*** Keywords ***
# login
loginToTheApplication
    click link    xpath://a[contains(text(),'Log in')]
    input text    id:Email    ${user_email}
    input text    id:Password    ${user_password}
    click element    xpath://button[contains(text(),'Log in')]
    Sleep    2s
    ${logout_button}    set variable    xpath://a[contains(text(),'Log out')]
    set global variable    ${logout_button} 
    Page Should Contain Link    ${logout_button}


logout
    click link    ${logout_button}
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
    Run Keyword if   "${user_gender}" == "Female"    
    ...    Click Element    id:gender-female         
...    ELSE    Click Element    id:gender-male    
    ${registration_user_first_name} =  FakerLibrary.first_name
    set Global Variable    ${registration_user_first_name}
    ${registration_user_last_name} =  FakerLibrary.last_name
    set Global Variable    ${registration_user_last_name}
    ${registration_user_email} =  FakerLibrary.email
    set Global Variable    ${registration_user_email}
    ${registration_user_company} =  FakerLibrary.name
    set Global Variable    ${registration_user_company}
    input text    id:FirstName    ${registration_user_first_name}
    input text    id:LastName    ${registration_user_last_name}
    select from list by label    DateOfBirthDay    ${user_date_of_birth_day}
    select from list by Value    DateOfBirthMonth    ${user_date_of_birth_month}
    select from list by label    DateOfBirthYear    ${user_date_of_birth_year}
    input text    id:Email    ${registration_user_email}
    input text    id:Company    ${registration_user_company}
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
    Run Keyword if   "${user_gender}" == "Female"    
    ...    Click Element    id:gender-female         
...    ELSE    Click Element    id:gender-male 
    input text    id:FirstName    ${registration_user_first_name}
    input text    id:LastName    ${registration_user_last_name}
    select from list by label    DateOfBirthDay    ${user_date_of_birth_day}
    select from list by Value    DateOfBirthMonth    ${user_date_of_birth_month}
    select from list by label    DateOfBirthYear    ${user_date_of_birth_year}
    input text    id:Email    hbhkbkb
    input text    id:Company    ${registration_user_company}
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
    ${gender_option_female}=     Execute Javascript      return document.getElementById("gender-female").checked
    Run Keyword if   "${user_gender}" == "Male"   radio button should be set to    Gender  M
...    ELSE   radio button should be set to    Gender   F

Update the information
    Clear Element Text    xpath://input[@id='FirstName']
    







