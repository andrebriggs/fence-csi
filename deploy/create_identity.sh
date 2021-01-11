export identityName=svc-fence-identity

az identity create -g $RESOURCE_GROUP -n $identityName