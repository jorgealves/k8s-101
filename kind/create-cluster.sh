# create cluster 
kind create cluster --config cluster.yml

# install dashboard 
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

#cluster roles for dashboard 
kubectl create clusterrolebinding default-admin --clusterrole cluster-admin --serviceaccount=default:default

#get token to access dashboard 
kubectl get secrets -o jsonpath="{.items[?(@.metadata.annotations['kubernetes\.io/service-account\.name']=='default')].data.token}"|base64 --decode

#proxy dashboard 
kubectl proxy