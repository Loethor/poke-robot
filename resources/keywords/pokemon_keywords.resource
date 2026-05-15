*** Settings ***
Resource    ../variables/api_variables.resource
Resource    common.resource
Library     Collections


*** Keywords ***
Get Pokemon By Name
    [Documentation]
    ...    Fetches Pokemon data from PokeAPI by name
    ...    and returns the full response object.
    [Arguments]    ${pokemon_name}

    ${response}=    GET On Session
    ...    pokeapi
    ...    ${POKEMON_API}/${pokemon_name}
    ...    expected_status=any

    RETURN    ${response}

Pokemon Name Should Be
    [Documentation]
    ...    Asserts Pokemon name in the response.
    [Arguments]    ${response}    ${expected_name}

    VAR    ${pokemon_name}=    ${response.json()}[name]

    Should Be Equal As Strings
    ...    ${pokemon_name}
    ...    ${expected_name}

Pokemon Should Have Type
    [Documentation]
    ...    Verifies that a Pokemon response contains
    ...    the expected type by extracting all types from the response
    ...    and checking if the expected type is present.
    [Arguments]    ${response}    ${expected_type}

    VAR    &{json}=    &{response.json()}

    ${type_names}=    Evaluate
    ...    [t["type"]["name"] for t in $json["types"]]

    Should Contain
    ...    ${type_names}
    ...    ${expected_type}

Pokemon Should Have One Type
    [Documentation]
    ...    Verifies that a Pokemon response contains
    ...    one type only.
    [Arguments]    ${response}
    VAR    @{types}=    ${response.json()}[types]

    Length Should Be    @{types}    1

Pokemon Should Have Two Types
    [Documentation]
    ...    Verifies that a Pokemon response contains
    ...    two types.
    [Arguments]    ${response}
    VAR    @{types}=    ${response.json()}[types]

    Length Should Be    @{types}    2
