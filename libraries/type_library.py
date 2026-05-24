from requests import Response


def is_weak_to(type_response: Response, stronger_type: str) -> bool:
    type_json = type_response.json()

    return stronger_type in type_json["damage_relations"]["double_damage_from"]


def is_strong_against(type_response: Response, weaker_type: str) -> bool:
    type_json = type_response.json()

    return weaker_type in type_json["damage_relations"]["double_damage_to"]


def is_resistant_to(type_response: Response, weaker_type: str) -> bool:
    type_json = type_response.json()

    return weaker_type in type_json["damage_relations"]["half_damage_from"]


def deals_half_damage_to(type_response: Response, stronger_type: str) -> bool:
    type_json = type_response.json()

    return stronger_type in type_json["damage_relations"]["half_damage_to"]


def is_immune_to(type_response: Response, type_name: str) -> bool:
    type_json = type_response.json()

    return type_name in type_json["damage_relations"]["no_damage_from"]


def no_effect_on(type_response: Response, type_name: str) -> bool:
    type_json = type_response.json()

    return type_name in type_json["damage_relations"]["no_damage_to"]


def has_no_immunities(type_response: Response) -> bool:
    type_json = type_response.json()

    return len(type_json["damage_relations"]["no_damage_from"]) == 0


def has_no_unaffected_types(type_response: Response) -> bool:
    type_json = type_response.json()

    return len(type_json["damage_relations"]["no_damage_to"]) == 0


def type_has_pokemon(type_response: Response, pokemon_name: str) -> bool:
    type_json = type_response.json()

    for pokemon in type_json["pokemon"]:
        if pokemon_name in pokemon["pokemon"]["name"]:
            return True
    return False
