#!/bin/bash

# *********************************** #
# 		                      		      #
# ---- This Script is Created By ---- #
# 				                            #
# ----------- crazyo786 ------------- #
# 				                            #
# --- https://github.com/crazyo786 -- #
# 				                            #
# *********************************** #

# ************************************************************************************** #
#											                                                                   #
#				                                  NOTE :		     	                  		         #
#                                                                 											 #
#         THIS SCRIPT IS BUILD FOR THE FREECODECAMP CURRICULUM "RELATIONAL DATABASE"	   #
#	           UNDER THE PROJECT "BUILD A PERIODIC TABLE DATABASE" BY USER		             #
#			                                  @crazyo786                                       #
#	                                                                                       #
#                                                                                        #
#											                  DISCLAMIER :  			                        		 #
# 										                                                                 	 #
#               THIS SCRIPT IS A SELF ENDEAVOUR WORK BEYOND PROJECT GOALS                #
#                           KINDLY READ THE COMMIT MESSAGES.                             #
#											                                                                   #
#											                                                                   #
# ************************************************************************************** #

# Assigning Argument Variable

 if [[ $1 = "test" ]] ; then
	 DB="postgres"
	 USR="postgres"
	 NDB="periodic_table"
 else
	 DB="postgres"
	 USR="freecodecamp"
	 NDB="periodic_table"
 fi

# Assigning Postgres Variables

PSQL="psql -X --username=$USR --dbname=$NDB --no-align -t -c" 

# Drop And Build Database

$(sed -E -e "s/$DB|$USR/${USR}/g" unclean_table.sql | psql -U $DB  &> /dev/null)

# Create Tables

$($PSQL "CREATE TABLE types(type_id SERIAL PRIMARY KEY,type VARCHAR(30) NOT NULL)" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "\nCreate Table types !! FAILED !!"
else
	echo -e "\nTable types Created\n $(sleep 1) \nColumn type_id Created\n $(sleep 1) \nColumn type Created"
fi 

# Create Columns

$($PSQL "ALTER TABLE properties ADD COLUMN type_id INT REFERENCES types(type_id)" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "Creating Column type_id !! FAILED !!"
else
	echo -e "\nColumn type_id Created."
fi

# Rename Columns

declare -A RNA_C=([weight]='atomic_mass' [melting_point]='melting_point_celsius' [boiling_point]='boiling_point_celsius')

for key in "${!RNA_C[@]}"
do 
	$($PSQL "ALTER TABLE properties RENAME COLUMN $key TO "${RNA_C[$key]}"" &> /dev/null)
	if [[ $? != 0 ]]; then
		sleep 1	
		echo -e "\nColumn $key Rename !! FAILED !!"
	else 
		sleep 1 
		echo -e "\nColumn $key Renamed to "${RNA_C[$key]}"" 
	fi	
done

# Array for Insert and Delete Rows

INT_TB=('tables=(types properties elements)')
for elt in "${INT_TB[@]}"
do eval $elt
done

# Delete Rows
loop=1
while [[ $loop -lt 3 ]]; do
	$($PSQL "DELETE FROM ${tables[$loop]} WHERE atomic_number in (SELECT atomic_number FROM ${tables[$loop]} ORDER BY atomic_number desc LIMIT 1)" &> /dev/null)
if [[ $? != 0 ]]; then
		echo -e "\nDeleting Unwanted Row in ${tables[$loop]} !! FAILED !!"
	else
		echo -e "\nDeleted Unwanted Row in ${tables[$loop]}"
	fi
	((loop++))
done

# Insert Rows Values

$($PSQL "INSERT INTO types(type_id, type) VALUES(1, 'metal'), (2, 'nonmetal'), (3, 'metalloid') " &> /dev/null)

	if [[ $? != 0 ]]; then
		echo -e "\nInsert Rows !! FAILED !!"
	else
		echo -e "\nInserted Rows in type Column of types Table"
	fi 

# Update type_id

UP_RO=('type_id=(1 2 3)' 'type=(metal nonmetal metalloid)')
for elt in "${UP_RO[@]}"
do eval $elt
done

loop=0
while [[ $loop -lt 3 ]]; do
	$($PSQL "UPDATE properties SET type_id=${type_id[$loop]} WHERE type='${type[$loop]}'" &> /dev/null)
	
	((loop++))
done
if [[ $? != 0 ]]; then
	echo -e "\nUpdate type_id to properties Table !! FAILED !!"
else
	echo -e "\nUpdated type_id to properties Table"
fi

# Delete type Column from properties 

$($PSQL "ALTER TABLE properties DROP COLUMN type" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "\nDROP type column in properties Table !! FAILED !!"
else
	echo -e "\nDROP type column in properties Table"

fi

# Change Row Cases

$($PSQL "UPDATE elements SET symbol = INITCAP(symbol)" &> /dev/null)
if [[ $? != 0 ]]; then
	sleep 1
	echo -e "\nConverting Row Cases !! FAILED !!"
else
	sleep 1
	echo -e "\nConverting Row Cases to INITCAP : Complete"
fi

# Array to Set Constraints

COL_CON=('tables=(elements properties)' 'columns=(symbol name melting_point_celsius boiling_point_celsius type_id)' 'constraint=(UNIQUE "NOT NULL")')
 
for elt in "${COL_CON[@]}"
do eval $elt
done

# -- Set UNIQUE Constraints
loop=0
while [[ $loop -lt 2 ]]; do

	$($PSQL "ALTER TABLE ${tables[0]} ADD UNIQUE(${columns[$loop]})" &> /dev/null)

	if [[ $? != 0 ]]  
	then
		echo -e " Set UNIQUE Constraint !! FAILED !!"
	else
		echo -e "\nUNIQUE Constraint Set to "${columns[$loop]}" Column"
	fi
	
	((loop++))
done

# -- Set NOT NULL Constraints

loop=0
index=0
while [[ $loop -lt 5 ]]
do
	if [[ $loop -eq 2 ]]; then
		index=1
	fi

	$($PSQL "ALTER TABLE ${tables[$index]} ALTER COLUMN ${columns[$loop]} SET ${constraint[1]}" &> /dev/null )

	if [[ $? != 0 ]]  
	then
		echo -e " Set NOT NULL Constraint !! FAILED !!"
	else
		echo -e "\nNOT NULL Constraint Set to "${columns[$loop]}" Column in ${tables[$index]} Table"
	fi
	
	((loop++))
done

# Change Column Data Type

$($PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL" &> /dev/null)

if [[ $? != 0 ]]; then
	echo -e "\nSet atomic_mass constraint !! FAILED !!"
else
	echo -e "\nCONSTRAINT for atomic_mass Set to DECIMAL"
fi

$($PSQL "UPDATE properties SET atomic_mass=atomic_mass::REAL" &> /dev/null)

if [[ $? != 0 ]]; then
	echo -e "\natomic_mass Turnacate decimal places !! FAILED !!"
else
	echo -e "\nDecimal place Turnacated for atomic_mass Column"
fi

# Set Column Foreign Key

$($PSQL "ALTER TABLE properties ADD CONSTRAINT atomic_number_fk FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number)" &> /dev/null)

if [[ $? != 0 ]]; then
	echo -e "\nSet Foreign Key for atomic_number Column on properties Table !! FAILED !!"
else
	echo -e "\nForeign Key added for atomic_number Column on properties Table"
fi


# Insert New Rows

$($PSQL "INSERT INTO elements(atomic_number, name, symbol) VALUES(9, 'Fluorine', 'F'), (10, 'Neon', 'Ne')" &> /dev/null) 
if [[ $? != 0 ]]; then
	echo -e "\nInsert New Values to elements Table !! FAILED !! "
else
	echo -e "\nNew Values Inserted in elements Table"
fi

$($PSQL "INSERT INTO properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9, 18.998, -220, -188.1, 2), (10, 20.18, -248.6, -246.1, 2)" &> /dev/null)
if [[ $? != 0 ]]; then
	echo -e "\nInsert New Values to properties Table !! FAILED !! "
else
	echo -e "\nNew Values Inserted in properties Table"
fi
