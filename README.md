# RClone Containerized Application Readme

## Overview

This README provides essential information for deploying and using the RClone containerized application.
RClone is a powerful command-line program for managing and syncing data to and from various cloud storage providers.
This containerized version makes it easy to deploy RClone as a cron job using Helm charts.

## Prerequisites

Before deploying the RClone container, ensure that you have the following prerequisites in place:

- A Kubernetes cluster for deploying the Helm chart.
- Understanding of the helm chart at [github.com/amsterdam/helm-generic-application](https://github.com/Amsterdam/helm-generic-application).

## Deployment

To deploy the RClone containerized application, follow these steps:

Create or update the `secrets`:

```yaml
secrets:
 rclone:
   type: keyvault
   secrets:
     - objectstore-user
     - objectstore-password
     - objectstore-tenant
     - objectstore-tenant-id
```

Make sure these secrets exist with the proper values in your KeyVault.

## Example Cron Job

To create a cron job that runs RClone at a specific schedule, use the following configuration in your Helm values file:

```yaml
cronJobs:
 rclone:
   labels:
     component: rclone
   schedule: "0 * * * *"
   containers:
     - name: main
       image:
         repository: tamm/rclone
         tag: 0.2.0
       secrets:
         - rclone
       tempDirs:
         - /home/rclone/.config
       args:
         - rclone
         - sync
         - objectstore:my-container
         - azure:my-container
         - -v
       env:
         OBJECSTORE_AUTH_URL: https://identity.stack.cloudvps.com/v2.0
         STORAGE_ACCOUNT_NAME: mystorageaccount
```

This example creates a cron job that runs the RClone container at the top of every hour. Modify the schedule and container configuration to meet your specific needs.

Make sure you whitelist the following urls:
```
identity.stack.cloudvps.com
*.objectstore.eu
```

## Customization

You can customize this Helm chart and the RClone configuration to adapt it to your specific requirements. 
Update the environment variables and secrets as needed to connect to your object store and configure RClone for your use case.

For more information about RClone and its capabilities, refer to the official documentation: 
[RClone Documentation](https://rclone.org/docs/).

And the remotes: 
- [swift / OpenStack Object Storage](https://rclone.org/swift/)
- [Microsoft Azure Blob Storage](https://rclone.org/azureblob/)
