#!/bin/bash
read -p "Enter assignment name: " assName

#In all directories that have the constant name submission_reminder_, repklace the value of ASSIGNMENT in the config file with the user's input.
for i in submission_reminder_*/config; do
    if [ -f "$i/config.env" ]; then
        sed -i "2s/.*/ASSIGNMENT=\"$assName\"/" "$i/config.env"
        echo "ASSIGNMENT in $i/config.env has been updated to $assName"
    fi
done

# In all directories that have the constant name submission_reminder_, re-run the startup script.
for j in submission_reminder_*/; do
    if [ -f "$j/startup.sh" ]; then
        cd "$j"
        ./startup.sh
        cd ..
    fi
done
