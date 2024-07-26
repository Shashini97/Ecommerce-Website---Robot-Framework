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
    set selenium speed    0.125 seconds
    Register
    Verify the cart
    Navigate to first tab section
    Navigate to first tab sub section 1
    Navigate to first product

Select a product
    Select a product
    Verify the new cart

*** Keywords ***