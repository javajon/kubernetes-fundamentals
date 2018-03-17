A simple way to stand up a complex statistical ecosystem.

1. Install 
   a. Kubernetes (Minikube is a good start)
   b. KubeCtl
   c. Set your environment to the Minikube context with `eval $(minikube docker-env)`

2. Create the a `shiny` namespace.
`kubectl create namespace shiny`

3. Deploy the R-Shiny server to your Kubernetes cluster.
`kubectl create --namespace shiny -f .`

4. It will take a bit of time for the containers to start the first time and 
you can check the status with either of these commands:
`kubectl get pods,service --namespace shiny`
`minikube dashboard`

5. Once start you can see Shiny in action with: 
'minikube service --namespace shiny r-shiny'

After this example you can read up on how to get your own payload of R scripts 
and UI presentations into a container image derived from a Shiny container. There
are several base shiny containers to choose from. Also check out how you can
leverage the Shiny server Markdown pages as a way to deliver dynamic reports with
statical content.
