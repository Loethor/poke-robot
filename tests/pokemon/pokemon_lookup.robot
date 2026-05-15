*** Settings ***
Documentation       Pokemon Lookup Test Suite
...                 Tests that verify Pokemon data can be successfully retrieved from the PokeAPI.
...                 Includes tests for validating Pokemon existence and correct data attributes.

Resource            ../../resources/keywords/common.resource
Resource            ../../resources/keywords/pokemon_keywords.resource

Suite Setup         Create PokeAPI Session
Test Teardown       Sleep    0.2


*** Test Cases ***
Verify Pikachu Exists
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request pokemon Pikachu
    ...    Then we receive a successful response and the correct Pokemon name

    ${response}=    Get Pokemon By Name    pikachu

    Pokemon Name Should Be    ${response}    pikachu
    Pokemon Should Exist    ${response}

Verify Charmander Exists
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request pokemon Charmander
    ...    Then we receive a successful response and the correct Pokemon name

    ${response}=    Get Pokemon By Name    charmander

    Pokemon Name Should Be    ${response}    charmander
    Pokemon Should Exist    ${response}

Verify Agumon Does Not Exist
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request digimon Agumon
    ...    Then we receive a bad request response

    ${response}=    Get Pokemon By Name    agumon

    Pokemon Should Not Exist    ${response}
