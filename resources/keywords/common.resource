*** Settings ***
Documentation       Common keywords used in all the tests

Library             RequestsLibrary
Resource            ../variables/api_variables.resource


*** Keywords ***
Create PokeAPI Session
    [Documentation]    Creates a HTTP session the pokemon API.
    Create Session
    ...    pokeapi
    ...    ${BASE_URL}
    ...    timeout=${TIMEOUT}
    ...    verify=true

Status Code Should Be
    [Documentation]    Performs a comparision on the status response.
    [Arguments]    ${response}    ${expected}

    Should Be Equal As Integers
    ...    ${response.status_code}
    ...    ${expected}
