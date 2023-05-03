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
#	           UNDER THE PROJECT "BUILD A PERIODIC TABLE DATABASE" BY USER		 #
#			                @crazyo786                                       #
#	                                                                                 #
# ************************************************************************************** #



# Assigning Postgres Variables

PSQL="psql -X --username=freecodecamp --dbname=periodic_table  -t -c" 

# Find Argument Is Empty
 if [[ -z $1 ]] ; then
	echo "Please provide an element as an argument."
else

# Get Data From Database Based On Input

	if [[ ! $1 =~ ^[0-9]+$ ]]; then

		ELEMENTS_DATA=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol ILIKE '$1' OR name ILIKE '$1'")

	else
		ELEMENTS_DATA=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")

	fi

# Show the Result For the Input

	if [[ -z $ELEMENTS_DATA ]]; then

		echo "I could not find that element in the database."
	else

		echo $ELEMENTS_DATA | sed -e "s/|//g" | while read AN N SY TY AM MP BP 
	do 
		echo  "The element with atomic number $AN is $N ($SY). It's a $TY, with a mass of $AM amu. $N has a melting point of $MP celsius and a boiling point of $BP celsius."
	done
	fi

 fi

