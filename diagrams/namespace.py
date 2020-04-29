from diagrams import Diagram, Cluster
from diagrams.k8s.compute import Pod
from diagrams.onprem.container import Docker


with Diagram('Namespace', show=False) as result:
    with Cluster('Namespace') as namespace:
        with Cluster('Pod') as pod:
            Docker('Container')

if __name__ == "__main__":
    result
