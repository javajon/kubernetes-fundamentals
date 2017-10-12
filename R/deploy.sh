#!/bin/sh
set -v

kubectl create -f .

minikube service r-shiny
