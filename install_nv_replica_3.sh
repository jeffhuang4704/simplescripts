
# Get the list of nodes and their status
nodes=$(kubectl get nodes --no-headers | awk '{print $2}')

# Check if any node is not in the "Ready" state
for status in $nodes; do
  if [[ "$status" != "Ready" ]]; then
    echo "Not all nodes are ready. Found status: $status"
    exit 1  # Exit with a non-zero code to indicate failure
  fi
done

echo "All nodes are ready. Start installing NeuVector"

helm repo add neuvector https://neuvector.github.io/neuvector-helm/
helm search repo neuvector/core

kubectl create namespace neuvector

helm install neuvector --namespace neuvector --create-namespace \
  --set controller.env[0].name="CTRL_PATH_DEBUG" \
  --set-string controller.env[0].value="1" \
  neuvector/core

echo 'wait for a while...'
sleep 12
kubectl patch svc neuvector-service-webui -n neuvector --type='merge' -p '{"spec": {"type": "NodePort"}}'
  
# Get the NodePort number of the service
NODE_PORT=$(kubectl get svc neuvector-service-webui -n neuvector -o jsonpath='{.spec.ports[0].nodePort}')
  
echo '🔴 go back to WSL to do port-forwarding'
echo "then open your browser and go to 👉  https://localhost:$NODE_PORT"
echo ''
echo "labctl port-forward -m cplane-01 {PLAYGROUND_ID} -L $NODE_PORT:$NODE_PORT"
echo ''
echo '🟢 to uninstall NeuVector, run the following command:'
echo 'helm uninstall neuvector -n neuvector'
