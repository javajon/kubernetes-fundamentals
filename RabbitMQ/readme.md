# Running RabbitMQ on Kubernetes #

Kubernetes is an ideal container management platform for hosting both RabbitMQ and your applications that interact with this message broker solution.

> RabbitMQ is an open source message broker software (sometimes called message-oriented middleware) that originally implemented the Advanced Message Queuing Protocol (AMQP) and has since been extended with a plug-in architecture to support Streaming Text Oriented Messaging Protocol (STOMP), Message Queuing Telemetry Transport (MQTT), and other protocols. -- Wikipedia

Thanks to Helm, a package manager for Kubernetes, the installation is simple.

## Setup Kubernetes Cluster ##

Install Kubernetes ([Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) is a good start)
Install [KubeCtl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
Install [Helm](https://docs.helm.sh/using_helm/)

## Start RabbitMQ ##

An example installed instance of RabbitMQ running on Kubernetes is done by invoking this stable Helm chart.  

``` sh
helm install stable/rabbitmq \
--name my-rabbit \
--namespace rabbit \
--set replicas=3 \
--set serviceType=NodePort \
--set rabbitmq.nodePort=31333 \
--set rabbitmq.username=admin \
--set rabbitmq.password=admin
```

Once running, launch the RabbitMQ Management Dashboard by going to the last URL listed with this command:

```
minikube service --namespace rabbit my-rabbit-rabbitmq
```

At the RabbitMQ dashboard login prompt the user name and password is admin/admin.

Go to the Kubernetes dashboard, with `minikube dashboard` and kill one of the 3 RabbitMQ Pods listed. In the RabbitMQ dashboard they call it a "Node". Observe in both the Kubernetes and RabbitMQ dashboards how the "Kubernetes Pod" and corresponding "RabbitMQ Node" indicates the failure and self-repairs.

## References ##

- This RabbitMQ demonstration is also available on [Katacoda](https://www.katacoda.com/javajon/courses/kubernetes-applications).
- Source for the [stable/rabbit Helm chart](https://github.com/helm/charts/tree/master/stable/rabbitmq).
- See [This helpful blog](https://wesmorgan.svbtle.com/rabbitmq-cluster-on-kubernetes-with-statefulsets) from Wes Morgan
