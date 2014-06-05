from flask import Flask
from flask import render_template, request
from mydb.connection import Connection


simplefootballpool = Flask(__name__)

@simplefootballpool.route('/')
def list():
	return render_template('table.html', entrants=get_sorted_entrants())

@simplefootballpool.route('/entrant/<int:entrant_id>')
def entrant(entrant_id):
    db = getdb()
    game_map = get_game_map()
    picks = db.query("select c.id as game_id, name, c.home_team, c.away_team, c.home_score as actual_home_score, c.away_score as actual_away_score, a.home_score as picked_home_score, a.away_score as picked_away_score from entries a, entrants b, games c where a.entrant_id = b.id and a.game_id = c.id and b.id = " + str(entrant_id))
    for pick in picks:
        if pick['actual_home_score'] == pick['picked_home_score'] and pick['actual_away_score'] == pick['picked_away_score']:
            pick['score_prediction_points'] = 5
        else:
            pick['score_prediction_points'] = 0
        game = game_map[pick.game_id]
        actual_result = get_game_result(game)
        picked_result = get_game_result(pick, 'picked_home_score', 'picked_away_score')

        if actual_result == picked_result:
           pick['result_prediction_points'] = 3
        else:
           pick['result_prediction_points'] = 0

    result_points = 0
    score_points = 0
    total_points = 0
    for pick in picks:
        result_points = result_points + pick['result_prediction_points']
        score_points = score_points + pick['score_prediction_points']
        total_points = total_points + pick['result_prediction_points'] +  pick['score_prediction_points']

    total_points = {
        'result': result_points,
        'score': score_points,
        'total': total_points
    }

    entrant = db.get("select * from entrants where id = " + str(entrant_id))
    return render_template('entrant.html', picks=picks, entrant=entrant, total_points=total_points)

def getdb():
	return Connection("mysql://user:pass|@localhost:3306/simplefootballpool")

def get_game_result(game, home_key='home_score', away_key='away_score'):
    if game[home_key] > game[away_key]:
        return 'home'
    elif game[away_key] > game[home_key]:
        return 'away'
    else:
        return 'draw'

def verify_score(one, two):
	return one.home_score == two.home_score and one.away_score == two.away_score;

def get_entrant_entries(entrant_id):
	db = getdb()
	return db.query("SELECT * FROM entries WHERE entrant_id = " + str(entrant_id))

def get_game_map():
    db = getdb()
    games = db.query("SELECT * FROM games")
    # create a map of games
    gameMap = {}
    for game in games:
        gameMap[game.id] = game
    return gameMap

def get_sorted_entrants():
    db = getdb()
    game_map = get_game_map()
    entrants = db.query("SELECT * FROM entrants")
    for entrant in entrants:
        entries = db.query("SELECT * FROM entries WHERE entrant_id = " + str(entrant.id))
        points = 0
        for entry in entries:
            actual_result = None
            game = game_map[entry.game_id]
            actual_result = get_game_result(game)
            picked_result = get_game_result(entry)
            if actual_result == picked_result:
                points = points + 3
            if verify_score(game, entry):
                points = points + 5
        entrant['points'] = points
    entrants.sort(key=lambda x: x.points, reverse=True)
    return entrants

	
if __name__ == '__main__':
    simplefootballpool.run(debug=True)
