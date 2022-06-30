param location string
param storageId string
param suffix string

resource textAnalytics 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: 'txt-ana-${suffix}'
  kind: 'TextAnalytics'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'S'
  }
  properties: {
    userOwnedStorage: [
      {
        resourceId: storageId
      }
    ]
  }
}

output txtAnalyticServiceName string = textAnalytics.name
output managedIdentity string = textAnalytics.identity.principalId
