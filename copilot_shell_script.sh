#!/bin/bash

read -p "Enter assignment name: " assName

source ./create_environment.sh

sed -i "2s/.*/ASSIGNMENT=\"$assName\"/" $dir_name/config/config.env

./$dir_name/startup.sh
