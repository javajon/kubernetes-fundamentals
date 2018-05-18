# Discovering Clusters With Minikube #

Example containers one can run on a Kubernetes cluster, such as Minikube.

## Demonstrating Kubernetes ##

### Kubernetes setup ##

1. Clone this Git project
1. Install [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube/) (or any other Kubernetes cluster)
1. Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) command line tool for Kubernetes
1. Start Minikube: `minikube start --kubernetes-version v1.9.4 --cpus 4 --memory 8000 --disk-size 80g -p minikube-hello`
1. Use profile specificed above: `minikube profile minikube-hello`
1. Verify `minikube status && kubectl version` reports correctly

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

### Exercise 3: Intra-service communication ###

An immediate benefit Kubernetes provides developers of containers is a level playing field for communicating between containers. Each container runs in a Pod, each Pod is fronted by a Service that routes traffic to its associated Pods, round-robin style. While each Pod in Kubernetes' network plane is assigned a virtual IP, you should not to connect to containers with these IPs. In fact, within your container code there should typically be no coupling to the Kubernetes ecosystem.

Simply, communication is easily achieved with the Kube-DNS or CoreDNS service, standard issue for most Kubernetes clusters. With this, as long as you know the label assigned to the service you can reach it with a simple URL such as http://label-of-service/namespace/local.srv.local. Even simpler, if the two Pods are in the same Namespace you can simple use this short URL http://label-of-service. The :[port] postfix can also be specified. Try this 3 step example.

1. Add a [Nginx](https://hub.docker.com/_/nginx/) deployment with an associated service named "nginx" to the default namespace:

``` sh
kubectl create -f https://raw.githubusercontent.com/javajon/kubernetes-fundamentals/master/nginx/nginx.yaml
```

2. Start and enter a (Busybox container](https://docs.docker.com/samples/library/busybox/) in a separate Pod in the same Namespace.

``` sh
kubectl run curl-test --image=radial/busyboxplus:curl -i --tty --rm
```

3. Shortly your terminal will assume the prompt inside the Busybox container. Enter:

``` sh
curl http://nginx
curl -I http://nginx:80
curl http://nginx/default
curl http://nginx/default/svc/cluster/local
```

These variants will all access the same Nginx default web page. As long as your know the service the Kubernetes DNS will resolve your URL to the Service name that fronts the target's Pod(s).

More on this can be found [here](https://kubernetes.io/docs/concepts/services-networking/service/#dns).

### Technology stack ###

* Kubernetes
* Minikube
* KubeCtl
* Nginx
* Busybox
* R Shiny Server
* RabbitMQ

### Additional information ###

* Visit the No Fluff Just Stuff tour and see this example in action. [Understanding Kubernetes: Fundamentals](https://www.nofluffjuststuff.com/conference/speaker/jonathan_johnson)
