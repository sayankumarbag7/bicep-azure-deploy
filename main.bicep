
targetScope = 'resourceGroup'

param location string = resourceGroup().location
param vnetName string = 'myVnet'
param vnetAddressPrefix string = '10.0.0.0/16'
param subnetName string = 'mySubnet'
param subnetPrefix string = '10.0.0.0/24'
param vmName string = 'myVM'
param adminUsername string = 'azureuser'
@secure()
param adminPassword string

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

module vmModule 'vm.bicep' = {
  name: 'vmDeployment'
  params: {
    vmName: vmName
    location: location
    adminUsername: adminUsername
    adminPassword: adminPassword
    subnetId: networkModule.outputs.subnetId
  }
}
