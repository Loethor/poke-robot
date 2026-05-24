# poke-robot

API test automation project built with Robot Framework and Python using PokéAPI.

[![Robot Framework Tests](https://github.com/Loethor/poke-robot/actions/workflows/robot-tests.yml/badge.svg)](https://github.com/Loethor/poke-robot/actions/workflows/robot-tests.yml)

[🤖Latest report](https://loethor.github.io/poke-robot/report.html)

## Overview

This project explores API test automation using Robot Framework and PokéAPI.

It focuses on:
- reusable Robot Framework keywords
- REST API testing patterns
- positive and negative test scenarios
- data-driven testing with CSV
- GitHub Actions CI integration
- automated report publishing

## Run tests (quick start)
```bash
uv sync
uv run robot tests/
```

Optional:

```bash
uv run robot -d reports tests
uv run robot -d reports tests/pokemon
```

## Installation

1. Clone the repository
2. Install [uv](https://github.com/astral-sh/uv#installation)
3. `cd poke-robot`
4. `uv sync`


## Project structure

```
poke-robot/
├── data/
├── libraries/
├── resources/
├── schemas/
├── tests/
└── .github/workflows
```

## Examples

```robot

Verify Pikachu Exists
    [Documentation]
    ...    Given the PokeAPI is available
    ...    When we request pokemon Pikachu
    ...    Then the pokemon exists and the name is correct

    ${response}=    Get Pokemon By Name    pikachu

    Pokemon Name Should Be    ${response}    pikachu
    Pokemon Should Exist    ${response}
```



## Architecture

- Robot Framework handles test orchestration
- RequestsLibrary performs API communication
- Python helper libraries provide reusable validation logic
- CSV datasets enable data-driven testing
- GitHub Actions runs automated CI pipelines

## Technologies

- [Python](https://www.python.org/)
- [Robot Framework](https://robotframework.org/)
- [RequestsLibrary](https://pypi.org/project/requests/)
- [uv](https://docs.astral.sh/uv/)


## API Used

This project uses data from [PokéAPI](https://pokeapi.co/).

PokéAPI is a free and community-driven Pokémon REST API.


## Acknowledgements

Pokémon and Pokémon character names are trademarks of Nintendo, Game Freak, and The Pokémon Company.

This project is not affiliated with, endorsed by, or sponsored by Nintendo, Game Freak, or The Pokémon Company.

## License

This project is licensed under the MIT License.
