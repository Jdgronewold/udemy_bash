#!/bin/bash

# 3 types of I/0 standard input (keyboard or something like echo), standard output (displayed to the screen by default), and standard error

# > will redirect std output to a file
# ex. head -n1 /etc/passwd > "filename.txt"

# < will redirect stdin 
# ex. read LINE < "filename.txt" (in this case only the first line of the filename is redirected in)

# using >> the redirected stdout will append to a file, whereas > will overwrite the file if it exists

# file descpriptor is a number that represents an open file, every new process has FD 0 = STDIN, FD 1 = STDOUT, and FD 2 = STDERR

# implictly in the |, <, and > symbols are the FD types. So for example:
# read X < "some-file" is the same as
# read X 0< "some-file" where 0 represents STDIN

# and by the same token
# (echo "something" > uid) is the same as (echo "something" 1> uid)

# you can redirect STDERR with 2>
# you can redirect multiple outputs at onces with:
# head -n1 /some-file /some-non-existant-file 1> head.out 2> head.err 

# to send them to the same place 
# head -n1 /some-file /some-non-existant-file > head.both 2>&1
# the 2>&1 redirected stderr to stdout where the & denotes we are sending it to a file descriptor instead of a file

# the newer way is:
# head -n1 /some-file /some-non-existant-file &> head.both

# pipe will only pipe the stdout by default by doing something like 2>&1 or just |&

# if you want to do something like force echo to stderr you can do:
# echo 'error' 1>&2
# echo 'error' >&2

# null device - will throw away whatever is put into it
# the null device lives at /dev/null