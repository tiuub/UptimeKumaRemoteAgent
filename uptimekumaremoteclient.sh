#!/bin/bash

VERSION="0.0.1"
AUTHOR="tiuub"
GITHUB="https://github.com/tiuub/UptimeKumaRemoteAgent"

helpFunction()
{
   echo ""
   echo "Usage: $0 -url {url} -pushurl {url}"
   echo -e "\t-url Url of container to check"
   echo -e "\t-pushurl Url of uptime-kuma"
   exit 1 # Exit script after printing help
}

while getopts ":u:p:" opt
do
   case "$opt" in
      u ) url="$OPTARG" ;;
      p ) pushurl="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$url" ] || [ -z "$pushurl" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

echo "#### UptimeKumaRemoteAgent ####"
echo
echo "Author: $AUTHOR - Version: $VERSION"
echo "GitHub: $GITHUB"
echo
echo "URL: $url"
echo "PushUrl: $pushurl"
echo

echo "Checking URL"
CODE=$(curl -L -s -o /dev/null -w "%{http_code}" $url)
echo "Status code: $CODE"


if [[ $CODE == 200 ]]; then
  echo "Received 200:"
  echo " -> Sending OK to pushurl"
  curl $pushurl?msg=OK &> /dev/null
else
  echo "Received anything else than 200:"
  echo " -> Not seding OK to pushurl"
fi

echo
echo "#### END ####"