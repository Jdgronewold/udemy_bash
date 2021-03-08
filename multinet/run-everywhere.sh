#!/bin/bash

# Script to execute command passed in on all of the servers listed in the ./server file
SERVER_FILE='./servers'
VERBOSE='false'
DRY_RUN='false'
SSH_OPTIONS="-o ConnectTimeout=2"

if [[ "${UID}" -eq 0 ]]
then
  echo "Please do not run as root. Instead run script with the -s option" >&2 # redirect echo to standard error
  exit 1
fi

usage() {
  echo "Runs a command on all servers provided in the servers file. Pass in command after the options. Options: " >&2
  echo "-f: optional file to use instead of ./servers" >&2
  echo "-n: perform a dry run of the command" >&2
  echo "-s: run as sudo" >&2
  echo "-v: run in verbose mode" >&2
  exit 1
}

log() {
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${@}"
  fi
}


while getopts f:nsv OPTION
do
  case ${OPTION} in
    f) SERVER_FILE="${OPTARG}";;
    n) DRY_RUN='true' ;;
    s) SUDO='sudo';;
    v) VERBOSE='true' ;;
    ?) usage
  esac
done

if [[ ! -e $SERVER_FILE ]]
then
  echo "Provided server file ${SERVER_FILE} does not exist" >&2
  exit 1
fi


# remove options provided
shift $((${OPTIND} - 1))

COMMAND="${@}"

for SERVER in $(cat ${SERVER_FILE})
do
  if [[ "${DRY_RUN}" = 'true' ]]
  then
    echo "DRY RUN: Running ${COMMAND} on ${SERVER}"
  else
    log "Running ${COMMAND} on ${SERVER}"
    ssh "${SSH_OPTIONS}" $SERVER "${SUDO} ${COMMAND}"
  fi

done

exit 0




