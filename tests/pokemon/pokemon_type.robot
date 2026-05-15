*** Settings ***
Documentation       Pokemon Type Test Suite
...                 Includes tests for validating the type of a Pokemon.

Resource            ../../resources/keywords/common.resource
Resource            ../../resources/keywords/pokemon_keywords.resource
Library             ../../libraries/pokemon_library.py    AS    Pokemon

Suite Setup         Create PokeAPI Session
Test Teardown       Sleep    0.2


*** Test Cases ***
Verify Charmander Has One Type
    [Documentation]    Verify that Charmander is single type Pokemon.
    ${response}=    Get Pokemon By Name    charmander
    Pokemon Should Have One Type    ${response}

Verify Charmander Is Fire Type
    [Documentation]    Verify that Charmander is a fire type Pokemon.
    ${response}=    Get Pokemon By Name    charmander
    ${result}=    Has Type    ${response}    fire
    Should Be True    ${result}

Verify Bulbasaur Has Two Types
    [Documentation]    Verify that Bulbasaur is dual type Pokemon.
    ${response}=    Get Pokemon By Name    bulbasaur
    Pokemon Should Have Two Types    ${response}

Verify Bulbasaur Is Grass Poison Type
    [Documentation]    Verify that Bulbasaur is a grass poison type Pokemon.
    ${response}=    Get Pokemon By Name    bulbasaur

    ${grass_result}=    Has Type    ${response}    grass
    Should Be True    ${grass_result}

    ${poison_result}=    Has Type    ${response}    poison
    Should Be True    ${poison_result}
