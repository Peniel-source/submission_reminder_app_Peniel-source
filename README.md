# Submission Reminder Application

Tis is a Linux-based shell application that helps track and remind students about upcoming assignment deadlines. This application provides an automated way to check submission statuses and send reminders to students who haven't submitted their assignments.

# Overview

This project:
- Manages student submission records for a number of assignments
- Provides an environment with specific directories
- Automatically sends reminders to students with pending assignments to submit
- Monitors assignment deadlines with days remaining

## Project Structure

The following directory structure is created when you run the setup script:

```
submission_reminder_{yourName}/
├── app/
│   └── reminder.sh          
├── assets/
│   └── submissions.txt      
├── config/
│   └── config.env          
├── modules/
│   └── functions.sh        
└── startup.sh              
```

### Main Scripts
- `create_environment.sh` - creates the complete application environment
- `copilot_shell_script.sh` - updates assignments in config.env and re-runs the startup script
- `README.md` - Project documentation

### Application's Files
- `reminder.sh` - Displays assignment info and checks submissions
- `functions.sh` - Contains `check_submissions()` function 
- `config.env` - Responsible for `ASSIGNMENT` name and `DAYS_REMAINING` variables
- `submissions.txt` - Contains student assignment records
- `startup.sh` - Executes `reminder.sh` file

## Installation & Setup

### Step 1: Clone the Repository
```bash
git clone https://github.com/Peniel-source/submission_reminder_app_Peniel-source.git
cd submission_reminder_app_Peniel-sourc
```

### Step 2: Run Environment Setup
```bash
chmod +x create_environment.sh
./create_environment.sh
```

**What happens:**
- Prompts you to enter your name
- `submission_reminder_{yourName}` directory is created
- and all these subdirectories are created within it (`app`, `modules`, `assets`, `config`)
- executable permissions are given to all `.sh` files
- Messages are echoed to show the progress 

### Step 3: Test the Application
```bash
cd submission_reminder_{yourName}
./startup.sh
```

Expected output:
```
Assignment: Shell Navigation
Days remaining to submit: 2 days
--------------------------------------------
Checking submissions in ./assets/submissions.txt
Reminder: Chinemerem has not submitted the Shell Navigation assignment!
Reminder: Divine has not submitted the Shell Navigation assignment!
```

## What can this whole application be used for?

### Basic Operation

1. You can create the whole environment by running `create_environment.sh` and enter your name
2. You can also check the current assignment you have by running the `./startup.sh` script in the new directory created in your name
3. Finally, when you run the `copilot_shell_script.sh` you can switch assignments and re-check

### Managing Different Assignments

To check submissions for a different assignment:
```bash
./copilot_shell_script.sh
```

**What happens when you run copilo_shell_script?**
1. Enter new assignment name when you're promted to
2. The value assigned to the `ASSIGNMENT` variable in all `submission_reminder_*/config/config.env` files is replaced with your input
3. The `startup.sh` is automatically re-run
4. And the updated results are displayed

### Student Records Addition
# these student records were added the the submission.txt file
- **Shell Scripting**: Kwame (not submitted)
- **Python Programming**: Fred (submitted)
- **Databases**: Anita (not submitted)
- **Web Infrastructure**: Matthew (submitted)
- **Networking**: Emma (not submitted)
- **Defensive Security**: Peniel (submitted)


### Key features of the scripts

**The loop below ensures that a name is inputted to create the directory**
```bash
while [[ -z "$user_name" ]]; do
    echo "You have to enter a name!"
    read -p "Please enter your name: " user_name
done
```

**Updating permissions in bulk**
```bash
find . -type f -name "*.sh" -exec chmod u+x {} \;
```

**Processing different directories**
```bash
for i in submission_reminder_*/config; do
    if [ -f "$i/config.env" ]; then
        sed -i "2s/.*/ASSIGNMENT=\"$assName\"/" "$i/config.env"
    fi
done
```

### Error Handling
- Directory existence checks before creation
- Spacing echo messages sleep delays for better display
- Ensuring there are no empty names for directory creation


### Repository Structure
- **`main` branch**: Has the main scripts for submission (`create_environment.sh`, `copilot_shell_script`, `README.md`)
- **`feature/setup` branch**: where the roughwork is done
