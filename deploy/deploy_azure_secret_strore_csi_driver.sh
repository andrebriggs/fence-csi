# Manual yaml install from https://github.com/kubernetes-sigs/secrets-store-csi-driver#install-the-secrets-store-csi-driver

# WARNING: see note about namespace in a real install
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/deploy/rbac-secretproviderclass.yaml # update the namespace of the secrets-store-csi-driver ServiceAccount
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/deploy/csidriver.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/deploy/secrets-store.csi.x-k8s.io_secretproviderclasses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/deploy/secrets-store.csi.x-k8s.io_secretproviderclasspodstatuses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/deploy/secrets-store-csi-driver.yaml

# If using the driver to sync secrets-store content as Kubernetes Secrets, deploy the additional RBAC permissions
# required to enable this feature
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/deploy/rbac-secretprovidersyncing.yaml

#Validate install
kubectl get po --namespace=kube-system
kubectl get crd
# kubectl get pods -l app=csi-secrets-store
# kubectl get ds -l app=csi-secrets-store -o jsonpath='{range .items[*]}{.spec.template.spec.containers[1].args}{"\n"}'


