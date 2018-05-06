#!/bin/bash

# This application has Fabric and ELK sample dependency.
# Make sure those are deployed prior to executing this script.

docker rm -v $(docker ps -a -q -f "status=exited")
docker rmi $(docker images -f "dangling=true" -q)

echo "Delete and Install web-application"
cd "$(dirname "$0")"
helm delete web-app --purge
sleep 30
mvn clean package
docker rmi -f web-application
docker build -t web-application .
helm install --name=web-app chart/web-application

sleep 10

echo "Delete and Install microservice-session"
cd ../*session
helm delete session --purge
sleep 30
mvn clean package
docker rmi -f microservice-session
docker build -t microservice-session .
helm install --name=session chart/microservice-session

sleep 10

echo "Delete and Install microservice-speaker"
cd ../*speaker
helm delete speaker --purge
sleep 30
mvn clean package
docker rmi -f microservice-speaker
docker build -t microservice-speaker .
helm install --name=speaker chart/microservice-speaker

sleep 10

echo "Delete and Install microservice-schedule"
cd ../*schedule
helm delete schedule --purge
sleep 30
mvn clean package
docker rmi -f microservice-schedule
docker build -t microservice-schedule .
helm install --name=schedule chart/microservice-schedule

sleep 10

echo "Delete and Install microservice-vote"
cd ../*vote
helm delete vote --purge
sleep 30
mvn clean package
docker rmi -f microservice-vote
docker build -t microservice-vote .
helm install --name=vote chart/microservice-vote

docker rm -v $(docker ps -a -q -f "status=exited")
docker rmi $(docker images -f "dangling=true" -q)
