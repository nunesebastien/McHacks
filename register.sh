#!/bin/bash

# SCRIPT DESCRIPTION
# 1. This script creates a directory called "registered "for registration entries if there isnt one already.
# 2. Then, it generates a unique numerical ID using date and time
# 3. Then, it assigns the unique numerical ID to the faceID and stores it into the registration "database"
# 4. faceID is removed
# 5. Inforamtion (name and email) is then taken from info.txt
# 6. record.csv is then updated with the corresponding numerical ID, name, and email

# if there is no "registered  directory", create one
if [[ ! -d registered ]]
then
mkdir registered
fi

# copy faceID into registered directory and give it a unique numerical ID
UNIQUE_ID="$(date +%Y%m%d%H%M%S)"
cp faceID.jpg ./registered/"${UNIQUE_ID}".jpg

# remove temporary face photo
#rm faceID.jpg

# get personal info (name and email) and echo into a CSV
ALL_INFO=$(<info.txt)
NAME=$(echo ${ALL_INFO} | cut -f1 -d ',')
EMAIL=$(echo ${ALL_INFO} | cut -d ',' -f2)

# append personal info into record
echo "${UNIQUE_ID}","${NAME}","${EMAIL}" >> record.csv



# stdout name, email, numericalID
#echo "${NAME}"
#echo "${EMAIL}"
#echo "${UNIQUE_ID}"
