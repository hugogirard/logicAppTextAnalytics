param storageAccountName string
param principalId string
param textAnalyticServiceName string

var storageBlobDataContributorRoleGuid = guid(subscription().subscriptionId, textAnalyticServiceName, storageAccountName, 'storageBlobDataContributor')
var storageBlobDataContributorRole = resourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')

resource storage 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: storageAccountName
}

resource rbacStorage 'Microsoft.Storage/storageAccounts/providers/roleAssignments@2020-04-01-preview' = {
  name: guid(subscription().id,principalId)
  scope: storage
  properties: {
    roleDefinitionId: storageBlobDataContributorRole
    principalId: principalId
    principalType: 'ServicePrincipal'    
  }
}
