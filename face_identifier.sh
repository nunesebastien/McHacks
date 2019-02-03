#!/bin/bash
#face_recognition --tolerance 0.45 scanFor registered | cut -d'/' -f2 | grep -v unknown_person | cut -f1 -d'.'

# SCRIPT DESCRIPTION
# 1. this script creates a temporary directory and COPIES the template(iamge) into that directory 
# image is presumably in the same directory as the script and named "template.jpg" through HTML. 
# 2. Then, calls on face_recognition for identity.
# 3. Then, with the (numerical) idenitity, the python program "mutate.py" is evoked for sending money request
# --A request via email should be sent out at this point via Interact API--
# 4. Finally, the script removes the temporary directory, AND the template photo, AND the request file (that stored the request in dollar amount)


############ REQUIREMENTS ############
# template file MUST be named "template.jpg"
# database directory MUST be named "registered"
# request file MUST be named "request.txt"

###!!! template.jpg and request.txt remove statements are in comments for testing purposes

# if there is no "scanFor directory", create one
if [[ -d scanFor ]]
then
rm -r scanFor
mkdir scanFor
else
mkdir scanFor
fi

# copy template into scanFor directory
cp uploads/template.jpg scanFor

# get numericalID
PERSON_ID="$(face_recognition --tolerance 0.45 scanFor RegisteredFaces | grep -v 'unknown_person' | cut -d"/" -f2 | grep -v 'face' | cut -f1 -d".")"
# get request in dollar amount
REQUEST_DOLLARAMT=$(cat request.txt)

# Interact money request via python & Interact API
python mutate.py "${PERSON_ID}" "${REQUEST_DOLLARAMT}"

# DELETES, remove traces
# remove scanFor temporary folder
rm -r scanFor
# remove template file and request file (that stored the money request)
#rm template.jpg
#rm request.txt
rm -r uploads
mkdir uploads

rm request.txt

echo "ran" >> file.txt



###### CODE TEST ######
# umericalID
#echo "${PERSON_ID}"
# request in dollars
#echo "${REQUEST_DOLLARAMT}"