helm repo add chaos-mesh https://charts.chaos-mesh.org
kubectl create ns chaos-mesh

# for Containerd environment
helm install chaos-mesh chaos-mesh/chaos-mesh -n=chaos-mesh --set chaosDaemon.runtime=containerd --set chaosDaemon.socketPath=/run/containerd/containerd.sock
