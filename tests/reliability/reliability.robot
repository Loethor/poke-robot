*** Settings ***
Documentation       Pokemon API Reliability Test Suite
...                 Validates the stability, consistency, and resilience of the PokéAPI.

Resource            ../../resources/keywords/common.resource
Resource            ../../resources/keywords/pokemon_keywords.resource

Suite Setup         Create PokeAPI Session
Test Teardown       Sleep    0.2


*** Test Cases ***
Verify Pokemon Response Is Consistent Across Calls
    [Documentation]
    ...    Given the PokéAPI is available
    ...    When the same Pokémon is requested multiple times
    ...    Then the responses should be identical and consistent
    [Tags]    reliability    stability    smoke

    ${r1}=    Get Pokemon By Name    pikachu
    ${r2}=    Get Pokemon By Name    pikachu

    Pokemon Name Should Be    ${r1}    pikachu
    Pokemon Name Should Be    ${r2}    pikachu

    Should Be Equal    ${r1.json()}    ${r2.json()}

Verify Pokemon Endpoint Survives Burst Requests
    [Documentation]
    ...    Given the PokéAPI is available
    ...    When multiple rapid requests are sent to the same endpoint
    ...    Then the API should remain stable and return valid responses
    [Tags]    reliability    load

    FOR    ${i}    IN RANGE    20
        ${response}=    Get Pokemon By Name    charizard
        Pokemon Should Exist    ${response}
    END

Verify Invalid Requests Do Not Break API
    [Documentation]
    ...    Given the PokéAPI is available
    ...    When an invalid Pokémon is requested
    ...    Then the API should handle the error safely and remain functional afterwards
    [Tags]    reliability    negative    stability

    Get Pokemon By Name    MissigNO
    Get Pokemon By Name    pikachu

    ${response}=    Get Pokemon By Name    pikachu
    Pokemon Should Exist    ${response}

Verify Pokemon API Response Time Is Acceptable
    [Documentation]
    ...    Given the PokéAPI is available
    ...    When a single Pokémon is requested
    ...    Then the response time should be within acceptable performance thresholds
    [Tags]    performance    latency    smoke

    ${start}=    Get Time    epoch
    ${response}=    Get Pokemon By Name    pikachu
    ${end}=    Get Time    epoch

    Pokemon Should Exist    ${response}

    ${duration}=    Evaluate    ${end} - ${start}
    Should Be True    ${duration} < 1

Verify Pokemon API Response Multiple Calls
    [Documentation]
    ...    Given the PokéAPI is available
    ...    When multiple Pokémon requests are executed repeatedly
    ...    Then the average response time should remain within acceptable limits
    [Tags]    performance    latency    regression

    VAR    ${total}=    0

    FOR    ${i}    IN RANGE    5
        ${start}=    Get Time    epoch
        ${response}=    Get Pokemon By Name    pikachu
        ${end}=    Get Time    epoch

        Pokemon Should Exist    ${response}

        ${duration}=    Evaluate    ${end} - ${start}
        ${total}=    Evaluate    ${total} + ${duration}

        Should Be True    ${duration} < 1
    END

    ${avg}=    Evaluate    ${total} / 5

    Should Be True    ${avg} < 0.5
