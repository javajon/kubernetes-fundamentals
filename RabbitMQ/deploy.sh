#!/bin/sh

kubectl create namespace rabbit

kubectl create secret generic rabbitmq-config --namespace rabbit --from-literal=erlang-cookie=c-is-for-cookie-thats-good-enough-for-me

kubectl create --namespace rabbit -f rabbitmq.yaml

minikube service --namespace rabbit rabbitmq-management
