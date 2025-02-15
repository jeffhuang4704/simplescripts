# Add the Grafana Helm Repository
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Install Grafana
helm install grafana grafana/grafana --namespace monitoring --create-namespace

# Change svc type to NodePort
kubectl patch svc grafana -n monitoring -p '{"spec": {"type": "NodePort"}}'

# get svc port
NODE_PORT=$(kubectl get svc grafana -n monitoring -o jsonpath='{.spec.ports[0].nodePort}')

# get gra
echo "🔴 Grafana admin password:"
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
echo ""

# Do port-forward on WSL
echo "🔴 Do port-forward on WSL"
echo "labctl port-forward -m cplane-01 {playground_id} -L $NODE_PORT:$NODE_PORT"