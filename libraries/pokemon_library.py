from requests import Response


def has_type(response: Response, expected_type: str) -> bool:
    pokemon_json = response.json()
    types = [pokemon_type["type"]["name"] for pokemon_type in pokemon_json["types"]]

    return expected_type in types
