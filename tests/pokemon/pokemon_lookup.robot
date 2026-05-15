*** Settings ***
Documentation       Pokemon Lookup Test Suite
...                 Tests that verify Pokemon data can be successfully retrieved from the PokeAPI.
...                 Includes tests for validating Pokemon existence and correct data attributes.

Resource            ../../resources/keywords/common.resource
Resource            ../../resources/keywords/pokemon_keywords.resource
Library             ../../libraries/pokemon_library.py
Library             CSVLibrary

Suite Setup         Create PokeAPI Session
Test Teardown       Sleep    0.2


*** Variables ***
${CSV_FILE}     ${EXECDIR}/data/pokemon_lookup.csv


*** Test Cases ***
Verify Pikachu Exists
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request pokemon Pikachu
    ...    Then the pokemon exists and the name is correct

    ${response}=    Get Pokemon By Name    pikachu

    Pokemon Name Should Be    ${response}    pikachu
    Pokemon Should Exist    ${response}

Verify Charmander Exists
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request pokemon Charmander
    ...    Then the pokemon exists and the name is correct

    ${response}=    Get Pokemon By Name    charmander

    Pokemon Name Should Be    ${response}    charmander
    Pokemon Should Exist    ${response}

Verify Agumon Does Not Exist
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request digimon Agumon
    ...    Then the digimon does not exist

    ${response}=    Get Pokemon By Name    agumon

    Pokemon Should Not Exist    ${response}

Verify All Pokemon From Csv
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request pokemons from the csv
    ...    Then all of them exist
    @{rows}=    Read Csv File To Associative    ${CSV_FILE}

    FOR    ${row}    IN    @{rows}
        VAR    ${pokemon}=    ${row}[pokemon]
        VAR    ${type1}=    ${row}[type1]
        VAR    ${type2}=    ${row}[type2]

        ${response}=    Get Pokemon By Name    ${pokemon}

        Pokemon Should Exist    ${response}
        Pokemon Should Have Type    ${response}    ${type1}

        IF    '${type2}' != 'None'
            Pokemon Should Have Type    ${response}    ${type2}
        END
    END
