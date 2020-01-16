#!/bin/bash

set -e

echo "devops.sh controls deployment for docker swarm."

if (( $# != 1 ))
then
    echo "Usage : devops.sh [start | stop | restart | deploy]" 1>&2
    exit 1
fi


COMMAND=$1


case "$COMMAND" in

start)
    echo "start"
    docker stack deploy -c docker-compose.yml --resolve-image=always spring-boot
    ;;

stop)
    echo "stop"
    docker stack rm spring-boot
    ;;

restart)
    echo "restart"
    docker stack rm spring-boot
    sleep 30
    docker stack deploy -c docker-compose.yml spring-boot
    ;;

deploy)
    echo "deploy"
    docker stack deploy -c docker-compose.yml --resolve-image=changed spring-boot   
    source blue-green-deploy.sh
    ;;

*)
    echo "Error: unknown command '$1' for 'devops.sh'"
    ;;

esac