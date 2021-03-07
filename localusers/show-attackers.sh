#!/bin/bash

# note - needs a log file from the course that I didn't download

LOG_FILE="${1}"

if [[ ! -e LOG_FILE ]]
then
  echo "Cannot open file: ${LOG_FILE}" >&2
  exit 1
fi 

grep Failed LOG_FILE | awk '{print $(NF -3)}' | sort | uniq -c | sort -nr | while read COUNT IP
do
  if [[ "${COUNT}" -gt 10 ]]
  then
    LOCATION=$(geoiplookup ${IP})
    echo "${COUNT} ${IP} ${LOCATION}"
  fi
done

exit 0
