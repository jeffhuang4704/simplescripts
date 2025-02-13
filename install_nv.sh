helm repo add neuvector https://neuvector.github.io/neuvector-helm/
helm search repo neuvector/core

kubectl create namespace neuvector
helm install neuvector --namespace neuvector --create-namespace neuvector/core

echo 'wait for a while...'
sleep 10
kubectl patch svc neuvector-service-webui -n neuvector --type='merge' -p '{"spec": {"type": "NodePort"}}'
  
# Get the NodePort number of the service
NODE_PORT=$(kubectl get svc neuvector-service-webui -n neuvector -o jsonpath='{.spec.ports[0].nodePort}')
  

echo '🔴 go back to WSL to do port-forwarding'
echo "labctl port-forward -m cplane-01 {id} -L $NODE_PORT:$NODE_PORT"
