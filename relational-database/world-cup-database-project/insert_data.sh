#! /bin/bash

# *********************************** #
# 		                      		      #
# ---- This Script is Created By ---- #
# 		                      		      #
# ----------- crazyo786 ------------- #
# 	                      			      #
# --- https://github.com/crazyo786 -- #
# 			                      	      #
# *********************************** #

# ************************************************************************************** #
# 								                                                          		         #
#  				                           	  NOTE :		                          		         #
# 		                                                                									 #
#    	 THIS SCRIPT IS BUILD FOR THE FREECODECAMP CURRICULUM "RELATIONAL DATABASE"	       #
#		           UNDER THE PROJECT "BUILD A WORLD CUP DATABASE" BY USER	              		 #
#				                              @crazyo786 	                               				 #
# 											                                                                 #
# ************************************************************************************** #


# Script to Insert from Data File to Database


# START ---- Initalizing and Cleaning Database ---- SECTION #

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Clearing the Tables Values in Database

$($PSQL "TRUNCATE TABLE games, teams" &> /dev/null)

# Verifying the Status of the Above Command 

STATUS=$?

if [[ $STATUS != 0 ]]
then
	echo "Error During Truncation : Exiting..."

	sleep 1 
	exit
else
	sleep 1 
	echo "Cleaning Database Tables : Completed"
fi


# END ---- Initalizing and Cleaning Database ---- SECTION # 


# START ---- Importing Data from File and Exporting to Database ---- SECTION #


# Importing CSV Data File to Variable

cat games.csv | while IFS="," read YR RD WN OP WNG OPG
do
	if [[ $WN != "winner" ]]

	then
		# Getting Empty team_id Rows from Database
	 
	 TM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WN' AND name= '$OP'")

	 # Inserting Values in the Empty Rows of the team_id column

	if [[ -z $TM_ID ]]
	then
		 ($PSQL "INSERT INTO teams(name) VALUES ('$WN')" &> /dev/null) 

		 # Verifying the Status of the Above Command

		 STATUS=$?

		 if [[ $STATUS == 0 ]]
		 then
			 # To get detailed output add $STATUS != 0 and remove comment "#" from below statments

			 #echo "Name : $WN  Already Exist...Skipping"
		 #else 
			 
			 echo "Inserted Winner Data - Name : $WN"
		 fi

		 $($PSQL "INSERT INTO teams(name) VALUES ('$OP')" &> /dev/null) 
	
		 # Verifying the Status of the Above Command

		 STATUS=$?

		 if [[ $STATUS == 0 ]]
		 then
			 # To get detailed output remove the code comment from :' to ' and add $STATUS != 0

			 #echo "Name : $OP  Already Exist...Skipping"
		 #else 
			 
			 echo "Inserted Opponent Data - Name : $OP" 

		 fi
	fi 
		
	# Getting Winner and Opponent ID from Database
	
	WN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WN'")

	OP_ID=$($PSQL "SELECT team_id FROm teams WHERE name='$OP'")

	# Inserting Games Data in Database
	
	$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id) VALUES ($YR, '$RD', $WNG, $OPG, $WN_ID, $OP_ID)" &> /dev/null )
	
	STAUTS=$?

	if [[ $STATUS == 0 ]]
	then
		echo "Inserted Game Data : $YR  $RD  $WN_ID VS $OP_ID, SCORE $WNG : $OPG" 
	fi
	fi
	
done

# END ---- Importing Data from File and Exporting to Database ---- SECTION #

# START --- RESULT --- SECTION #

sleep 1

echo -e "\n**** Script Executed Successfully ****\n"
echo -e "	  **** RESULTS **** 		 "

echo -e "\nTotal Rows Inserted In Teams Table : $($PSQL "SELECT COUNT(team_id) FROM teams")"

echo -e "\nTotal Rows Inserted In Games Table : $($PSQL "SELECT COUNT(game_id) FROM games")"

echo -e "\n	  ***************** 		 "


# END --- RESULT --- SECTION #
