See [This helpful blog](https://wesmorgan.svbtle.com/rabbitmq-cluster-on-kubernetes-with-statefulsets) from Wes Morgan

1) Install
   a. Kubernetes (Minikube is a good start)
   b. KubeCtl
   c. Set your environment to the Minikube context with `eval $(minikube docker-env)`

2) Create a namespace such as *rabbit*:
`kubectl create namespace rabbit`

3) Create a new secret to hold the Erlang cookie:

To launch the RabbitMQ Management Dashboard run:
`minikube service --namespace rabbit rabbitmq-management`

The default user name and password is guest/guest

Ideally the Helm chart [stable/rabbitmq](https://github.com/kubernetes/charts/tree/master/stable/rabbitmq) is a better solution.

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

