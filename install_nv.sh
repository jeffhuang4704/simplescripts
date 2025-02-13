helm repo add neuvector https://neuvector.github.io/neuvector-helm/
helm search repo neuvector/core

kubectl create namespace neuvector
helm install neuvector --namespace neuvector --create-namespace \
  --set controller.env[0].name="CTRL_PATH_DEBUG" \
  --set controller.env[0].value="1" \
  neuvector/core

echo 'wait for a while...'
sleep 10
kubectl patch svc neuvector-service-webui -n neuvector --type='merge' -p '{"spec": {"type": "NodePort"}}'
  
# Get the NodePort number of the service
NODE_PORT=$(kubectl get svc neuvector-service-webui -n neuvector -o jsonpath='{.spec.ports[0].nodePort}')
  
# Get playground id
PLAYGROUND_ID=$(labctl playground list | awk 'NR==2 {print $1}')

echo '🔴 go back to WSL to do port-forwarding'
echo "then open your browser and go to https://localhost:$NODE_PORT"
echo ''
echo "labctl port-forward -m cplane-01 $PLAYGROUND_ID -L $NODE_PORT:$NODE_PORT"
