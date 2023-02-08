#!/bin/bash
# if no options are specified, defaults are used

key="../keys/aws-web260.pem"
hostname="excursionsxr.world"
service="simon"


while getopts k:h:s: flag
do
    case "${flag}" in
        k) key=${OPTARG};;
        h) hostname=${OPTARG};;
        s) service=${OPTARG};;
    esac
done

printf "\n----> deploying files for $service to $hostname with $key\n"

printf "\n----> clearing out previous distribution on the target.\n"
ssh -i "$key" ubuntu@$hostname << ENDSSH
rm -rf services/${service}/public
mkdri -p services/${service}/public
ENDSSH

printf "\n----> copying the distribution package to the target.\n"
scp -r -i "$key" * ubuntu@$hostname:services/$sevice/public
