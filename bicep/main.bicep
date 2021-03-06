targetScope='subscription'

param location string
param rgName string = 'rg-logic-app-ai-demo'

var suffix = uniqueString(rg.id)

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

module storage 'modules/storage/storage.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'storage'
  params: {
    location: location
    suffix: suffix
  }
}

module textAnalytics 'modules/cognitive/textanalytic.bicep' = {
  scope: resourceGroup(rg.name)
  name: 'txtAnalytics'
  params: {
    location: location
    storageId: storage.outputs.strDocumentId
    suffix: suffix
  }
}

// module role 'modules/rbac/roles.bicep' = {
//   scope: resourceGroup(rg.name)
//   name: 'rbacStorage'
//   params: {
//     principalId: textAnalytics.outputs.managedIdentity
//     storageAccountName: storage.outputs.strDocumentName
//     textAnalyticServiceName: textAnalytics.outputs.txtAnalyticServiceName
//   }
// }
