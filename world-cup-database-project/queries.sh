#! /bin/bash

if [[ $1 = "test" ]]
then
	DB="worldcuptest"
	USR="postgres"
else
	DB="worldcup"
	USR="freecodecamp"
fi

# create variable PSQL to allow us to query database

PSQL="psql --username=$USR --dbname=$DB --no-align --tuples-only -c"

# Investigating the data 
# to run script: ./insert_data.sh

echo -e "\nTotal number of goals in all games from winning teams:"

echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"

echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"

echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"

echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"

echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"

echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"

echo "$($PSQL "SELECT COUNT(winner_goals) FROM games  WHERE winner_goals > 2")" 

echo -e "\nWinner of the 2018 tournament team name:"

echo "$($PSQL "SELECT name FROM teams FULL JOIN games ON teams.team_id = games.winner_id WHERE year=2018  ORDER BY games.winner_goals DESC LIMIT 1")" 

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"

echo "$($PSQL "SELECT name FROM teams LEFT JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE year = 2014 AND round LIKE 'Eighth-Final' ORDER BY name")"

echo -e "\nList of unique winning team names in the whole data set:"

echo "$($PSQL "SELECT DISTINCT(name) FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE CAST (winner_id AS TEXT ) LIKE '%' ORDER BY name")"

echo -e "\nYear and team name of all the champions:"

echo "$($PSQL "SELECT year, name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE round = 'Final' ORDER By year")"

echo -e "\nList of teams that start with 'Co':"

echo "$($PSQL "SELECT name FROM teams WHERE name ILIKE 'Co%'")"