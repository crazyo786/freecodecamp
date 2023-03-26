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
# 										         #
#  				       	  NOTE :				         #
# 											 #
#    	   THIS SCRIPT IS BUILD FOR THE FREECODECAMP CURRICULUM "RELATIONAL DATABASE"	 #
#		UNDER THE PROJECT "BUILD A SALON APPOINTMENT SCHEDULER" BY USER		 #
#					@crazyo786 	 				 #
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
 
 PSQL="psql -X --username=$USR --dbname=$SA_DB --tuples-only -c"

 # START ---- DATABASE INTERFACE ---- SECTION #
 
 # Interface Main Menu Function

 MAIN_MENU() {
	 # Argument for Main Menu Function
	 
	 if [[ $1 ]]
	 then
		 MESSAGE=$(echo -e $1)
	 fi 

	 echo -e "\n    Men's Salon Appointment Scheduler   \n"

	 echo -e "\nWelcome to Men's Salon, How Can I Help You?\n"

	 # Variable To Collect Services From Database 
	 
	 SERVICES_LIST=$($PSQL "SELECT service_id, name FROM services")   

	 # Main Menu Home Page
	 
	  echo "$SERVICES_LIST" | while read SERVICE_ID BAR SERVICE_NAME
  	  do 
    	  echo -e "$SERVICE_ID) $SERVICE_NAME"
  	  done
	  echo -e "\nYour Selection :"
	  read SERVICE_ID_SELECTED

	 
	 # Checking Service_ID As A Valid Character
	 
	  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
	  then
      	  MAIN_MENU "Sorry Such Service Is Not Available. Please Enter A Valid Service Number :"
    	  else
          SERVICE_NAME_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
      	
	  # Checking Service_Name

	  # If Service_Name is Invalid
	
      	  if [[ -z $SERVICE_NAME_SELECTED ]]
          then
          MAIN_MENU "Sorry, That Is Not A Valid Service. Please Select Again."
          else
          echo -e "\nYour Preffered Service : $SERVICE_NAME_SELECTED"
          echo -e "\nPlease Enter Your Phone Number :"
          read CUSTOMER_PHONE

	  # Get Customer_Name
	
	  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

 	  # If Not Found
	
          if [[ -z $CUSTOMER_NAME ]]
          then 
          echo -e "\nWelcome New Customer. Please Enter Your Name "
          read CUSTOMER_NAME
         
	  # Update Customer to Database
              
	  INSERT_NEW_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")

          fi

	  # Get Service Time
          echo -e "\nPlease Enter Your Appointment Time $SERVICE_NAME_SELECTED Service, $CUSTOMER_NAME :"
          read SERVICE_TIME

          # Get Customer_ID
          CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
          
          # Update Appointment Database
          INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(service_id, customer_id, time) VALUES ($SERVICE_ID_SELECTED,$CUSTOMER_ID,'$SERVICE_TIME')")

          echo -e "\nI have put you down for a $SERVICE_NAME_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
          

      fi 
      
  fi


}
# END ---- DATABASE INTERFACE ---- SECTION #



MAIN_MENU "WELCOME TO MEN'S SALON, HOW CAN I HELP YOU !!!!"


