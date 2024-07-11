*** Settings ***
Library    SeleniumLibrary
Variables    ../variables.py
Resource  ../resources/keywords.robot


*** Variables ***



*** Test Cases ***
Register A New Customer
    open browser    ${url}    ${browser}
    maximize browser window
    Sleep    1s
    # Mandatory field validation
    Register
    # Registration form field validation
    close browser


*** Keywords ***
