#!/bin/bash


# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo."
    exit 1
fi

# Create group deployG if it does not exist
if ! getent group deployG &>/dev/null; then
    groupadd deployG
    echo "Group deployG created."
else
    echo "Group deployG already exists."
fi


#users
users() {



        local username=$1

 usermod -aG deployG "$username"
    echo "User $username added to group deployG."
}

users "Devo"
users "Testo"
users "Prodo"


