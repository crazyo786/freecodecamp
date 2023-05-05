#!/bin/bash

# *********************************** #
# 		                      #
# ---- This Script is Created By ---- #
# 				      #
# ----------- crazyo786 ------------- #
# 				      #
# --- https://github.com/crazyo786 -- #
# 				      #
# *********************************** #

# ************************************************************************************** #
#										         #
#				           NOTE :		  			 #
#  	                  		         					 #
#         THIS SCRIPT IS BUILD FOR THE FREECODECAMP CURRICULUM "RELATIONAL DATABASE"	 #
#	           UNDER THE PROJECT "BUILD A NUMBER GUESSING GAME" BY USER		 #
#			                @crazyo786                                       #
#	                                                                                 #
# ************************************************************************************** #

# Assigning Argument Variable for Postgres

if [[ $1 = "test" ]]; then
	DB=number_guess
	USR=postgres
else
	DB=number_guess
	USR=freecodecamp
fi 

# Assigning Variable for Postgres Program

PSQL="psql --username=$USR --dbname=$DB --no-align -t -c"

# Acquiring Username

echo -e "\nEnter your username:"
read USR_NA


# Checking if User Exist in Database

if [[ -z $($PSQL "SELECT username FROM players WHERE username='$USR_NA'" 2>/dev/null) ]]; then 
	
	echo -e "\nWelcome, $USR_NA! It looks like this is your first time here.\n"

	$($PSQL "INSERT INTO players(username) VALUES('$USR_NA')" &> /dev/null)
	if [[ $? != 0 ]]; then
		echo -e "Error Updating Database !! CONTACT SUPPORT !!"
	else
		echo -e "Let's Play... Start Guessing\n" 
	fi
else 
	GM_PLY=$($PSQL "SELECT COUNT(game_id) FROM games LEFT JOIN players USING(user_id) WHERE username='$USR_NA'")

	BG=$($PSQL "SELECT MIN(number_of_guesses) FROM games LEFT JOIN players USING(user_id) WHERE username='$USR_NA' ") 

	echo -e "\nWelcome back, $USR_NA! You have played $GM_PLY games, and your best game took $BG guesses."
fi

# Set Secret Number For the Game

SC_NUM=$(( RANDOM % 1000 + 1))

GUS_CT=0

echo -e "\nGuess the secret number between 1 and 1000:"
read USR_GUS

# Set Loop Condition till Number is Guessed 

until [[ $USR_GUS == $SC_NUM ]]; do
	if [[ ! $USR_GUS =~ ^[0-9]+$  ]]; then
		echo -e "\nThat is not an integer, guess again:"
		read USR_GUS 
	else
	if [[ $USR_GUS < $SC_NUM ]]; then
		echo -e "\nIt's lower than that, guess again:"
		read USR_GUS
		((GUS_CT++))

	else 
		echo -e "\nIt's higher than that, guess again:"
		read USR_GUS
		((GUS_CT++))
	fi
	fi
done
((GUS_CT++))

# Get user_id of the Player

USR_ID=$($PSQL "SELECT user_id FROM players WHERE username='$USR_NA'")

# Insert Score to Database

$($PSQL "INSERT INTO games(user_id, number_of_guesses, secret_number) VALUES($USR_ID, $GUS_CT, $SC_NUM)" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "Error Updating the Database : !! CONTACT SUPPORT !!"
else
	echo -e "\nYou guessed it in $GUS_CT tries. The secret number was $SC_NUM. Nice job!" 
fi
