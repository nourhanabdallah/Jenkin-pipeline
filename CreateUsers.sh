#!/bin/bash

# Ensure running  as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo."
    exit 1
fi

# creation_function
create_user() {
    local username=$1
    local password=$2

    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists."
    else
        # Create the user
        useradd "$username"
        
        # Set the user's password
        echo "$username:$password" | chpasswd
        
        echo "User $username created with password $password."
    fi
}
# Create users and set their passwords
create_user "Devo" "123Devo"
create_user "Testo" "123testo"
create_user "Prodo" "123prodo"


