*** Settings ***
Documentation       Pokemon Type Test Suite
...                 Includes tests for validating the type of a Pokemon.

Resource            ../../resources/keywords/common.resource
Resource            ../../resources/keywords/pokemon_keywords.resource
Library             ../../libraries/pokemon_library.py

Suite Setup         Create PokeAPI Session
Test Teardown       Sleep    0.2


*** Test Cases ***
Verify Charmander Has One Type
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request pokemon Charmander
    ...    Then it should be a single-type pokemon
    ${response}=    Get Pokemon By Name    charmander
    Pokemon Should Have One Type    ${response}

Verify Charmander Is Fire Type
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request pokemon Charmander
    ...    Then it should have Fire on its type.
    ${response}=    Get Pokemon By Name    charmander
    ${type_result}=    Has Type    ${response}    fire
    Should Be True    ${type_result}

Verify Bulbasaur Has Two Types
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request pokemon Bulbasaur
    ...    Then it should be a dual-type pokemon
    ${response}=    Get Pokemon By Name    bulbasaur
    Pokemon Should Have Two Types    ${response}

Verify Bulbasaur Is Grass Poison Type
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request pokemon Bulbasaur
    ...    Then it should have Grass and Poison on its type.
    ${response}=    Get Pokemon By Name    bulbasaur

    ${type_result}=    Has Type    ${response}    grass
    Should Be True    ${type_result}

    ${type_result}=    Has Type    ${response}    poison
    Should Be True    ${type_result}

Verify Squirtle Is Not a Normal Type
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request pokemon Squirtle
    ...    Then it should not have Normal on its type.
    ${response}=    Get Pokemon By Name    Squirtle

    ${type_result}=    Has Type    ${response}    normal
    Should Not Be True    ${type_result}
