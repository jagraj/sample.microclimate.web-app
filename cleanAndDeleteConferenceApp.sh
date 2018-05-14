#!/bin/bash

# This script uninstalls helm charts, clean maven artifacts and also removes docker images.

docker rm -v $(docker ps -a -q -f "status=exited")
docker rmi $(docker images -f "dangling=true" -q)

echo "Delete web-application"
cd "$(dirname "$0")"
helm delete conferencewebapp --purge
sleep 30
mvn clean
docker rmi -f conferencewebapp

sleep 10

echo "Delete microservice-session"
cd ../sample.microclimate.session
helm delete conferencesession --purge
sleep 30
mvn clean
docker rmi -f conferencesession

sleep 10

echo "Delete microservice-speaker"
cd ../sample.microclimate.speaker
helm delete conferencespeaker --purge
sleep 30
mvn clean
docker rmi -f conferencespeaker

sleep 10

echo "Delete microservice-schedule"
cd ../sample.microclimate.schedule
helm delete conferenceschedule --purge
sleep 30
mvn clean
docker rmi -f conferenceschedule

sleep 10

echo "Delete microservice-conferencevote"
cd ../sample.microclimate.vote
helm delete conferencevote --purge
sleep 30
mvn clean
docker rmi -f conferencevote

docker rm -v $(docker ps -a -q -f "status=exited")
docker rmi $(docker images -f "dangling=true" -q)
