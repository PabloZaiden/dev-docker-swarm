# dev-docker-swarm
Create a Docker Swarm dev environment using ```docker-machine```

Executing ```create-cluster.sh``` will:
  - Create a VBox VM with Consul for discovery service
  - Create a VBox VM with a Docker Swarm master
  - Create 2 VBox VMs with Docker Swarm nodes
  - Set your docker envirionment variables to use the Docker Swarm deamon on the Swarm master

To get the nodes IP addresses: 
```docker-machine ip swarm-node-01``` or ```docker-machine ip swarm-node-02```

To use the Docker deamon from the Swarm master, use:
```eval "$(docker-machine env --swarm swarm-master)"```
