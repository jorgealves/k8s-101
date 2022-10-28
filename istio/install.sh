# PRE REQUISITES
# have at least one Rpi (it can be model 2+ but I recommend mode 3b+)
# In each Rpi you have do append container feature inside /boot/cmdline.txt file
cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory

# After that you should make sure that you have SSH connection to your Rpi
#
# Then, you install k3sup on your machine 
# https://github.com/alexellis/k3sup#-micro-tutorial-for-raspberry-pi-2-3-or-4-
#
# Install your master control-plane 

k3sup install --context=pikube --merge --host pimercury --user pi  

# Join command to enable a worker joining a cluster
#
k3sup join --server-host pimercury --host pivenus --user pi 


# in case you use a k3sup cluster turn off traefik lb daemon
kubectl -n kube-system patch daemonset <name-of-daemon-set> -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'

# use istioctl to create base CRDs
istioctl install --set profile=demo -y

# add annotation to default namespace to be tracked by istio 
kubectl label namespace default istio-injection=enabled

# install demo app 
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.15/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get services
kubectl get pods

# test working app 
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

# install istio gateway 
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.15/samples/bookinfo/networking/bookinfo-gateway.yaml

istioctl analyze

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

#get istio samples

mkdir istio_repo && git clone git@github.com:istio/istio.git istio_repo

# install istio demo stack 
kubectl apply -f istio_repo/samples/addons  

#show kiali - default user and pass 'admin:admin'
istioctl dashboard kiali

# show jaeger
istioctl dashboard jaeger

# show prometheus
istioctl dashboard prometheus

#show grafana
istioctl dashboard grafana

# dashboard ids to import to grafana
8588
315
7249
5231

# Test Observability
watch -n 0.5 curl "http://$GATEWAY_URL/productpage"
