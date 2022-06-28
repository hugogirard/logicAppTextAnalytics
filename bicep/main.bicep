targetScope='subscription'

param location string
param rgName string = 'rg-logic-app-ai-demo'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}
