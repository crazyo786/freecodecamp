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
#				         NOTE :		     			         #
# 											 #
#     THIS SCRIPT IS BUILD FOR THE FREECODECAMP CURRICULUM "RELATIONAL DATABASE"	 #
#	 UNDER THE PROJECT "BUILD A SALON APPOINTMENT SCHEDULER" BY USER		 #
#			              @crazyo786               				 #		
#											 #
#										         #
#  	      			     DISCLAMIER :  					 #
# 											 #
#  THIS SCRIPT IS A SELF ENDEAVOUR WORK BEYOND PROJECT GOALS, KINDLY READ THE COMMIT     #
#		MESSAGES AND REFER " salon.sh " FILE TO IDENTIFY THE MODIFICATION 	 #
#				DONE IN THIS SCRIPT            				 #
# 											 #
# ************************************************************************************** #


# Assigning Argument Variable

# Variables For Psql Program 

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

 # Psql Program
 
 PSQL="psql -X --username=$USR --dbname=$SA_DB --no-align --tuples-only -c"

 # START ---- DATABASE INTERFACE ---- SECTION #
 
 # Interface Title Function
 
 TITLE() {
	 # Argument For Title Function
	 if [[ $1 ]]
	 then
		 MESSAGE=$(echo -e $1)
	 fi
		 echo -e  "\n#---------------- SALON APPOINTMENT INTERFACE ----------------#\n"
		 echo -e "   MESSAGE : $MESSAGE\n"
 }

 # Interface Show Function
 
 SHOW() {

	 # Set Options For Show Function 

	 while getopts 'NPTD' OPTIONS 
	 do
		 case $OPTIONS in 
			 N) echo -e "NAME : $CUSTOMER_NAME\n" ;;
			 P) echo -e "PHONE : $CUSTOMER_PHONE\n" ;;
			 T) echo -e "TIME : $SERVICE_TIME\n" ;;
			 D) echo -e "AM/PM : $AM_PM\n" ;;
		 esac
	 done
 }
 
 # Interface Main Menu Function

 MAIN_MENU() {
	 # Argument for Main Menu Function
	 
	 if [[ $1 ]]
	 then
		 MESSAGE=$(echo -e $1)
	 fi 

	 # Variable To Collect Services From Database 
	 
	 SERVICES_LIST=$($PSQL "SELECT * FROM services" | sed "s/|/) /" | sed "s/^/                      /g")

	 # Main Menu Home Page
	 
	 TITLE
	 echo -e "$SERVICES_LIST\n"
	 read -p "           Your Selection : " SERVICE_ID_SELECTED

	 
	 # Checking Service_ID As A Valid Character
	 
	 while [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]$ ]] 
	 do
		 MAIN_MENU "ENTER A VALID SERVICE ID !!!" 
		 read -p "           Your Selection : " SERVICE_ID_SELECTED
	 done
	  
	# Search Database For Service Name  
	
	SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

	 # If Service Name Not Found
	 
	 while [[ -z $SERVICE_NAME ]]
	 do 
		 MAIN_MENU "!!! THERE IS NO SUCH SERVICE AVAILABLE !!! PLEASE SELECT A VALID SERVICE NUMBER"
		 read -p "           Your Selection : " SERVICE_ID_SELECTED 
		 SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
	 done

	 # Storing Phone Number
	 
	 TITLE " !!! PLEASE ENTER YOUR PHONE NUMBER !!! eg : ( XXX-XXX-XXXX )"
	 read -p " PHONE : " CUSTOMER_PHONE

	 # If Phone Number Is Invalid

	 while [[ ! $CUSTOMER_PHONE =~ ^[0-9]{3}-[0-9]{3}-[0-9]{4}$ ]]
	 do
		 TITLE "!!! PLEASE ENTER A VALID PHONE NUMBER !!! eg : ( XXX-XXX-XXXX )"
		 read -p " PHONE : " CUSTOMER_PHONE
	 done

	 # START ---- CUSTOMER DOES NOT EXIST IN DATABASE ---- SECTION #

	 # Checking Customer_Id In Database Using Phone Number
	 
	 CUSTOMER_ID=$($PSQL " SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE' ")
	 

	 if [[ -z $CUSTOMER_ID ]]
	 then
		 TITLE "WELCOME NEW CUSTOMER !!! PLEASE ENTER YOUR NAME !!! eg: ( MARK.P )"
		 SHOW -P
		 read -p "NAME : " CUSTOMER_NAME

	 # Editing Customer Name To Uppercase

	 CUSTOMER_NAME=$(echo $CUSTOMER_NAME | tr '[:lower:]' '[:upper:]')

	 # If Customer Name Is Invalid

	 while [[ ! $CUSTOMER_NAME =~ ^[a-zA-Z]+\.[a-zA-Z$] ]]
	 do 
		 TITLE " !!! PLEASE ENTER A VALID NAME !!! eg: ( MARK.P )"
		 SHOW -P 
		 read -p "NAME : " CUSTOMER_NAME

	 # Editing Customer Name To Uppercase
	 
	 CUSTOMER_NAME=$(echo $CUSTOMER_NAME | tr '[:lower:]' '[:upper:]')
 	 done

	 # Updating Customer Information To Database

	 $($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')" &> /dev/null)

	 STATUS=$?

	 if [[ $STATUS != 0 ]]
	 
	 then
		 MAIN_MENU "!!! DATABASE ERROR !!! : CONTACT SUPPORT"
	 else

	# Updating Customer_ID
	
	CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

	# Getting Service Time

		 TITLE "WELCOME $CUSTOMER_NAME !!! PLEASE ENTER YOUR APPOINTMENT TIME !!!"
		 SHOW -PN
		 read -p "TIME : " SERVICE_TIME
	 fi 

	 # If Service Time Is Invalid

	 while [[ ! $SERVICE_TIME =~ ^[0-9][0-9]:[0-9][0-9]$ ]]
	 do
		 TITLE "!!! PLEASE ENTER A VALID TIME FORMAT !!! eg : ( XX:XX )"
		 SHOW -PN
		 read -p "TIME : " SERVICE_TIME
	 done

	 # Getting Time Of Day
	 
	 TITLE "!!! PLEASE ENTER TIME OF DAY !!!"
	 SHOW -PNT
	 read -p "AM/PM : " AM_PM
	 
	 # Editing Time Of Day To Uppercase

	 AM_PM=$(echo $AM_PM | tr '[:lower:]' '[:upper:]')

	 # If Time Of Day Is Invalid

	 while [[ $AM_PM != "AM" && $AM_PM != "PM" ]] 
	 do
		 TITLE "!!! PLEASE ENTER A VAILD TIME OF DAY !!!"
		 SHOW -PNT
		 read -p "AM/PM :" AM_PM

	 # Editing Time Of Day To Uppercase

		 AM_PM=$(echo $AM_PM | tr '[:lower:]' '[:upper:]')
	 done
	 

	 # Updating Appointment Database

	 $($PSQL "INSERT INTO appointments(service_id, customer_id, time, am_pm) VALUES($SERVICE_ID_SELECTED, $CUSTOMER_ID, '$SERVICE_TIME', '$AM_PM')" &> /dev/null)

	 STATUS=$?

	 # If Error In Updating Appointment Database

	 if [[ $STATUS != 0 ]]
	 then
		 MAIN_MENU "!!! DATABASE ERROR !!! : CONTACT SUPPORT"
		 SHOW -PNTD
	 else
		 TITLE "I HAVE PUT DOWN FOR A $SERVICE_NAME at $SERVICE_TIME $AM_PM, $CUSTOMER_NAME"
		 SHOW -PNTD
	 fi 

	 # END ---- CUSTOMER DOES NOT EXIST IN DATABASE ---- SECTION #


	 # START ---- CUSTOMER ALREADY EXIST IN DATABASE ---- SECTION #

	 # Retreving Name From Database Using Phone Number
 	 
 	else

	 CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'") 

	 STATUS="$?"

	 # If Error In Retriving Customer Name From Database

	 if [[ $STATUS != 0 ]]
	 then
		 MAIN_MENU "!!! DATA RETRIVAL ERROR !!! : CONTACT SUPPORT"

	# Getting Service Time
	
	 else

		 TITLE "WELCOME $CUSTOMER_NAME !!! PLEASE ENTER YOUR APPOINTMENT TIME !!!"
		 SHOW -PN
		 read -p "TIME : " SERVICE_TIME

	 fi

	 # If Service Time Is Invalid

	 while [[ ! $SERVICE_TIME =~ ^[0-9][0-9]:[0-9][0-9]$ ]]
	 do
		 TITLE "!!! PLEASE ENTER A VALID TIME FORMAT !!! eg : ( XX:XX )"
		 SHOW -PN
		 read -p "TIME : " SERVICE_TIME
	 done

	 # Getting Time Of Day
	 
	 TITLE "!!! PLEASE ENTER TIME OF DAY !!!"
	 SHOW -PNT
	 read -p "AM/PM : " AM_PM
	 AM_PM=$(echo $AM_PM | tr '[:lower:]' '[:upper:]')

	 # If Time Of Day Is Invalid

	 while [[ $AM_PM != "AM" && $AM_PM != "PM" ]] 
	 do
		 TITLE "!!! PLEASE ENTER A VAILD TIME OF DAY !!!"
		 SHOW -PNT
		 read -p "AM/PM :" AM_PM
		 AM_PM=$(echo $AM_PM | tr '[:lower:]' '[:upper:]')
	 done

	 # Updating Appointment Database

	 $($PSQL "INSERT INTO appointments(service_id, customer_id, time, am_pm) VALUES($SERVICE_ID_SELECTED, $CUSTOMER_ID, '$SERVICE_TIME', '$AM_PM')" &> /dev/null)

	 STATUS=$?

	 # If Error In Updating Appointment Database

	 if [[ $STATUS != 0 ]]
	 then
		 MAIN_MENU "!!! DATABASE ERROR !!! : CONTACT SUPPORT"
		 SHOW -PNTD
	 else
		 TITLE "I HAVE PUT DOWN FOR A $SERVICE_NAME at $SERVICE_TIME $AM_PM, $CUSTOMER_NAME"
		 SHOW -PNTD
	 fi

	 # END ---- CUSTOMER ALREADY EXIST IN DATABASE ---- SECTION #

	 fi
 
 # END ---- DATABASE INTERFACE ---- SECTION #

}

# Executing Interface

MAIN_MENU "WELCOME TO MEN'S SALON, HOW CAN I HELP YOU !!!!"


