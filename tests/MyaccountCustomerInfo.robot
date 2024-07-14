*** Settings ***
Library    SeleniumLibrary
Library    String
Library    BuiltIn
Library    FakerLibrary
Resource    ../resources/variables.robot
Resource  ../resources/keywords.robot


*** Variables ***


*** Test Cases ***
Navigate to customer info
    open browser    ${url}    ${browser}
    maximize browser window
    Sleep    1s 
    Register
    Navigate to my account
    Verify the data in the my account
    Update the information
    Check updated data
    close browser

*** Keywords ***



