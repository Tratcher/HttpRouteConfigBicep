param name string
param location string = resourceGroup().location
param tags object = {}

resource containerAppsEnvironment 'Microsoft.App/managedEnvironments@2024-10-02-preview' = { // @2022-10-01
  name: name
  location: location
  tags: tags
  properties: {
  }
}

resource httpRouteConfig 'Microsoft.App/managedEnvironments/httpRouteConfigs@2024-10-02-preview' = {
  parent: containerAppsEnvironment
  name: 'routeconfig1'
  location: location
  properties: {
    rules: [
        {
            description: 'App 1 rule'
            routes: [
                {
                    match: {
                        prefix: '/app1'
                    }
                    action: {
                        prefixRewrite: '/'
                    }
                }
            ]
            targets: [
                {
                    containerApp: 'app1'
                }
            ]
        }
        {
            description: 'App 2 rule'
            routes: [
                {
                    match: {
                        prefix: '/app2'
                    }
                    action: {
                        prefixRewrite: '/'
                    }
                }
            ]
            targets: [
                {
                    containerApp: 'app2'
                }
            ]
        }
        {
            description: 'App 3 rule'
            routes: [
                {
                    match: {
                        prefix: '/'
                    }
                }
            ]
            targets: [
                {
                    containerApp: 'app3'
                }
            ]
        }
    ]
  }
}

output name string = containerAppsEnvironment.name
output domain string = containerAppsEnvironment.properties.defaultDomain
