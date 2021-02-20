#!/bin/bash

# password bits

# whoami
# $(id -un) <- how you assign a command to a variable, called command substitution 
# $(date +%s)
# RANDOM is a shell variable that is a new random number every time it is called
# ${?} is the exit status of the last command ran

# sha1sum || sha256sum to get a checksum that can be used to published checksums for files to see whether they have been corrected

# ls -l /usr/bin/*sum for all checksums in the bin

# head -n 1 /etc/passwd - print first line of password where n is # of lines

# get date in nanoseconds, pipe to sha256 then take the first 10 digits
# date +%N | sha256sum | head -c10

# fold will wrap text into different lines

# shuf will randomize lines

# $(echo '!@#$%^&*()_+{}' | fold -w1 | shuf | head -c1) <- will give one random character from the echo statement 


# POSITIONAL PARAMETERS

# ${0} name of the command itself
# ${1} name of the first argument passed to the command, ${2} is the second and so on
# PATH 

# cool note! bash uses hashes to keep track of where commands exist sooo if you have two copies of a command, one in /usr/bin and one in /usr/local/bin and the latter comes first in the path it will be excecuted first and then bash will add that location to the hash. Subsequent calls to the command will not trigger a search and instead bash will just call the command at the hashed location, so if that command got deleted somehow it will error/no such file and directory. To make bash rehash things type hash -r

# basename strips out directory of file
# dirname is the opposite of that

# Special Parameters and #Positional Parameters in man bash page

# ${#} is the number of arguments passed in to the command

# test conditional -lt means less than, -ne is not equals -eq equals. "help test" to see the rest

# for X in A B C
# do
#   do whatever with ${X}
# done

# ${@} represents a list of the arguments passed in to the command "${@}" is like "${1}" "${2}" ... etc

# while [[ test condition ]]
# do
#   something here
# done

# shift command removes arguments from the argument list

# while [[ "${#}" -gt 0 ]]
# do
#   echo "The number of parameters is ${#}"
#   shift
# done

