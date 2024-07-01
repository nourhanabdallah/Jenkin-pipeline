#!/bin/bash

# Get the list of all users
all_users=$(getent passwd | cut -d: -f1)

# Get the list of users in the deployG group
group_members=$(getent group deployG | cut -d: -f4 | tr ',' ' ')

# Convert group members to an array for easier comparison
IFS=' ' read -r -a group_array <<< "$group_members"

# Function to check if a user is in the deployG group
is_user_in_group() {
    local user=$1
    for member in "${group_array[@]}"; do
        if [ "$user" == "$member" ]; then
            return 0
        fi
    done
    return 1
}

# Loop through all users and print those not in the deployG group
echo "Users not in the deployG group:"
for user in $all_users; do
    if ! is_user_in_group "$user"; then
        echo "$user"
    fi
done

