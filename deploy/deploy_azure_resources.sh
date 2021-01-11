az extension add --name aks-preview

az group create -n $RESOURCE_GROUP -l $REGION

# KeyVault 
az keyvault create --name $VAULT_NAME --resource-group $RESOURCE_GROUP --location $REGION

# Storage
az storage account create -n $STORAGE_ACCOUNT -g $RESOURCE_GROUP -l $REGION --sku Standard_LRS

# AKS with Managed Identity
az aks create -g $RESOURCE_GROUP -n $CLUSTER --enable-managed-identity
az aks show -g $RESOURCE_GROUP -n $CLUSTER --query "identity"
az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER
