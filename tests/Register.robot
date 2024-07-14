*** Settings ***
Library    SeleniumLibrary
Library    String
Library    BuiltIn
Resource    ../resources/variables.robot
Resource  ../resources/keywords.robot
Library    FakerLibrary


*** Variables ***



*** Test Cases ***
Register A New Customer
    open browser    ${url}    ${browser}
    maximize browser window
    Sleep    1s
    Mandatory field validation
    Register
    logout
    Registration form field validation
    close browser


*** Keywords ***
