*** Settings ***
Documentation       Pokemon Lookup Test Suite
...                 Tests that verify Pokemon data can be successfully retrieved from the PokeAPI.
...                 Includes tests for validating Pokemon existence and correct data attributes.

Resource            ../../resources/variables/api_variables.resource
Resource            ../../resources/keywords/common.resource
Resource            ../../resources/keywords/pokemon_keywords.resource

Suite Setup         Create PokeAPI Session


*** Test Cases ***
Verify Pikachu Exists
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we fetch Pikachu data
    ...    Then we receive a successful response and the correct Pokemon name

    ${response}=    Get Pokemon By Name    pikachu

    Pokemon Name Should Be    ${response}    pikachu
    Status Code Should Be    ${response}    200

Verify Charmander Exists
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we fetch Charmander data
    ...    Then we receive a successful response and the correct Pokemon name

    ${response}=    Get Pokemon By Name    charmander

    Pokemon Name Should Be    ${response}    charmander
    Status Code Should Be    ${response}    200
