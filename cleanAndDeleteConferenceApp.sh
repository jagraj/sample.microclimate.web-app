#!/bin/bash

# This script uninstalls helm charts, clean maven artifacts and also removes docker images.

docker rm -v $(docker ps -a -q -f "status=exited")
docker rmi $(docker images -f "dangling=true" -q)

echo "Delete web-application"
cd "$(dirname "$0")"
helm delete web-app --purge
sleep 30
mvn clean
docker rmi -f web-application

sleep 10

echo "Delete microservice-session"
cd ../*session
helm delete session --purge
sleep 30
mvn clean
docker rmi -f microservice-session

sleep 10

echo "Delete microservice-speaker"
cd ../*speaker
helm delete speaker --purge
sleep 30
mvn clean
docker rmi -f microservice-speaker

sleep 10

echo "Delete microservice-schedule"
cd ../*schedule
helm delete schedule --purge
sleep 30
mvn clean
docker rmi -f microservice-schedule

sleep 10

echo "Delete microservice-vote"
cd ../*vote
helm delete vote --purge
sleep 30
mvn clean
docker rmi -f microservice-vote

docker rm -v $(docker ps -a -q -f "status=exited")
docker rmi $(docker images -f "dangling=true" -q)
