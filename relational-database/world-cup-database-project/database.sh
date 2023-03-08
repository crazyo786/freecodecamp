#! /bin/bash

# *********************************** #
# 				      #
# ---- This Script is Created By ---- #
# 				      #
# ----------- crazyo786 ------------- #
# 				      #
# --- https://github.com/crazyo786 -- #
# 				      #
# *********************************** #

# ************************************************************************************** #
#											 #
#					  NOTE :					 #
#											 #
# 	THIS SCRIPT IS BUILD FOR THE FREECODECAMP CURRICULUM "RELATIONAL DATABASE"	 #
#		UNDER THE PROJECT "BUILD A WORLD CUP DATABASE" BY USER			 #
#					@crazyo786 					 #		
#											 #
#										         #
#  	      				DISCLAMIER :  					 #
# 											 #
#  THIS SCRIPT IS A SELF ENDEAVOUR WORK BEYOND PROJECT GOALS, AS IT AUTOMATE THE PROCESS #
#	OF CREATING AND DROPPING DATABASES AND ALSO CREATING TABLES WITHOUT MANUALLY	 #
#		     HARD CODING USING PSQL COMMAND PROMPT				 #
# 											 #
# ************************************************************************************** #


# A Script to Build Database and Create Tables

# START ---- Initalizing and Creating Database ---- SECTION #

# Setting Variables for Users and Database

if [[ $1 = 'test' ]]
then
	DB="postgres"
	WC_DB="worldcuptest"
	USR="postgres"
else
	DB="postgres"
	WC_DB="worldcup"
	USR="freecodecamp"
fi

# Variable for running Psql through script

PSQL="psql -X --username=$USR --dbname=$DB --no-align --tuples-only -c"

# Dropping the Database if Exist

$($PSQL "DROP DATABASE $WC_DB" &> /dev/null)

STATUS=$?

if  [[ $STATUS != 0 ]]
then
	sleep 1	
	echo "Checking Complete : Database does not Exist..." 

	sleep 1
	echo "Creating Database"
else 
	sleep 1
	echo "Deleting Existing Database : Complete"
fi

# Creating Database

$($PSQL "CREATE DATABASE $WC_DB" &> /dev/null )
STATUS=$?

if [[ $STATUS != 0 ]]
then
	sleep 1 
	echo "Database Already Exist... Skipping" 

	sleep 1 
	echo "Connected to Database..."

	sleep 1
	echo "Now Creating Teams Table..."
else
	sleep 1
	echo "Database Created Successfully..." 

	sleep 1
	echo "Connected to Database..."

	sleep 1 
	echo "Now Creating Teams Table..."
fi


# END ---- Initalizing and Creating Database ---- SECTION #


# START ---- Creating Tables in Database ---- SECTION #


# Variable to run Psql with the Newly Created Database in the script

PSQL="psql -X --username=$USR --dbname=$WC_DB --no-align --tuples-only -c" 

# Creating Table Teams in Database 

$($PSQL "CREATE TABLE teams(team_id SERIAL PRIMARY KEY, name VARCHAR(50) UNIQUE NOT NULL )" &> /dev/null )
STATUS=$?

if [[ $STATUS != 0 ]] 
then
	sleep 1 
	echo "Teams Table Already Exist... Skipping" 

	sleep 1 
	echo "Now Trying to Create Games Table..."
else
	sleep 1 
	echo "Teams Table Created Successfully..."

	sleep 1 
	echo "Now Trying to Create Games Table..."
fi

#Creating Table Games in Database

$($PSQL "CREATE TABLE games(game_id SERIAL PRIMARY KEY, year INT NOT NULL, round VARCHAR(50) NOT NULL, winner_id INT NOT NULL REFERENCES teams(team_id), opponent_id INT NOT NULL REFERENCES teams(team_id), winner_goals INT NOT NULL, opponent_goals INT NOT NULL)" &> /dev/null)
STATUS=$?

if [[ $STATUS != 0 ]]
then
	sleep 1 
	echo "Games Table Already Exist... Skipping"
else
	sleep 1 
	echo "Games Table Created Successfully..."
fi


# END ---- Creating Tables in Database ---- SECTION #
