from flask import Flask
from flask import render_template, request
from mydb.connection import Connection


app = Flask(__name__)

@app.route('/')
def list():
	return render_template('table.html', entrants=get_sorted_entrants())

@app.route('/entrant/<int:entrant_id>')
def entrant(entrant_id):
	db = getdb()
	picks=db.query("select name, c.home_team, c.away_team, c.home_score as actual_home_score, c.away_score as actual_away_score, a.home_score as picked_home_score, a.away_score as picked_away_score from entries a, entrants b, games c where a.entrant_id = b.id and a.game_id = c.id and b.id = " + str(entrant_id))
	entrant = db.get("select * from entrants where id = " + str(entrant_id))
	return render_template('entrant.html', picks=picks, entrant=entrant)

def getdb():
	return Connection("mysql://root:thatgirl@localhost:3306/footballpool")

def get_game_result(game):
	if game.home_score > game.away_score:
		return 'home'
	elif game.away_score > game.home_score:
		return 'away'
	else:
		return 'draw'

def verify_score(one, two):
	return one.home_score == two.home_score and one.away_score == two.away_score;

def get_entrant_entries(entrant_id):
	db = getdb()
	return db.query("SELECT * FROM entries WHERE entrant_id = " + str(entrant_id))

def get_sorted_entrants():
	db = getdb()
	entrants = db.query("SELECT * FROM entrants")
	games = db.query("SELECT * FROM games")
	# create a map of games
	gameMap = {}
	for game in games:
		gameMap[game.id] = game
	for entrant in entrants:
		entries = db.query("SELECT * FROM entries WHERE entrant_id = " + str(entrant.id))
		points = 0
		for entry in entries:
			actual_result = None
			game = gameMap[entry.game_id]
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
    app.run(debug=True)
