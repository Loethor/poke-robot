*** Settings ***
Documentation       Validates Pokemon API response schemas

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
    Pokemon Response Should Match Schema
    ...    pikachu
    ...    ${POKEMON_SCHEMA}

Validate Multiple Pokemon Schemas
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
    Type Response Should Match Schema    fire    ${POKEMON_TYPE_SCHEMA}
