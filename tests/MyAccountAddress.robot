*** Settings ***
Library    SeleniumLibrary
Library    String
Library    BuiltIn
Library    FakerLibrary
Resource    ../resources/variables.robot
Resource  ../resources/keywords.robot


*** Variables ***


*** Test Cases ***
Navigate to address 
    open browser    ${url}    ${browser}
    maximize browser window
    Sleep    1s 
    Register
    Navigate to my account
    Navigate to address section

Add an address
    Add a new address

Edit the added address
    Edit the address

Delete the added address
    Delete the address
    close browser

*** Keywords ***