**** Settings ***
Library    SeleniumLibrary
Variables    ../variables.py
Resource  ../resources/keywords.robot

*** Variables ***



*** Test Cases ***
LoginTest
    open browser    ${url}    ${browser}
    maximize browser window   
    Sleep    1s 
    loginToTheApplication
    logout
    loginToTheApplicationWithIncorectEmail
    loginToTheApplicationWithIncorectPassword
    close browser

*** Keywords ***