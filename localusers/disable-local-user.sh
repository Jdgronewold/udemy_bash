#!/bin/bash

# Disable and optionally archive local users

readonly ARCHIVE_DIR='/archive'

if [[ "${UID}" -ne 0 ]]
then
  echo "Please run as root" >&2 # redirect echo to standard error
  exit 1
fi

usage() {
  echo "Disable a users account. Pass in user names after the options. Options: " >&2
  echo "-d: delete account instead of disable account" >&2
  echo "-r: remove home directory" >&2
  echo "-a: archive home directory in /archives" >&2
  exit 1
}

SHOULD_DELETE='false'
SHOULD_REMOVE_HD=""
SHOULD_ARCHIVE='false'

while getopts dra OPTION
do
  case ${OPTION} in
    d) SHOULD_DELETE='true';;
    r) SHOULD_REMOVE_HD='-r' ;;
    a) SHOULD_ARCHIVE='true';;
    ?) usage
  esac
done

# remove options provided
shift $((${OPTIND} - 1))

if [[ $# -lt 1 ]]
then
  echo "Please provide at least one username." >&2
  echo usage
  exit 1
fi


# Instead of while loop use a for loop
for USERNAME in "${@}"
do
  echo "Processing ${USERNAME}"
  if [[ $(id -u ${USERNAME}) -lt 1000 ]]
  then
    echo "Attempting to delete user ${USERNAME} but that account can not be disabled or deleted." >&2
    continue
  fi

  if [[ $SHOULD_ARCHIVE -eq 'true' ]]
  then
    if [[ ! -d "${ARCHIVE_DIR}" ]] # run help test to see all the test conditions!
    then
      mkdir -p "${ARCHIVE_DIR}" # the -p will creates parent directories
      if [[ $? -ne 0 ]]
      then
        echo "Was not able to create archive directory"
        exit 1
      fi
      HOME_DIR="/home/${USERNAME}"
      ARCHIVE_FILE="${ARCHIVE_DIR}${HOME_DIR}.tgz"
      if [[ -d $HOME_DIR ]]
      then
        echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
        tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
        if [[ $? -ne 0 ]]
        then
          echo "Could not archive ${HOME_DIR}"
          exit 1
        fi
      else
        echo "Home directory ${HOME_DIR} does not exist" >&2
        exit 1
      fi
    fi
  fi

  if [[ ${SHOULD_DELETE} -eq 'true' ]]
  then
    userdel ${SHOULD_REMOVE_HD} "${USERNAME}"
    if [[ "${?}" -ne 0 ]]
    then
      echo "User ${USERNAME} was not able to be deleted" >&2
      exit 1
    fi
    echo "User ${USERNAME} was deleted"
    echo
  else
    chage -E 0 "${USERNAME}"
    if [[ "${?}" -ne 0 ]]
    then
      echo "User ${USERNAME} was not able to be disabled" >&2
      exit 1
    fi
    echo "User ${USERNAME} was disabled"
    echo
  fi
done

exit 0


# while [[ $# -gt 0 ]]
# do
#   USER="${1}"
#   shift
#   if [[ "$(id ${USER} -u)" -lt 1000 ]]
#   then
#     echo "Attempting to delete user ${USER} but that account can not be disabled or deleted." >&2
#     continue
#   fi

#   if [[ SHOULD_ARCHIVE -eq 'true' ]]
#   then
#     ls -l /archives &> /dev/null
#     if [[ "${?}" -ne 0 ]]
#     then
#       mkdir /archives
#     fi 

#     tar -cf "/home/${USER}" "/archives/${USER}"
#   fi

#   if [[ SHOULD_DELETE -eq 'true' ]]
#   then
#     if [[ SHOULD_REMOVE_HD -eq 'true' ]]
#     then
#       userdel -r "${USER}"
#     else
#       userdel "${USER}"
#     fi
#   else
#     chage -E 0 "${USER}"
#   fi

#   if [[ "${?}" -ne 0 ]]
#   then
#     echo "User ${USER} was not able to be deleted or disabled" >&2
#     continue
#   fi

#   echo "User ${USER} was deleted or disabled"
#   echo
# done


exit 0



