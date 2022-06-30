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

# 3. Viewing Pods and Nodes
