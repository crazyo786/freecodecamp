#!/bin/bash
# Variables for Selecting database
if [[  $1 == "test" ]]
then
	SA_DB="salon_test"
	USR="postgres"
else
	SA_DB="salon"
	USR="freecodecamp"
fi 

#Variable for Psql Program
PSQL="psql -X --username=$USR --dbname=$SA_DB --no-align --tuples-only -c"

#Turncate Tables
$($PSQL "TURNCATE TABLE customers, services, appointments" &> /dev/null)

#Inserting Values to Salon Database

cat ./raw/services.list | while read SERVICES_LIST
do
	if  ! $($PSQL "INSERT INTO services(name) VALUES('$SERVICES_LIST')" &> /dev/null) 
	then
		sleep 1
		echo -e "\nServices List : $SERVICES_LIST : Already Exist ....Skipping"
		
	else
		sleep 1
		echo -e "\nServices List : $SERVICES_LIST : Imported to Database"
	fi 

done
 sleep 1
 echo -e "\nDatabase Setup : Complete"
 sleep 1
 echo -e "\nInitalizing : Database User Interface ....Please Wait "
 sleep 5
 clear
 echo "$($PSQL "SELECT * FROM services")"
