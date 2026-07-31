@description('Location for the resources')
param location string = resourceGroup().location

@description('Name of the Azure Web App')
param webAppName string = 'banking-demo-${uniqueString(resourceGroup().id)}'

@description('App Service Plan SKU')
param sku string = 'B1'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: '${webAppName}-plan'
  location: location
  sku: {
    name: sku
    tier: sku == 'F1' ? 'Free' : (sku == 'D1' ? 'Shared' : 'Basic')
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'JAVA|21-java21'
      appSettings: [
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
        {
          name: 'JAVA_OPTS'
          value: '-Dserver.port=80'
        }
      ]
    }
  }
}

output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
