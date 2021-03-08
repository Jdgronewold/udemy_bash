#!/bin/bash

these notes are all about creating a small network and running it from the admin01 vm, which controls server01 and server02

tee command - appends to a file or overwrites

echo '10.9.9.11 server01' | sudo tee -a /etc/hosts <-- adding the server name to our host file so we can do something link ping -c 3 server01

to ssh into the other two from admin01 we need to create ssh key pairs so we use the ssh-keygen command and accept defaults

to put the public key on the remote system:

ssh-copy-id server01
(password for vagrant is vagrant)

to run a command on the other vm you can do ssh server01 cmd-you-want-to-run
or log in with ssh server01 

added the servers to servers file

for SERVER in $(cat servers)
do
  ssh $SERVER 'hostname' <--- if you need to have multiple command put it all in quotations
  ssh $SERVER uptime
done

ps -ef | head -3 will give first three processes

ssh will throw a 255 error if it fails
ssh exits with the last command it ran unless itself errors out


to test to see if servers are available:

for SERVER in $(cat servers)
do
  echo "PINGING: ${SERVER}"
  ping -c 1 $SERVER &> /dev/null
  if [[ $? -ne 0 ]]
  then
    echo "${SERVER} is down"
  else
    echo "${SERVER} is up"
  fi
done

to stop a server 




