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
#                                                                                        #
# 			                DISCLAMIER :  			                 #
# 										         #
#               THIS SCRIPT IS A SELF ENDEAVOUR WORK BEYOND PROJECT GOALS                #
#                           KINDLY READ THE COMMIT MESSAGES.                             #
#											 #
#											 #
# ************************************************************************************** #

# Assigning Argument Varaiable for Postgres

if [[ $1 = "test" ]]; then
	DB="postgres"
	USR="postgres"
	NDB="number_guess"
else
	DB="postgres"
	USR="freecodecamp"
	NDB="number_guess"
fi

# Assigning Variable for Postgres Program

PSQL="psql --username=$USR --dbname=$DB --no-align -t -c"

# Drop and Create Database

$($PSQL "DROP DATABASE $NDB" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "\nDatabase Does Not Exist : Skipping... Creating $NDB Database"
else
	echo -e "\n$NDB Database Deleted"
fi 

$($PSQL "CREATE DATABASE $NDB" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "\nDatabase Already Exist : Connecting to $NDB Database"
	echo -e "\nConnected to $NDB Database"
else
	echo -e "\n$NDB Database Created : Connecting to Database"
	echo -e "\nConnected to $NDB Database"
fi 

# Connecting to Database

PSQL="psql --username=$USR --dbname=$NDB --no-align -t -c "

# Creating Tables

$($PSQL "CREATE TABLE games()" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "\nTable games Already Exist : Skipping... Creating players Table"
else
	echo -e "\nTable games Created"
fi 

$($PSQL "CREATE TABLE players()" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "\nTable players Already Exist : Skipping... Creating Columns in games Table"
else
	echo -e "\nTable players Created"
fi 

# Creating Columns

$($PSQL "ALTER TABLE games ADD COLUMN game_id SERIAL PRIMARY KEY, ADD COLUMN user_id INT NOT NULL, ADD COLUMN number_of_guesses INT, ADD COLUMN secret_number INT" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "Columns Already Exist in games Table"
else
	echo -e "\nColumn game_id Created$(sleep 1)\n\nColumn user_id Created$(sleep 1)\n\nColumn number_of_guesses Created$(sleep 1)\n\nColumn secret_number\n"
	echo -e "Columns Created in games Table"
fi 

$($PSQL "ALTER TABLE players ADD COLUMN user_id SERIAL PRIMARY KEY, ADD COLUMN username VARCHAR(50) UNIQUE NOT NULL" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "Columns Already Exist in players Table"
else
	echo -e "\nColumn user_id Created$(sleep 1)\n\nColumn username Created\n"
	echo -e "Columns Created in players Table"
fi 

# Set Constraint 

$($PSQL "ALTER TABLE games ADD FOREIGN KEY (user_id) REFERENCES players(user_id)" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "\nUnable to Set Foreign Key to user_id in games Table"
else
	echo -e "\nForeign Key Set for user_id in games Table Referencing players(user_id)"
fi 
