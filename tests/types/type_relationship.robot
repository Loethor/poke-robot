*** Settings ***
Documentation       Pokemon Type Test Suite
...                 Includes tests for validating the type of a Pokemon.

Resource            ../../resources/keywords/common.resource
Resource            ../../resources/keywords/type_keywords.resource

Suite Setup         Create PokeAPI Session
Test Teardown       Sleep    0.2


*** Test Cases ***
Fire Type Exists
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Fire type
    ...    Then it exists
    [Tags]    type    smoke

    ${response}=    Get Type By Name    fire
    Type Should Exist    ${response}

Virus Type Does Not Exists
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Virus type
    ...    Then it does not exist
    [Tags]    type    negative    regression

    ${response}=    Get Type By Name    virus
    Type Should Not Exist    ${response}

Fire Is Weak To Water
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Fire type
    ...    Then Fire should be weak to Water
    [Tags]    type    regression

    ${response}=    Get Type By Name    fire
    Type Should Be Weak To    ${response}    water

Fire Is Strong Against Grass
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Fire type
    ...    Then Fire should be strong against Grass
    [Tags]    type    regression

    ${response}=    Get Type By Name    fire
    Type Should Be Strong Against    ${response}    grass

Water Deals Half Damage To Grass
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Water type
    ...    Then Water should deal half damage to Grass
    [Tags]    type    regression

    ${response}=    Get Type By Name    water
    Type Should Deal Half Damage To    ${response}    grass

Grass Is Resistant To Water
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Grass type
    ...    Then Grass should be resistant to Water (takes half damage)
    [Tags]    type    regression

    ${response}=    Get Type By Name    grass
    Type Should Be Resistant To    ${response}    water

Fire Has No Immunities
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Fire type
    ...    Then Fire should have no immunities
    [Tags]    type    regression

    ${response}=    Get Type By Name    fire
    Type Should Have No Immunities    ${response}

No Type Is Immune To Fire
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Fire type
    ...    Then No Type Should be immune to Fire
    [Tags]    type    regression

    ${response}=    Get Type By Name    fire
    Type Should Not Have Types With Immunity    ${response}

Normal Has No Effect On Ghost
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Normal type
    ...    Then Normal should have no effect on Ghost (Normal moves have no effect on Ghost)
    [Tags]    type    regression

    ${response}=    Get Type By Name    normal
    Type Has No Effect On    ${response}    ghost

Normal Is Immune To Ghost
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request Normal type
    ...    Then Normal should be immune to Ghost (Ghost moves have no effect on Normal)
    [Tags]    type    regression

    ${response}=    Get Type By Name    normal
    Type Should Be Immune To    ${response}    ghost
