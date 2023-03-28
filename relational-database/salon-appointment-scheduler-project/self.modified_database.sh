#!/bin/bash

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
#				        NOTE :		     			         #
# 											 #
#     THIS SCRIPT IS BUILD FOR THE FREECODECAMP CURRICULUM "RELATIONAL DATABASE"	 #
#	 UNDER THE PROJECT "BUILD A SALON APPOINTMENT SCHEDULER" BY USER		 #
#			              @crazyo786               				 #		
#											 #
#										         #
#  	      			     DISCLAMIER :  					 #
# 											 #
#  THIS SCRIPT IS A SELF ENDEAVOUR WORK BEYOND PROJECT GOALS, KINDLY READ THE COMMIT     #
#		MESSAGES AND REFER " database.sh " FILE TO IDENTIFY THE MODIFICATION 	 #
#				DONE IN THIS SCRIPT            				 #
# 											 #
# ************************************************************************************** #



# A Script Drop and Create Database

# Preset Variables

if [[ $1 == "test" ]]
then
	DB="postgres"
	SA_DB="salon_test"
	USR="postgres"
else
	DB="postgres"
	SA_DB="salon"
	USR="freecodecamp"
fi

# Variable to use Psql Program

PSQL="psql -X --username=$USR --dbname=$DB --no-align --tuples-only -c"  

# Dropping Existing Databases;

if ! $($PSQL "DROP DATABASE $SA_DB" &> /dev/null)
then 
	sleep 1
	echo -e "\nChecking Database : Complete ** DATABASE DOES NOT EXIST **"
	sleep 1
	echo -e "\nCreating Database : In Progress"
else
	sleep 1
	echo -e "\nDeleting Existing Database : Complete"
	sleep 1
	echo -e "\nCreating Database : In Progress"
fi
	
# Creating Database 

if ! $($PSQL "CREATE DATABASE $SA_DB" &> /dev/null) 
then
	sleep 1
	echo -e "\nChecking Database : Complete ** DATABASE ALREADY EXIST ** : ...Skipping"
	sleep 1
	echo -e "\nConnecting to Database : In Progress"
	sleep 1
	echo -e "\nConnection to Database : Established"
	sleep 1
	echo -e "\nInitalizing.... : Tables for Salon Database"

else
	sleep 1
	echo -e "\nCreating Database : Complete ** DATABASE SALON CREATED SUCESSFULLY **"
	sleep 1
	echo -e "\nConnecting to Databse : In Progress"
	sleep 1
	echo -e "\nConnection to Database : Established"
	sleep 1
	echo -e "\nInitalizing.... : Tables for Salon Database"
fi

# Variable to Connect Psql program to New Database

PSQL="psql -X --username=$USR --dbname=$SA_DB --no-align --tuples-only -c"

# Creating Customers Table 

if ! $($PSQL "CREATE TABLE customers(customer_id SERIAL PRIMARY KEY, name VARCHAR(50), phone VARCHAR(12) UNIQUE )" &> /dev/null)
then
	sleep 1
	echo -e "\nTable Customers : Already Exist"
	sleep 1
	echo -e "\nInitalizing.... In Progress : Creating Services Table "
else
	sleep 1
	echo -e "\nCreating Table Customers : Complete"
	sleep 1
	echo -e "\nInitializing.... : Creating Services Table"
fi
	
# Creating Services Tables

if ! $($PSQL "CREATE TABLE services(service_id SERIAL PRIMARY KEY, name VARCHAR(50))" &> /dev/null)
then
	sleep 1
	echo -e "\nTable Services : Already Exist"
	sleep 1
	echo -e "\nInitalizing.... In Progress : Creating Appointment Table"
else
	sleep 1
	echo -e "\nCreating Table Services : Complete"
	sleep 1
	echo -e "\nInitializing.... : Creating Appointment Table"
fi

# Creating Appointment Tables

if ! $($PSQL "CREATE TABLE appointments(appointment_id SERIAL PRIMARY KEY, customer_id INT REFERENCES customers(customer_id), service_id INT REFERENCES services(service_id),time VARCHAR(5), am_pm VARCHAR(10))" &> /dev/null)
then
	sleep 1
	echo -e "\nTable Appointment : Already Exist"
	sleep 1
	echo -e "\nInitalizing.... In Progress : Script for Data Import"
else
	sleep 1
	echo -e "\nCreating Table Appointments : Complete"
	sleep 1
	echo -e "\nInitializing.... : Script for Data Import"
fi


