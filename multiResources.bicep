param location string = resourceGroup().location
param storageName string
param appServiceName string

// Storage Account
resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

// App Service Plan (Server Farm)
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: '${appServiceName}-plan'
  location: location
  sku: {
    name: 'B1'       // Basic tier, can change to S1, P1, etc.
    tier: 'Basic'
  }
}

// App Service
resource appService 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
  }
}

output storageId string = storage.id
output appServiceId string = appService.id
