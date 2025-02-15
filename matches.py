from flask import Flask, jsonify
import json
import random

app = Flask(__name__)

def load_data():
    """Loads the club and player data from the JSON file."""
    try:
        with open("Algerian_fantasy_data.json", "r", encoding="utf-8") as file:
            data = json.load(file)
        return data
    except FileNotFoundError:
        return {"error": "JSON file not found"}
    except json.JSONDecodeError:
        return {"error": "Invalid JSON format"}

def generate_matches(data):
    """Generates and returns match results."""
    if "error" in data:
        return data  # Return error if data loading failed

    teams = data["clubs"]
    random.shuffle(teams)
    week_matches = [(teams[i], teams[i + 1]) for i in range(0, 16, 2)]

    def get_players_by_position(team, positions):
        return [p["name"] for p in team["players"] if p["position"] in positions]

    def get_random_players(team, count):
        players = [p["name"] for p in team["players"]]
        return random.sample(players, min(count, len(players)))

    match_results = []
    for match in week_matches:
        team1, team2 = match
        team1_score = random.randint(0, 5)
        team2_score = random.randint(0, 5)

        team1_scorers = get_players_by_position(team1, ["FW", "MF"])
        if not team1_scorers:
            team1_scorers = get_random_players(team1, team1_score)
        else:
            team1_scorers = random.choices(team1_scorers, k=team1_score)

        team2_scorers = get_players_by_position(team2, ["FW", "MF"])
        if not team2_scorers:
            team2_scorers = get_random_players(team2, team2_score)
        else:
            team2_scorers = random.choices(team2_scorers, k=team2_score)

        team1_assists = get_players_by_position(team1, ["MF", "FW"])
        if not team1_assists:
            team1_assists = get_random_players(team1, team1_score)
        else:
            team1_assists = random.choices(team1_assists, k=team1_score)

        team2_assists = get_players_by_position(team2, ["MF", "FW"])
        if not team2_assists:
            team2_assists = get_random_players(team2, team2_score)
        else:
            team2_assists = random.choices(team2_assists, k=team2_score)

        team1_yellows = get_random_players(team1, random.randint(0, 3))
        team2_yellows = get_random_players(team2, random.randint(0, 3))

        team1_reds = get_random_players(team1, random.randint(0, 1))
        team2_reds = get_random_players(team2, random.randint(0, 1))

        match_data = {
            "team1": {
                "name": team1["club_name"],
                "score": team1_score,
                "scorers": team1_scorers,
                "assists": team1_assists,
                "yellow_cards": team1_yellows,
                "red_cards": team1_reds,
            },
            "team2": {
                "name": team2["club_name"],
                "score": team2_score,
                "scorers": team2_scorers,
                "assists": team2_assists,
                "yellow_cards": team2_yellows,
                "red_cards": team2_reds,
            },
        }
        match_results.append(match_data)

    return {"matches": match_results}

def load_players():
    """Loads the club and player data from the JSON file."""
    try:
        with open("Algerian_fantasy_data.json", "r", encoding="utf-8") as file:
            data = json.load(file)
        return data
    except FileNotFoundError:
        return {"error": "JSON file not found"}
    except json.JSONDecodeError:
        return {"error": "Invalid JSON format"}

@app.route('/players')
def get_players():
    """Returns detailed player data as JSON."""
    data = load_players()
    if "error" in data:
        return jsonify(data), 400

    all_players = []
    for club in data["clubs"]:
        for player in club["players"]:
            player_data = {
                "name": player["name"],
                "position": player["position"],
                "price": player["price"],
                "club_name": club["club_name"],
                "kit_image_url": club["kit_image_url"], # Include kit image
                "author": club.get("author", "Unknown") # include author or unknown if not found.
            }
            all_players.append(player_data)

    return jsonify({"players": all_players})


@app.route('/matches')
def get_matches_json():
    """Returns the match results as JSON."""
    data = load_data()
    matches = generate_matches(data)
    return jsonify(matches)

if __name__ == '__main__':
    app.run(debug=True)