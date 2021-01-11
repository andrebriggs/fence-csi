export clientId="541dc7dc-63f1-4a45-ace6-f83ac3314ff3" # Agentpool MI

az role assignment create --role "Managed Identity Operator" --assignee $clientId --scope /subscriptions/$SUBID/resourcegroups/$RESOURCE_GROUP
az role assignment create --role "Managed Identity Operator" --assignee $clientId --scope /subscriptions/$SUBID/resourcegroups/$NODE_RESOURCE_GROUP
az role assignment create --role "Virtual Machine Contributor" --assignee $clientId --scope /subscriptions/$SUBID/resourcegroups/$NODE_RESOURCE_GROUP