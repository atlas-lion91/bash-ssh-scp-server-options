#!/bin/bash

## Function to display the menu and get user selection
show_menu() {
    echo "Select an option:"
    echo "1. SSH into a server"
    echo "2. SCP file"
    echo "3. Exit"
}

## Function to SSH into a server
ssh_into_server() {
    read "Enter username: " username
    read "Enter IP address: " ip_address
    ssh "$username@$ip_address"
}

## Function to perform SCP operation
perform_scp() {
    read "Enter username: " username
    read "Enter IP address: " ip_address
    read "Enter source file location: " source_location
    read "Enter destination file location (Press Enter for home directory): " destination_location

    if [ -z "$destination_location" ]; then
        destination_location="~"
    fi

    read "Enter destination file name (Press Enter to use the same name): " destination_filename

    if [ -z "$destination_filename" ]; then
        scp "$source_location" "$username@$ip_address:$destination_location"
    else
        scp "$source_location" "$username@$ip_address:$destination_location/$destination_filename"
    fi
}

## Main script

while true; do
    show_menu
    read -p "Enter your choice: " choice

    case $choice in
    1)
        ssh_into_server
        ;;
    2)
        perform_scp
        ;;
    3)
        echo "Exiting script."
        exit 0
        ;;
    *)
        echo "Please select a valid option."
        ;;
    esac
done
