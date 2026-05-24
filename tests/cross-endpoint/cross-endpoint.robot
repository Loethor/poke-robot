*** Settings ***
Documentation       Cross-endpoint validation test suite
...                 Verifies data consistency between related PokéAPI endpoints.
...                 Ensures that Pokémon data correctly links to Type endpoints,
...                 validating referential integrity across the API.

Resource            ../../resources/keywords/common.resource
Resource            ../../resources/keywords/pokemon_keywords.resource
Resource            ../../resources/keywords/type_keywords.resource
Resource            ../../resources/keywords/ability_keywords.resource

Suite Setup         Create PokeAPI Session
Test Teardown       Sleep    0.2


*** Test Cases ***
Verify Charizard Cross-Endpoints
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Pokémon Charizard
    ...    Then all referenced type endpoints should exist and be valid
    [Tags]    cross-endpoint    pokemon    type    regression

    ${response}=    Get Pokemon By Name    charizard
    @{types}=    Get Types    ${response}

    FOR    ${type}    IN    @{types}
        ${type_response}=    Get Type By Name    ${type}
        Type Should Exist    ${type_response}
    END

    @{abilities}=    Get Abilities    ${response}

    FOR    ${ability}    IN    @{abilities}
        ${ability_response}=    Get Ability By Name    ${ability}
        Ability Should Exist    ${ability_response}
    END
