*** Settings ***
Documentation       Keywords used in ability-related tests

Resource            common.resource
Library             JSONSchemaLibrary


*** Keywords ***
Get Ability By Name
    [Documentation]
    ...    Fetches Ability data from PokeAPI by name
    ...    and returns the full response object.
    [Arguments]    ${ability_name}

    ${response}=    GET On Session
    ...    pokeapi
    ...    ${ABILITY_API}/${ability_name}
    ...    expected_status=any

    RETURN    ${response}

Ability Should Exist
    [Documentation]
    ...    Verifies that a Ability exists in the PokeAPI by
    ...    checking that the response status code is 200 (OK).
    [Arguments]    ${response}

    Should Be Equal As Integers    ${response.status_code}    200

Ability Should Not Exist
    [Documentation]
    ...    Verifies that a Ability does not exist in the
    ...    PokeAPI by checking that the response status code is 404 (Not Found).
    [Arguments]    ${response}

    Should Be Equal As Integers    ${response.status_code}    404

Get Ability Json
    [Documentation]
    ...    Extracts and returns the JSON data from a Ability API response.
    ...    This is useful for schema validation and direct data inspection.
    [Arguments]    ${name}

    ${response}=    Get Ability By Name    ${name}

    RETURN    ${response.json()}

Ability Response Should Match Schema
    [Documentation]
    ...    Validates that a Ability's API response matches the expected
    ...    JSON schema, ensuring all required fields and Abilities are correct.
    ...    Fetches the Ability data and validates against the provided schema.
    [Arguments]    ${ability_name}    ${schema}

    ${json}=    Get Ability Json    ${ability_name}

    Validate Json
    ...    ${schema}
    ...    ${json}
