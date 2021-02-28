#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
  echo "Not running as root" >&2 # redirect echo to standard error
  exit 1
fi

if [[ "${#}" -eq 0 ]]
then
  echo "Please provide an account name from the command line" >&2
  exit 1
fi

USER_NAME="${1}"
shift
COMMENTS="${@}"

# Create user
useradd -c "${COMMENTS}" -m "${USER_NAME}" &> /dev/null

if [[ "${?}" -ne 0 ]]
then
  echo "User creation failed" >&2
  exit 1
fi
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_+{}' | fold -w1 | shuf | head -c1)
PASSWORD=$(date +%N | sha256sum | head -c10 )

echo "${PASSWORD}${SPECIAL_CHARACTER}" | passwd --stdin ${USER_NAME} &> /dev/null

if [[ "${?}" -ne 0 ]]
then
  echo "password creation failed" >&2
  exit 1
fi

echo "Password creation success"
# Force the user to create a new password on login
passwd -e ${USER_NAME} &> /dev/null

echo

echo "Username: ${USER_NAME}"
echo "Comments: ${COMMENTS}"
echo "Password: ${PASSWORD}${SPECIAL_CHARACTER}"
echo "hostname: ${HOSTNAME}"

exit 0