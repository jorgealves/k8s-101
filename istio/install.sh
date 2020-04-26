# use istioctl to create base CRDs
istioctl manifest apply --set profile=demo

# add annotation to default namespace to be tracked by istio 
kubectl label namespace default istio-injection=enabled

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