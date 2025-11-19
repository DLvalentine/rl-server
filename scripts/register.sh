#!/bin/bash
clear

# Gather requested username and email, then write out to users file for admin use later.
read -p "Enter your desired username: " username
read -p "Enter your email: " email
echo "$username, $email" >> /rl-server/users
echo ""
echo "Thank you for registering! You will be contacted shortly with your username and password."
echo "(if it has been more than a few days, just email me: davidlewisvalentine@gmail.com)"
