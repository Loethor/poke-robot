from requests import Response


def is_weak_to(response: Response, stronger_type: str) -> bool:
    pokemon_json = response.json()

    return stronger_type in pokemon_json["damage_relations"]["double_damage_from"]


def is_strong_against(response: Response, weaker_type: str) -> bool:
    pokemon_json = response.json()

    return weaker_type in pokemon_json["damage_relations"]["double_damage_to"]


def is_resistant_to(response: Response, weaker_type: str) -> bool:
    pokemon_json = response.json()

    return weaker_type in pokemon_json["damage_relations"]["half_damage_from"]


def deals_half_damage_to(response: Response, stronger_type: str) -> bool:
    pokemon_json = response.json()

    return stronger_type in pokemon_json["damage_relations"]["half_damage_to"]


def is_immune_to(response: Response, type_name: str) -> bool:
    pokemon_json = response.json()

    return type_name in pokemon_json["damage_relations"]["no_damage_from"]


def no_effect_on(response: Response, type_name: str) -> bool:
    pokemon_json = response.json()

    return type_name in pokemon_json["damage_relations"]["no_damage_to"]


def has_no_immunities(response: Response) -> bool:
    pokemon_json = response.json()

    return len(pokemon_json["damage_relations"]["no_damage_from"]) == 0


def has_no_unaffected_types(response: Response) -> bool:
    pokemon_json = response.json()

    return len(pokemon_json["damage_relations"]["no_damage_to"]) == 0
