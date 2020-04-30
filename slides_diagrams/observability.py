from diagrams import Diagram, Cluster
from diagrams.k8s.group import Namespace
from diagrams.k8s.compute import Deployment, Pod
from diagrams.k8s.network import Service
from diagrams.onprem.monitoring import Prometheus, Grafana
from diagrams.onprem.network import Istio

with Diagram('Observability') as result:
    with Cluster('Minikube') as minikube:
        with Cluster('default') as app_namespace:
            Service('simpleapp-sevice') << Deployment('simpleapp') << Pod('simpleapp') << Istio('proxy')
        with Cluster('kube-system') as kube_system:
            istio = Istio('config')
            istio >> Pod('Kiali')
            prom = Prometheus()
            prom << Grafana()
            prom >> Pod('Jaegar')

if __name__ == "__main__":
    result
