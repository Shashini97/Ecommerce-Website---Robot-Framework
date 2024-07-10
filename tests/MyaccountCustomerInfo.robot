*** Settings ***
Library    SeleniumLibrary
Variables    ../variables.py
Resource  ../resources/keywords.robot


*** Variables ***


*** Test Cases ***
Navigate to customer info
    open browser    ${url}    ${browser}
    maximize browser window
    Sleep    1s
    Register
    loginToTheApplication
    Navigate to my account
    Verify the data in the my account
    close browser

*** Keywords ***



