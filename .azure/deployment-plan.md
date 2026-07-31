# Azure App Service deployment plan

## Application summary
- Project type: Spring Boot 3.5 web application
- Packaging: WAR
- Java version: 21
- Target platform: Azure App Service (Linux)

## Deliverables created
- [azure.yaml](../azure.yaml): Azure Developer CLI project metadata for App Service deployment
- [.github/workflows/azure-app-service.yml](../.github/workflows/azure-app-service.yml): GitHub Actions workflow to build and deploy the WAR artifact
- [infra/appservice.bicep](../infra/appservice.bicep): Bicep template for App Service Plan and Web App
- [src/main/resources/application.properties](../src/main/resources/application.properties): Azure-friendly port and health endpoint settings

## Deployment steps
1. Create or select an Azure subscription and resource group.
2. Create the App Service resources with the Bicep template:
   - az group create --name <rg-name> --location <region>
   - az deployment group create --resource-group <rg-name> --template-file infra/appservice.bicep --parameters webAppName=<app-name>
3. Configure GitHub secrets for the workflow:
   - AZURE_CLIENT_ID
   - AZURE_TENANT_ID
   - AZURE_SUBSCRIPTION_ID
   - AZURE_WEBAPP_NAME
4. Push to the main branch or run the workflow manually.
5. Verify the deployment at https://<app-name>.azurewebsites.net/health.

## Notes
- The application is configured to listen on the Azure-provided port via PORT and exposes readiness/liveness health endpoints.
- The workflow builds a WAR package with Maven and deploys it to App Service.
