*** Settings ***
Library    SeleniumLibrary
Library    String
Library    BuiltIn
Library    FakerLibrary
Resource    ../resources/variables.robot
Resource  ../resources/keywords.robot


*** Variables ***


*** Test Cases ***
Navigate to change password 
    open browser    ${url}    ${browser}
    maximize browser window
    Sleep    1s 
    Register
    Navigate to my account
    Navigate to change password section

Change the user password
    Change the password


*** Keywords ***