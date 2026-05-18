*** Settings ***
Documentation       Keywords used in Pokemon-related tests

Resource            ../variables/api_variables.resource
Resource            common.resource
Library             Collections
Library             JSONSchemaLibrary
Library             ../../libraries/pokemon_library.py


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

Pokemon Should Exist
    [Documentation]
    ...    Verifies that a Pokemon exists in the PokeAPI by
    ...    checking that the response status code is 200 (OK).
    [Arguments]    ${response}

    Should Be Equal As Integers    ${response.status_code}    200

Pokemon Should Not Exist
    [Documentation]
    ...    Verifies that a Pokemon does not exist in the
    ...    PokeAPI by checking that the response status code is 404 (Not Found).
    [Arguments]    ${response}

    Should Be Equal As Integers    ${response.status_code}    404

Pokemon Name Should Be
    [Documentation]
    ...    Verifies that a Pokemon response contains the expected
    ...    name by extracting and comparing the name field from the JSON response.
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

    ${type_result}=    Has Type    ${response}    ${expected_type}
    Should Be True    ${type_result}

Pokemon Should Not Have Type
    [Documentation]
    ...    Verifies that a Pokemon response does NOT contain
    ...    the specified type by extracting all types from the response
    ...    and confirming the type is absent.
    [Arguments]    ${response}    ${expected_type}

    ${type_result}=    Has Type    ${response}    ${expected_type}
    Should Not Be True    ${type_result}

Pokemon Should Have One Type
    [Documentation]
    ...    Verifies that a Pokemon response contains exactly
    ...    one type by checking the length of the types array.
    [Arguments]    ${response}
    VAR    @{types}=    ${response.json()}[types]

    Length Should Be    @{types}    1

Pokemon Should Have Two Types
    [Documentation]
    ...    Verifies that a Pokemon response contains exactly
    ...    two types by checking the length of the types array.
    [Arguments]    ${response}
    VAR    @{types}=    ${response.json()}[types]

    Length Should Be    @{types}    2

Get Pokemon Json
    [Documentation]
    ...    Extracts and returns the JSON data from a Pokemon API response.
    ...    This is useful for schema validation and direct data inspection.
    [Arguments]    ${name}

    ${response}=    Get Pokemon By Name    ${name}

    RETURN    ${response.json()}

Pokemon Response Should Match Schema
    [Documentation]
    ...    Validates that a Pokemon's API response matches the expected
    ...    JSON schema, ensuring all required fields and types are correct.
    ...    Fetches the Pokemon data and validates against the provided schema.
    [Arguments]    ${pokemon_name}    ${schema}

    ${json}=    Get Pokemon Json    ${pokemon_name}

    Validate Json
    ...    ${schema}
    ...    ${json}
