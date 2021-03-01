
az keyvault secret set \
    --vault-name $VAULT_NAME \
    --name "ExamplePassword" \
    --value "hVFkk965BuUv" # Not real

# Upload creds used by database setup
# az keyvault secret set --vault-name $VAULT_NAME --name "fence-creds" --file ./secrets/creds.json`

# Upload config used by Fence. 
    # Based on https://github.com/uc-cdis/cloud-automation/blob/master/gen3/lib/bootstrap/templates/Gen3Secrets/apis_configs/fence-config.yaml
    # My version has Azure support. See https://github.com/andrebriggs/fence/commit/8aec0b111d0d69f512fd6df466b877d6a09ffff9
# az keyvault secret set --vault-name $VAULT_NAME --name "fence-config" --file ./secrets/fence-config.yaml
