#!/bin/bash

#Prompt user to enter their name
read -p "Enter your name: " user_name

#Creating parent directory with user input
dir_name=submission_reminder_$user_name

#Creating files with respective content and moving them into the right sub-directories. These processes are stored in functions.
 
fileREMINDER() {
cat <<'EOF' >> $dir_name/app/reminder.sh
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
echo "Successfully created and updated reminder.sh"
}

fileFUNCTIONS() {
cat <<'EOF' >> $dir_name/modules/functions.sh
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
sleep 1
echo ""
echo "Successfully created and updated functions.sh"
}

#The submissions.txt is updated with 6 more student records in this step

fileSUBMISSIONS() {
cat <<EOF >> $dir_name/assets/submissions.txt
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Kwame, Shell Scripting, not submitted"
Fred, Python Programming, submitted
Anita, Databases, not submitted
Matthew, Web Infrastructure, submitted
Emma, Networking, not submitted
Peniel, Defensive Security, submitted
EOF
sleep 1
echo ""
echo "Successfully created and updated submissions.txt"
}

fileCONFIG() {
cat <<'EOF' >> $dir_name/config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
sleep 1
echo ""
echo "Successfully created and updated config.env"
}

#This creates the directories and activates the various functions. 
if [ ! -d "$dir_name" ]; then
	mkdir $dir_name
	sleep 1
	echo ""
	echo "Parent directory created. Creating sub-directories ..."
	mkdir $dir_name/{app,modules,assets,config}
	sleep 1
	echo "Done"
	echo ""
	fileREMINDER
	fileFUNCTIONS
	fileSUBMISSIONS
	fileCONFIG
else
	sleep 1
	echo ""
	echo "Directory exists already. Try creating with a new name"
fi

#Creating the startup.sh script and adding its script
cat > "${dir_name}/startup.sh" << 'EOF'
#!/bin/bash
./app/reminder.sh
EOF

echo ""
echo "Startup script created"
#Modifying permissions for all files with .sh extension
find . -type f -name "*.sh" -exec chmod u+x {} \;  

echo ""
echo "Environment fully created."
