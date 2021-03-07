#!/bin/bash

# CUT and AWK

# cut is used to, suprise suprise, cut files/inputs into smaller chunks
# for example, try cut -c 1-7 /etc/passwd <--- no spaces between 4-7 is important
# or something like cut -c -4 /etc/passwd
# or something like cut -c 1,3,5 /etc/passwd
# use cut -f to to cut fields, typically used with a delimiter -d but think of it like columns
# such as cut -d ':' -f 1,3 /etc/passwd

# cut will only handle single delimiter characters

# two very common regexp:
# ^ will match the start of a line so if you have a header of a csv that is 'first,last' you can match that by doing grep '^first'
# $ will match the end of the line 

# grep -v will inverse match, so it matches whatever does not fit the pattern

# AWK

# example first:

# awk -F 'DATA:' '{print $2}' file.csv
#     ^ field delim  ^ curly brackets denote an action for AWK


# cut -d ':' -f 1,3 /etc/passwd can also be done by:
# awk -F ':' '{print "COL1: " $1, "COL3: " $3}' /etc/passwd 

# notes: the , in the print statement default output field separator, which for awk is a space. The output filed seperator can be set by -v OFS='blah'
# awk also has a $NF variable to access the last field

# netstat command - gets port info
# -n to display ports instead of names
# -u to display udp
# -t for tcp 
# -l for listenting ports

# example:
# netstat -nutl | grep -Ev '^Active|^Proto' <-- the -E means extended regexp matching, -v is reverse matching
# netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' <--- gives us the port

# SORT and UNIQ

# sort command
# can sort by a delimiter and then a certain field like:
# by default sort will sort alphabetically so sort /etc/passwd or use -r to reverse
# common pattern to get # of appearances of something is to sort | uniq -c | sort -n

# du command shows disk usage (in kb)

# uniq command needs sorted data
# uniq -c to get count of each value


# testing for a file:

# if [[ ! -e filename.log ]]
# then
# fi

# SED 

# sed stands for stream editor
# a stream is the data that travels from one process/file to another like a pipe or std input being passed around

# most common use is a command line find and replace

# for example:

# sed 's/assistant/assistant to the/' filename.txt <--- here the s means substitute whatever comes between the forward brackets, and is replaced by what comes in the following forward brackets. You can use regexp in the forward brackets

# in this example sed will not alter the contents of the file, although it can if set properly

# sed 's/assistant/assistant to the/i' filename.txt <-- the i will make it case insensitive
# by default sed replaces the first occurence on every line, to make it replace all provide a 'g' at the end of the command


# sed can also remove and delete lines

# sed '/search-pattern/d'

# to execute multiple commands:
# sed '/^#/d' ; '/^$/d' ; 's/apache/httpd/' config <--- this will first remove all lines that start with a comment, then all lines that start with an empty space, then substitute httpd for apache from the config file

# sed has a lot more powerful patern matching - for example:
# sed '/Group/ s/apache/httpd/' config  <--- will only replace apache on lines that also have 'Group' in it
# sed '2 s/apache/httpd/' config  <--- will only replace apache on the second line





