export clientId="23fdc9b3-7fcd-403b-819b-297bb82fa9fb" # the result of create_identity.sh
az role assignment create --role "Reader" --assignee $clientId --scope /subscriptions/$SUBID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.KeyVault/vaults/$VAULT_NAME

az keyvault set-policy -n $VAULT_NAME --secret-permissions get --spn $clientId
az keyvault set-policy -n $VAULT_NAME --key-permissions get --spn $clientId
