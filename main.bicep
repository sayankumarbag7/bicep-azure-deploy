targetScope = 'resourceGroup'

// General parameters
param location string = resourceGroup().location
param vnetName string = 'myVnet'
param vnetAddressPrefix string = '10.0.0.0/16'
param subnetName string = 'mySubnet'
param subnetPrefix string = '10.0.0.0/24'

// VM parameters
param vmName string
param adminUsername string
@secure()
param adminPassword string
param vmSize string = 'Standard_B1ms' 

// Deploy network first
module networkModule 'network.bicep' = {
  name: 'networkDeployment'
  params: {
    vnetName: vnetName
    vnetAddressPrefix: vnetAddressPrefix
    subnetName: subnetName
    subnetPrefix: subnetPrefix
    location: location
  }
}

// Deploy VM after network
module vmModule 'vm.bicep' = {
  name: 'vmDeployment'
  params: {
    vmName: vmName
    location: location
    adminUsername: adminUsername
    adminPassword: adminPassword
    subnetId: networkModule.outputs.subnetId
    vmSize: vmSize
  }
}
