#!/bin/bash


docker rm -v $(docker ps -a -q -f "status=exited")
docker rmi $(docker images -f "dangling=true" -q)

echo "Delete and Install conferencewebapp"
cd "$(dirname "$0")"
helm delete conferencewebapp --purge
sleep 30
mvn clean package
docker rmi -f conferencewebapp
docker build -t conferencewebapp .
helm install --name=conferencewebapp chart/conferencewebapp

sleep 10

echo "Delete and Install conferencesession"
cd ../sample.microclimate.session
helm delete conferencesession --purge
sleep 30
mvn clean package
docker rmi -f conferencesession
docker build -t conferencesession .
helm install --name=conferencesession chart/conferencesession

sleep 10

echo "Delete and Install conferencespeaker"
cd ../sample.microclimate.speaker
helm delete conferencespeaker --purge
sleep 30
mvn clean package
docker rmi -f conferencespeaker
docker build -t conferencespeaker .
helm install --name=speaker chart/conferencespeaker

sleep 10

echo "Delete and Install conferenceschedule"
cd ../sample.microclimate.schedule
helm delete conferenceschedule --purge
sleep 30
mvn clean package
docker rmi -f conferenceschedule
docker build -t conferenceschedule .
helm install --name=conferenceschedule chart/conferenceschedule

sleep 10

echo "Delete and Install conferencevote"
cd ../sample.microclimate.vote
helm delete conferencevote --purge
sleep 30
mvn clean package
docker rmi -f conferencevote
docker build -t conferencevote .
helm install --name=vote chart/conferencevote

docker rm -v $(docker ps -a -q -f "status=exited")
docker rmi $(docker images -f "dangling=true" -q)
