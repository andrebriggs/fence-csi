# Fence on Azure Cloud POC

## Goals
- [x] Create AKS cluster that supports managed identities 
- [x] Have all mounted secrets from Azure Key Vault using CSI Driver and AAD Pod Identity
- [x] Successful run of k8s job to initialize Fence DB (uses Azure Key Vault derived secrets)
- [ ] Successful setup the [Fence](https://github.com/andrebriggs/fence/tree/azure_support) deployment and service k8s objects (uses Azure Key Vault derived secrets)

## What's going on
* Create an Azure Identity that has a reader role to Azure KeyVault 
* Associate the Azure Identity with AAD Pod Identity (in k8s)
* Correctly labeled k8s deployments use the Azure Identity via AAD Pod Identity and are able to access Azure KeyVault as a mounted volume using the [secrets-store-csi-driver](https://github.com/kubernetes-sigs/secrets-store-csi-driver) and [secrets-store-csi-driver-provider-azure](https://github.com/Azure/secrets-store-csi-driver-provider-azure)
* A K8S job resource creates pod that [initializes](https://github.com/uc-cdis/userdatamodel) the Fence database (creates tables, etc) after loading credentials from a file that is setup in Azure KeyVault  

## Manual Steps for PostGres
* Create Azure PostgreSQL server
* Login to the `postgres` db and create a new database (I used `metadata_db`)
* Run the `fencedb-create-job.yaml` and wait for completion
* Check logs of pod that the job created (`k logs fencedb-create-xxxxx`)
* Log into DB verify tables are created

The job creates a pod that looks for a creds json file in the format of 
```json
{
    "db_host": "<YOUR ACCOUNT>.postgres.database.azure.com",
    "db_username": "<Azure Postgres Username>",
    "db_password": "<Password>",
    "db_database": "<Whatever you named the DB>"
}
```
If running scripts in `./deploy` load the folling ENV VARS into your environment:
```bash
export SUBID="Azure subscription guid"
export REGION="Azure region, for instance <westus>"
export RESOURCE_GROUP="Azure resource group name" 
export CLUSTER="AKS Cluster name"
export STORAGE_ACCOUNT="Azure Storage account name"
export NODE_RESOURCE_GROUP="Managed cluster resource group <MC_xxxxx>"
export SUBID="Azure subscription guid"
export VAULT_NAME="Azure Keyvault name"
```

## Long Term
Using Terraform would most likely be a better production choice when setting up all of this. We could utilize [Bedrock](https://github.com/Microsoft/bedrock) TF templates.   

<!-- 

-----

Adding `creds.json` to AzKV:
`az keyvault secret set --vault-name $VAULT_NAME --name "fence-creds" --file ./secrets/creds.json`

[Install the Azure Key Vault Provider](https://github.com/Azure/secrets-store-csi-driver-provider-azure/blob/master/docs/install-yamls.md#install-the-azure-key-vault-provider)

`kubectl apply -f https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/deployment/provider-azure-installer.yaml`

Things that helped:
https://github.com/Azure/secrets-store-csi-driver-provider-azure/issues/88

Finally verify with kubectl exec -it nginx-secrets-store-inline cat /mnt/secrets-store/fence-creds -->
