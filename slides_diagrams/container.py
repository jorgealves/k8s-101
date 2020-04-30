from slides_diagrams import Diagram

from slides_diagrams.onprem.container import Docker


with Diagram('Container', show=False) as result:
    Docker('Container')

if __name__ == "__main__":
    result