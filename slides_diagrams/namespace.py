from slides_diagrams import Diagram, Cluster
from slides_diagrams.k8s.compute import Pod
from slides_diagrams.onprem.container import Docker


with Diagram('Namespace', show=False) as result:
    with Cluster('Namespace') as namespace:
        with Cluster('Pod') as pod:
            Docker('Container')

if __name__ == "__main__":
    result
