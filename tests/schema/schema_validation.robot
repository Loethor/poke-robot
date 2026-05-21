*** Settings ***
Documentation       Validates Pokemon API response schemas
...
...                 This test suite ensures that API responses from PokeAPI
...                 conform to the expected JSON schemas, helping catch
...                 breaking changes or data structure inconsistencies.
...
...                 Schemas validate:
...                 - Required fields are present
...                 - Field data types are correct
...                 - Nested structures are properly formed

Resource            ../../resources/keywords/common.resource
Resource            ../../resources/keywords/pokemon_keywords.resource
Resource            ../../resources/keywords/type_keywords.resource

Suite Setup         Create PokeAPI Session
Test Teardown       Sleep    0.2


*** Variables ***
${POKEMON_SCHEMA}           pokemon.schema.json
${POKEMON_TYPE_SCHEMA}      pokemon_type.schema.json


*** Test Cases ***
Validate Pikachu Schema
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Pikachu data
    ...    Then the response structure should match the Pokemon schema
    [Tags]    schema    pokemon    smoke

    Pokemon Response Should Match Schema
    ...    pikachu
    ...    ${POKEMON_SCHEMA}

Validate Multiple Pokemon Schemas
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request data for multiple Pokemon
    ...    Then all responses should match the Pokemon schema
    [Tags]    schema    pokemon    regression

    FOR    ${pokemon}    IN
    ...    pikachu
    ...    charizard
    ...    bulbasaur
    ...    mewtwo
        Pokemon Response Should Match Schema
        ...    ${pokemon}
        ...    ${POKEMON_SCHEMA}
    END

Validate Pokemon Types Schema
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Type data (e.g., Fire)
    ...    Then the response structure should match the Type schema
    [Tags]    schema    type    smoke

    Type Response Should Match Schema    fire    ${POKEMON_TYPE_SCHEMA}
