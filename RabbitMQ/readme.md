See [This helpful blog](https://wesmorgan.svbtle.com/rabbitmq-cluster-on-kubernetes-with-statefulsets) from Wes Morgan

1) Install 
   a. Kubernetes (Minikube is a good start)
   b. KubeCtl
   c. Set your environment to the Minikube context with `eval $(minikube docker-env)`

2) Create a namespace such as `rabbit`:
`kubectl create namespace rabbit`

3) Create a new secret to hold the Erlang cookie:
`kubectl create secret generic rabbitmq-config --namespace rabbit --from-literal=erlang-cookie=c-is-for-cookie-thats-good-enough-for-me` 

4) Create the StatefulSet with Services
`kubectl create --namespace rabbit -f rabbitmq.yaml`

To launch the RabbitMQ Management Dashboard run:
`minikube service --namespace rabbit rabbitmq-management`

The default user name and password is guest/guest
