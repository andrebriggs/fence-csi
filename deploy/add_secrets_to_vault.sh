
az keyvault secret set \
    --vault-name $VAULT_NAME \
    --name "ExamplePassword" \
    --value "hVFkk965BuUv" # Not real

# `az keyvault secret set --vault-name $VAULT_NAME --name "fence-creds" --file ./secrets/creds.json`