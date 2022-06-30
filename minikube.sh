# 1. create a cluster
# check minikube version
minicube version
# start cluster
minikube start
# kubectl version
kubectl version
# cluster details
kubectl cluster-info
# check nodes
kubectl get nodes

# 2. 	Create a deployment
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
# check deployments
kubectl get deployments
# view deployed app
kubectl proxy
# without podname
curl http://localhost:8001/version

# with podname
# pod name
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
# check name
echo Name of the Pod: $POD_NAME
# check app
curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/

# 3. Explore app: Viewing Pods and Nodes, troubleshooting deployments
kubectl get - list resources
kubectl describe - show detailed information about a resource
kubectl logs - print the logs from a container in a pod
kubectl exec - execute a command on a container in a pod

kubectl get pods
kubectl describe pods
# view container logs
# get name then check logs
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
kubectl logs  $POD_NAME
# list env variables
kubectl exec $POD_NAME -- en
# start bash session in pods container
kubectl exec -ti $POD_NAME -- bash
exit #exits the node's env/terminal

# 4. Expose app publicly
# get services
kubectl get services
# create external service w/nodePort. loadbalancer isnt't possible on minicube yet
kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080
kubectl get services
# describe deployment
kubectl describe services/kubernetes-bootcamp
# create node port env var
export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT
# test app is exposed externally
curl $(minikube ip):$NODE_POR
# using labels: label assigned when running
kubectl describe deployment
# query our list of pods, description too
kubectl get pods -l app=kubernetes-bootcamp
kubectl describe pods -l app=kubernetes-bootcamp
# do same for services too
kubectl get services -l app=kubernetes-bootcamp
# get pod name
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
# applying new label: label command then object type, object name and the new label:
kubectl label pods $POD_NAME version=v1
# describe pod again
kubectl describe pods $POD_NAM
# get the specific pod version
kubectl get pods -l version=v1
# deleting a service
kubectl delete service -l app=kubernetes-bootcamp
# confirm by checking the previous exposed port or listing services
curl $(minikube ip):$NODE_PORT
kubectl get services
# confirm its still running on the inside
kubectl exec -ti $POD_NAME -- curl localhost:8080
