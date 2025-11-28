param vnetName string
param vnetAddressPrefix string
param subnetName string
param subnetPrefix string
param location string

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}

// Output subnet ID for VM
output subnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnetName)
