*** Settings ***
Resource    ../variables/api_variables.resource
Resource    common.resource
Library     Collections


*** Keywords ***
Get Pokemon By Name
    [Documentation]    Fetches Pokemon data from PokeAPI by name and returns the full response object.
    [Arguments]    ${pokemon_name}

    ${response}=    GET On Session
    ...    pokeapi
    ...    ${POKEMON_API}/${pokemon_name}

    RETURN    ${response}

Pokemon Name Should Be
    [Documentation]    Asserts Pokemon name in the response.
    [Arguments]    ${response}    ${expected_name}

    VAR    ${pokemon_name}=    ${response.json()}[name]

    Should Be Equal As Strings
    ...    ${pokemon_name}
    ...    ${expected_name}

Pokemon Should Have Type
    [Documentation]    Verifies that a Pokemon response contains the expected type by extracting all types from the response and checking if the expected type is present.
    [Arguments]    ${response}    ${expected_type}

    VAR    ${json}=    ${response.json()}
    VAR    @{types}=    @{json}[types]
    VAR    @{types_name}=    @{EMPTY}

    FOR    ${type_name}    IN    @{types}[names]
        Append To List    @{types_name}    ${type_name}
    END

    Should Contain
    ...    @{types_name}
    ...    ${expected_type}
