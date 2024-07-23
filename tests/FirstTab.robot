*** Settings ***
Library    SeleniumLibrary
Library    String
Library    BuiltIn
Library    FakerLibrary
Resource    ../resources/variables.robot
Resource  ../resources/keywords.robot


*** Variables ***


*** Test Cases ***
Navigate to first tab 
    open browser    ${url}    ${browser}
    maximize browser window
    Sleep    1s 
    Register
    Navigate to computers section

*** Keywords ***