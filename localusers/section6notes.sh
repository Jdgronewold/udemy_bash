#!/bin/bash

# Case statement

# case "${1}" in
#   **value of 1**)
  #     do something here
  #     ;;
  # **different value**|**third option**)
      # do something else
      # ;;
  # esac


# in the case statement, * matches anything, ? matches any single character, and [...] matches any range of characters

# Functions

# ex:
#  log() {
#    local MESSAGE="${@}"      <--- the keyword local scopes this variable to the function. Here the @ is scoped to the function
#    echo "you called the log function"
#  }

# and then you just call it by typing log <-- no parathensis needed
# or:
#  function log {
#    echo "you called the log function"
#  }

# side note -
# logger functionality - on general centos machines it will log to /var/log/messages, add a -t to tag it specificially
# 
# files in /var/tmp will survive a reboot, files in /tmp will not survive a reboot

# write a function to create a duplicate of a file before modifying it
# backup_file() {
#   local FILE = "${1}"
#   
#   if [[ -f "${FILE}" ]]
#   then
#     local BACKUP_FILE="/var/tmp/$(basename ${FILE}.$(date +F%-%N)"   <-- basename removes path to the file
#
#     # the return of cp will be the status the our function returns
#     cp -p "${FILE}" "${BACKUP_FILE}"       <-- -p flag preserves ownership, permissions, etc
#   else
#     echo "File does not exist"
#     return 1      <--- make sure to use return, not exit inside the function
#   fi
# }

# GETOPS
# allow the user to add in options like verbose or quiet like -l or --verbose
# getops allows you to combine options like -l -a into -la like normal scripts

# getopts returns 0 as long as there is another option to process, otherwise it returns 1

# ex: generate password where the user can specify a length and special character options
# 
# while getops vl:s OPTION          <-- the colon after the l means that it is mandatory to have an argument
# do
#   case ${OPTION} in
#     v) set the verbose here ;;
#     l) LENGTH="${OPTARG}" ;;          <--- when the variable is given an argument it is assigned to OPTARG
#     s) set the special character here ;;
#     ?) echo "Invalid option provided" >&2
#   esac
# done

# arithmatic expansion --> NUM=$(( 1 + 2 ))
# or use the let shell built in --> help let for more info

# getops does not change positional parameters -> to remove them you can use the variable ${OPTIND} so we can shift by {OPTIND} - 1 to shift off all the options that were passed in a positional parameters and only have the extra values left over


# DISABLING AND DELETING USERS

# userdel is used to delete users
# locate command can be used to find commands that may not appear when you do type -a "command"
# you can also use find, which is a real time search

# bin directories are typically where executables (or binary) live
# config files are usually in /etc
# the shortcut !! executes the most recent command

# su - to switch to root user (vagrant is the password on the centos vagrant box)
# id "username" to get info on a user in the system

# when deleting accounts, typically you will want to be careful about deleting system/admin accounts. Checking the uid helps -> lower numbers typically denote important accounts. Look in /etc/login.defs for how uids are defined on the system

# tar command is what you can use to archive files/directories with -c to create, -x to extract -f to pass in a file name, and -z to zip it and then the last argument is the file/directory to archive

# to disable/lock an account you can use the chage command
# -E to unexpire the account

# usermod to change user account settings






