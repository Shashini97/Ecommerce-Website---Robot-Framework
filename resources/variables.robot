*** Settings ***
Library    SeleniumLibrary
Library    String
Library    BuiltIn
Library    FakerLibrary

*** Variables ***
${browser}    chrome
${url}    https://demo.nopcommerce.com/
${user_gender}    Male
# ${user_first_name}=   Generate Random String   5    [LETTERS]
# ${user_last_name}=    Generate Random String   5    [LETTERS]
${user_date_of_birth_day}    17
${user_date_of_birth_month}    1
${user_date_of_birth_year}    1997
# ${DOMAINS}    example.com    test.com    email.com
${user_email}    test@test.com
# user_company = "Test"
# user_newsletter = "true"
${user_password}    Test@123
${user_confirm_password}    Test@123


