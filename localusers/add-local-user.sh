#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
  echo "Not running as root"
  exit 1
fi

read -p 'Enter username: ' USER_NAME

read -p 'Enter name: ' PERSON_NAME

read -p 'Enter password: ' PASSWORD

# Create user
useradd -c "${PERSON_NAME}" -m "${USER_NAME}"

if [[ "${?}" -ne 0 ]]
then
  echo "User creation failed"
  exit 1
fi


echo ${PASSWORD} | passwd --stdin ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
  echo "password creation failed"
  exit 1
fi

echo "Password creation success"
# Force the user to create a new password on login
passwd -e ${USER_NAME}

echo

echo "username: ${USER_NAME}"
echo "name: ${PERSON_NAME}"
echo "password: ${PASSWORD}"
echo "hostname: ${HOSTNAME}"

exit 0