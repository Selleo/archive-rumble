from diagrams.aws.compute import ECS
from diagrams import Cluster, Diagram

from diagrams.aws.network import ELB


graph_attr = {
    "bgcolor": "transparent"
}

with Diagram("", show=False, direction="TB", filename="diagram", graph_attr=graph_attr):
    lb = ELB("Load balancer")

    with Cluster("t3.medium - 2vCPU, 4GiB"):
        with Cluster("ECS service"):
            service = [ECS("Task 3"),ECS("Task 2"),ECS("Task 1")]

    lb >> service

