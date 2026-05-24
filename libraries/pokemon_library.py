from requests import Response


def has_type(response: Response, expected_type: str) -> bool:
    pokemon_json = response.json()
    types = [pokemon_type["type"]["name"] for pokemon_type in pokemon_json["types"]]

    return expected_type in types


def get_types(response: Response) -> list[str]:
    pokemon_json = response.json()
    return [pokemon_type["type"]["name"] for pokemon_type in pokemon_json["types"]]


def get_abilities(response: Response) -> list[str]:
    pokemon_json = response.json()
    return [
        pokemon_ability["ability"]["name"]
        for pokemon_ability in pokemon_json["abilities"]
    ]
