*** Settings ***
Documentation       Keywords used in type-related tests

Resource            common.resource
Library             JSONSchemaLibrary
Library             ../../libraries/type_library.py


*** Keywords ***
Get Type By Name
    [Documentation]
    ...    Fetches Type data from PokeAPI by name
    ...    and returns the full response object.
    [Arguments]    ${type_name}

    ${response}=    GET On Session
    ...    pokeapi
    ...    ${TYPE_API}/${type_name}
    ...    expected_status=any

    RETURN    ${response}

Type Should Exist
    [Documentation]
    ...    Verifies that a Type exists in the PokeAPI by
    ...    checking that the response status code is 200 (OK).
    [Arguments]    ${response}

    Should Be Equal As Integers    ${response.status_code}    200

Type Should Not Exist
    [Documentation]
    ...    Verifies that a Type does not exist in the
    ...    PokeAPI by checking that the response status code is 404 (Not Found).
    [Arguments]    ${response}

    Should Be Equal As Integers    ${response.status_code}    404

Type Should Be Weak To
    [Documentation]
    ...    Verifies that a type (stronger_type) is in the
    ...    "double_damage_from" field from the response type.
    [Arguments]    ${response}    ${stronger_type}
    Is Weak To    ${response}    ${stronger_type}

Type Should Be Strong Against
    [Documentation]
    ...    Verifies that a type (weaker_type) is in the
    ...    "double_damage_to" field from the response type.
    [Arguments]    ${response}    ${weaker_type}
    Is Strong Against    ${response}    ${weaker_type}

Type Should Be Resistant To
    [Documentation]
    ...    Verifies that a type (weaker_type) takes half damage from
    ...    by checking the "half_damage_from" field from the response type.
    [Arguments]    ${response}    ${weaker_type}
    Is Resistant To    ${response}    ${weaker_type}

Type Should Deal Half Damage To
    [Documentation]
    ...    Verifies that a type deals half damage to another type
    ...    by checking the "half_damage_to" field from the response type.
    [Arguments]    ${response}    ${stronger_type}
    Deals Half Damage To    ${response}    ${stronger_type}

Type Should Be Immune To
    [Documentation]
    ...    Verifies that a type is immune to another type
    ...    by checking the "no_damage_from" field from the response type.
    [Arguments]    ${response}    ${type_name}
    Is Immune To    ${response}    ${type_name}

Type Has No Effect On
    [Documentation]
    ...    Verifies that a type has no effect on another type
    ...    by checking the "no_damage_to" field from the response type.
    [Arguments]    ${response}    ${type_name}
    No Effect On    ${response}    ${type_name}

Type Should Have No Immunities
    [Documentation]
    ...    Verifies that a type has no immunities
    ...    by checking that the "no_damage_from" field is empty.
    [Arguments]    ${response}
    Has No Immunities    ${response}

Type Should Not Have Types With Immunity
    [Documentation]
    ...    Verifies that no type is immune to the requested type
    ...    by checking that the "no_damage_to" field is empty.
    [Arguments]    ${response}
    Has No Unaffected Types    ${response}

Get Type Json
    [Documentation]
    ...    Extracts and returns the JSON data from a Type API response.
    ...    This is useful for schema validation and direct data inspection.
    [Arguments]    ${name}

    ${response}=    Get Type By Name    ${name}

    RETURN    ${response.json()}

Type Response Should Match Schema
    [Documentation]
    ...    Validates that a Type's API response matches the expected
    ...    JSON schema, ensuring all required fields and types are correct.
    ...    Fetches the Type data and validates against the provided schema.
    [Arguments]    ${type_name}    ${schema}

    ${json}=    Get Type Json    ${type_name}

    Validate Json
    ...    ${schema}
    ...    ${json}
