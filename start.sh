#!/bin/sh

# This project was tested using:
#   Minikube v0.25.2  (Versions 0.26.0 and 0.26.1 are not stable for this demonstration as Jenkins agent spawning does not occur)
#   Kubernetes/KubeCtl v1.9.4
#   Helm v2.8.2 (Helm 2.9 is unstable for this demo)

# Start minikube and ensure security for our demonstration container registry is off
# You may want to adjust the cpu and memory resources to work with your target machine
# minikube start --kubernetes-version v1.9.4 --cpus 4 --memory 8000 --disk-size 80g --insecure-registry '192.168.99.0/24' -p minikube-jenkins

# To allow docker to build image
"/c/Program Files/Oracle/VirtualBox/VBoxManage" modifyvm "battlestar" --natdnshostresolver1 on

minikube start \
--kubernetes-version v1.10.0 \
--cpus 4 \
--memory 8000 \
--disk-size 80g \
--bootstrapper localkube \
--profile fundamentals \
--insecure-registry '192.168.99.0/24' 

minikube profile fundamentals

helm init && helm repo update

minikube status
minikube addons enable registry
minikube addons enable heapster
minikube addons enable ingress
echo "$(minikube version) is now ready"
echo "Be sure to now run this command: '. ./env.sh'"

# May be a few moments before service is ready to respond to a patch request
# Expose the Registry externally as a NodePort (use 'minikube service list' to find the URL of services)
for i in {1..5}; do \
kubectl patch service registry --namespace=kube-system --type='json' -p='[{"op": "replace",  "path": "/spec/type", "value":"NodePort"}]' \
&& break || echo 'Retrying NodePort adjustment...' && sleep 10; done

# Troubleshooting:
# If Minikube does not start correctly, try wiping it clean with `minikube delete`,
# then run this script again. If this does not help sometimes a deeper cleaning
# such as removing `~/.minikube`, `~/.kube` or `~/.virtualbox` may help.
