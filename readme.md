# Discovering Clusters With Minikube #

Example containers one can run on a Kubernetes cluster, such as Minikube.

## Demonstrating Kubernetes ##

### Kubernetes setup ##

1. Clone this Git project
1. Install [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube/) (or any other Kubernetes cluster)
1. Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) command line tool for Kubernetes
1. Start Minikube: `minikube start --kubernetes-version v1.9.4 --cpus 4 --memory 8000 --disk-size 80g -p minikube-hello`
1. Use profile specificed above: `minikube profile minikube-hello`
1. Verify `minikube status` and `kubectl version` run correctly

### Exercise 1: Run a POD and load balance ###

kubectl run hello --image=gcr.io/google_containers/echoserver:1.7 --port=8080
kubectl expose deployment hello --type=NodePort
curl -s $(minikube service hello --url) 
curl -s $(minikube service hello --url) | grep Hostname
while true; do sleep 1; curl -s $(minikube service hello --url) | grep Hostname; done
Split to new command line
kubectl scale deployment hello --replicas=3
kubectl delete pod hello-[some pod id]

### Exercise 2: Run a R Server ###

* Run the R/deploy.sh script that uses KubeCtl to stand up the
cluster containing R Shiny engine and its dashboard. On Windows use the Git Bash command prompt to run Bash scripts.

### Exercise 2: Run a RabbitMQ cluster ###

* Run the RabbitMQ/deploy.sh script that uses KubeCtl to stand up a 5 node RabbitMQ solution.

### Technology stack ###

* Kubernetes
* Minikube
* KubeCtl
* R Shiny Server
* RabbitMQ

### Additional information ###

* Visit the No Fluff Just Stuff tour and see this example in action. [Understanding Kubernetes: Fundamentals](https://www.nofluffjuststuff.com/conference/speaker/jonathan_johnson)
