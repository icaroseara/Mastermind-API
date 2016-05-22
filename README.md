# Mastermind API

## Introduction
In this challenge I built a API to play Mastermind Game https://en.wikipedia.org/wiki/Mastermind_(board_game) .

## Built with
- Grape - https://github.com/ruby-grape/grape
- Ruby
- MongoDB
- Rspec
- Love
## API requests examples

### Availables Games:
curl -H "Content-Type: application/vnd.api+json" -X GET http://127.0.0.1:9393/api/v1/games/available

{
	"games": [{
		"id": "57422a5e7c26415c978f2b68"
	}, {
		"id": "57422a407c26415c8a52cb28"
	}, {
		"id": "574228667c26415ac4086c81"
	}]
}

### Create a new game
curl -H "Content-Type: application/vnd.api+json" -X POST http://127.0.0.1:9393/api/v1/games -d '{"player":{ "name": "Icaro Seara"}}'

{
	"colors": ["R", "B", "G", "Y", "O", "P", "C", "M"],
	"code_length": 8,
	"game_id": "57422c287c26415db186f554",
	"player_id": "5741b9a27c2641f95b65b335"
}

### Join a game:
curl -H "Content-Type: application/vnd.api+json" -X POST http://127.0.0.1:9393/api/v1/games/574238277c26416797461ccc/join -d '{"player":{ "name": "Icaro fahning"}}'

{
	"colors": ["R", "B", "G", "Y", "O", "P", "C", "M"],
	"code_length": 8,
	"game_id": "574232dd7c2641637faa31fb",
	"player_id": "574203837c264133d74b854e"
}

### Post a guess:
curl -H "Content-Type: application/vnd.api+json" -X POST http://127.0.0.1:9393/api/v1/games/574238277c26416797461ccc/guess -d '{"player": {"id": "574203837c264133d74b854e"}, "code": "RRRRRRRR"}'

{
	"colors": ["R", "B", "G", "Y", "O", "P", "C", "M"],
	"code_length": 8,
	"game_id": "574238277c26416797461ccc",
	"player_id": "574203837c264133d74b854e",
	"correct": 1,
	"misplaced": 0,
	"code": "RRRRRRRR",
	"solved": false,
	"time_taken": 0,
	"time_started": "2016-05-22T19:52:35.658-03:00",
	"time_limit": "2016-05-22T19:57:35.658-03:00",
	"winner": "",
	"num_guesses": 2,
	"past_guesses": [{
		"code": "RRRRRRRR",
		"correct": 1,
		"misplaced": 0,
		"player": "Icaro Seara"
	}, {
		"code": "RRRRRRRR",
		"correct": 1,
		"misplaced": 0,
		"player": "Icaro fahning"
	}]
}

#### 
{
	"colors": ["R", "B", "G", "Y", "O", "P", "C", "M"],
	"code_length": 8,
	"game_id": "574238277c26416797461ccc",
	"player_id": "574203837c264133d74b854e",
	"correct": 8,
	"misplaced": 0,
	"code": "YROBOMCP",
	"solved": true,
	"time_taken": "69",
	"time_started": "2016-05-22T19:52:35.658-03:00",
	"time_limit": "2016-05-22T19:57:35.658-03:00",
	"winner": "Icaro fahning",
	"num_guesses": 2,
	"past_guesses": [{
		"code": "RRRRRRRR",
		"correct": 1,
		"misplaced": 0,
		"player": "Icaro fahning"
	}, {
		"code": "YROBOMCP",
		"correct": 8,
		"misplaced": 0,
		"player": "Icaro fahning"
	}]
}

### Game Status

curl -H "Content-Type: application/vnd.api+json" -X GET http://127.0.0.1:9393/api/v1/games/57423e717c26416bbc839eba/status

{
	"game": {
		"id": "57423e717c26416bbc839eba",
		"winner": null,
		"started_at": null,
		"time_limit": 0,
		"time_taken": 0,
		"solved": false
	}
}

## Running application
shotgun

## Access console
RACK_ENV="development" irb -r "./application.rb"

# Pre-Requisites
Before building, you will need to have installed in your machine the following tools:

- Ruby - 2.2.3+
- Bundler - 1.12.4+
- MongoDB - 3.2.x

## Testing application
bundle exec rspec

