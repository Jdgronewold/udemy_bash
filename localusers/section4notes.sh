# whoami
# $(id -un) <- how you assign a command to a variable
# $(date +%s)
# RANDOM is a shell variable that is a new random number every time it is called

# sha1sum || sha256sum to get a checksum that can be used to published checksums for files to see whether they have been corrected

# ls -l /usr/bin/*sum for all checksums in the bin

# head -n 1 /etc/passwd - print first line of password where n is # of lines

# get date in nanoseconds, pipe to sha256 then take the first 10 digits
# date +%N | sha256sum | head -c10

# fold will wrap text into different lines

# shuf will randomize lines

# $(echo '!@#$%^&*()_+{}' | fold -w1 | shuf | head -c1) <- will give one random character from the echo statement 
