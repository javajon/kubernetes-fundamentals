#!/bin/sh
set -v

kubectl create namespace shop

kubectl --namespace shop create -f .  

minikube --namespace shop service catalog
         
