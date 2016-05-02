#create consul machine
docker-machine create -d=virtualbox consul-machine
eval $(docker-machine env consul-machine)

#consul up
docker-compose up -d

#create swarm master machine
docker-machine create -d virtualbox --virtualbox-disk-size "5000" --swarm --swarm-master --swarm-discovery="consul://$(docker-machine ip consul-machine):8500" --engine-opt="cluster-store=consul://$(docker-machine ip consul-machine):8500" --engine-opt="cluster-advertise=eth1:2376" swarm-master

#create node 01
docker-machine create -d virtualbox --swarm --swarm-discovery="consul://$(docker-machine ip consul-machine):8500" --engine-opt="cluster-store=consul://$(docker-machine ip consul-machine):8500" --engine-opt="cluster-advertise=eth1:2376" swarm-node-01

#create node 02
docker-machine create -d virtualbox --swarm --swarm-discovery="consul://$(docker-machine ip consul-machine):8500" --engine-opt="cluster-store=consul://$(docker-machine ip consul-machine):8500" --engine-opt="cluster-advertise=eth1:2376" swarm-node-02

#connect to cluster
eval "$(docker-machine env --swarm swarm-master)"
docker info

#see nodes in the cluster
docker run swarm list consul://$(docker-machine ip consul-machine):8500
