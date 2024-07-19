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
    input text    id:ConfirmPassword    ${user_password}
    click element    id:register-button
    Page Should Contain element    xpath://div[contains(text(),'Your registration completed')]

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

    Should Be Equal    ${first_name}    ${registration_user_first_name}
    Should Be Equal    ${last_name}    ${registration_user_last_name}
    Should Be Equal    ${birth_day}    ${user_date_of_birth_day}
    Should Be Equal    ${birth_month}    ${user_date_of_birth_month}
    Should Be Equal    ${birth_year}    ${user_date_of_birth_year}
    Should Be Equal    ${email}    ${registration_user_email}
    Should Be Equal    ${company_name}    ${registration_user_company}
    checkbox should be selected    name:Newsletter

Verify the gender
    ${gender_option_male}=    Get Element Attribute   id:gender-male     checked
    ${gender_option_female}=     Execute Javascript      return document.getElementById("gender-female").checked
    Run Keyword if   "${user_gender}" == "Male"   radio button should be set to    Gender  M
...    ELSE   radio button should be set to    Gender   F

Update the information
    Click Element    id:gender-female 
    Clear Element Text    xpath://input[@id='FirstName']
    input text    id:FirstName    Shashini
    Clear Element Text    xpath://input[@id='LastName']
    input text    id:LastName    Amasha
    select from list by label    DateOfBirthDay    28
    select from list by Value    DateOfBirthMonth    2
    select from list by label    DateOfBirthYear    1995
    Clear Element Text    xpath://input[@id='Email']
    ${updated_user_email} =  FakerLibrary.email
    set global variable    ${updated_user_email}
    input text    id:Email    ${updated_user_email}
    Clear Element Text    xpath://input[@id='Company']
    input text    id:Company    HelloWorld
    unselect checkbox    Newsletter
    click element    id:save-info-button

Check updated data
    ${first_name}=    Get Value    id:FirstName
    ${last_name}=    Get Value    id:LastName
    ${birth_day}=    Get Value    name:DateOfBirthDay
    ${birth_month}=    Get Value    name:DateOfBirthMonth
    ${birth_year}=    Get Value    name:DateOfBirthYear
    ${email}=    Get Value    id:Email
    ${company_name}=    Get Value    id:Company

    Should Be Equal    ${first_name}    Shashini
    Should Be Equal    ${last_name}    Amasha
    Should Be Equal    ${birth_day}    28
    Should Be Equal    ${birth_month}    2
    Should Be Equal    ${birth_year}    1995
    Should Be Equal    ${email}    ${updated_user_email}
    Should Be Equal    ${company_name}    HelloWorld
    checkbox should not be selected    name:Newsletter

#my account page - address section
Navigate to address section
    click link    xpath://a[contains(text(),'Addresses')]
    Sleep    1s
    page should contain element    xpath://h1[contains(text(),'My account - Addresses')]

Add a new address
    click element    xpath://button[contains(text(),'Add new')]
    page should contain element    xpath://h1[contains(text(),'My account - Add new address')]
    ${address_first_name} =  FakerLibrary.first_name
    set Global Variable    ${address_first_name}
    ${address_last_name} =  FakerLibrary.last_name
    set Global Variable    ${address_last_name}
    ${address_email} =  FakerLibrary.email
    set Global Variable    ${address_email}
    ${address_company} =  FakerLibrary.name
    set Global Variable    ${address_company}
    ${address_city} =  FakerLibrary.city
    set Global Variable    ${address_city}
    ${address_address} =  FakerLibrary.address
    set Global Variable    ${address_address}
    ${address_zipcode} =  FakerLibrary.Port Number
    set Global Variable    ${address_zipcode}
    ${address_phonenumber} =  FakerLibrary.phonenumber
    set Global Variable    ${address_phonenumber}
    input text    id:Address_FirstName    ${address_first_name}
    input text    id:Address_LastName    ${address_last_name}
    input text    id:Address_Email    ${address_email}
    input text    id:Address_Company    ${address_company}
    select from list by label    Address.CountryId    United States
    Sleep    1s
    select from list by label    Address.StateProvinceId    Alaska
    input text    id:Address_City    ${address_city}
    input text    id:Address_Address1    ${address_address}
    input text    id:Address_ZipPostalCode    ${address_zipcode}
    input text    id:Address_PhoneNumber    ${address_phonenumber}
    click element    xpath://button[contains(text(),'Save')]
    page should contain element    xpath://p[contains(text(),'The new address has been added successfully.')]

Edit the address
    click element    xpath://button[contains(text(),'Edit')]
    page should contain element    xpath://h1[contains(text(),'My account - Edit address')]
    ${address_faxnumber} =  FakerLibrary.phonenumber
    set Global Variable    ${address_faxnumber}
    input text    id:Address_FaxNumber    ${address_faxnumber}
    click element    xpath://button[contains(text(),'Save')]

Delete the address
    click element    xpath://button[contains(text(),'Delete')]
    Sleep    1s
    handle alert    dismiss
    click element    xpath://button[contains(text(),'Delete')]
    Sleep    1s
    handle alert    accept
    Sleep    1s
    page should contain element    xpath://div[contains(text(),'No addresses')]

#my account page - change password section
Navigate to change password section
    click link    xpath://a[contains(text(),'Change password')]
    Sleep    1s
    page should contain element    xpath://h1[contains(text(),'My account - Change password')]

Change the password
    input text    id:OldPassword    ${user_password}
    input text    id:NewPassword    ${user_new_password}
    input text    id:ConfirmNewPassword    ${user_new_password}











    







