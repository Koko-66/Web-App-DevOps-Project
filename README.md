# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

[SECTION 1 - App](#section-1---app)
- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)

[SECTION 2 - System architecture](#section-2---system-architecture)
- [Containerisation with Docker](#containerisation-with-docker)
- [Terraform (IaC)](#terraform-iac)
- [Kubernetes deployment](#kubernetes-deployment)
- [CI/CD implementation with Azure Pipelines](#cicd-implementation-with-azure-pipelines)
- [AKS Cluster Monitoring](#aks-cluster-monitoring)
- [Managing Secrets](#managing-secrets)
- [Contributors](#contributors)
- [License](#license)
<br><br>
---
---

## SECTION 1 - App

Section below contains description of the app, outlining its main features, prerequisites, usage and tech stack used to build it.

## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

## Features pending implementation
- **Delivery Date:** A column to track delivery dates for orders. Can be used to gain valuable insights into various metrics, e.g.:
    - Track the number of orders made/shipped vs. delivered.
    - Track the success rate of deliveries per user to identify potential issues with addresses/unwanted customer behaviour.
    - In conjunction with Shipping Date, can be used to track 'time-to-delivery' providing valuable insights into potential issues with delivery service providers/bottlenecks.
    - Track and compare the performance (delivery success/time-to-delivery) of various delivery service providers, etc.
    
    The feature was implemented successfully in feature branch [`feature/add-delivery-date`](https://github.com/Koko-66/Web-App-DevOps-Project/tree/feature/add-delivery-date) and is ready to be merged into the production branch when required (provided there are no merge conflicts).

    _NOTE: It is recommended that additional functionality implementing the solutions mentioned above are developed in separate branch(es)._

## Getting Started

### Prerequisites

For the application to successfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)
- azure-identity (version 1.15.0)
- azure-keyvault-secrets (version 4.7.0)

### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.
<br><br>
---
---

## SECTION 2 - System architecture

In this project, the system architecture is built using various components. Key elements include GitHub for version control, Docker for containerization and Docker Hub for image hosting and distribution, Azure Pipelines for automating CI/CD, Terraform for infrastructure as code, AKS clusters for scalable Kubernetes environments, Azure Monitor with Application Insights and Logs for monitoring and advanced data analytics, and Azure Key Vault for secure credential management. This section of documentation will provide insights into each component's role and implementation. 

The diagram below provides and overview of how the components interact with each other to create a comprehensive, stable and reliable system.

<!-- ![UML diagram](media/UML_diagram.png) -->

<img src="media/UML_diagram.png" alt="UML diagram">

## Containerisation with Docker

The app has been containerized &mdash; packaged up with all its code, dependencies, necessary executables and configuration files &mdash; and pushed to Docker Hub to facilitate version management, and easy and quick updates and deployment.

Containerization has many benefits. Because containers encapsulate applications with all their dependencies, they run consistently irrespective of the end user's operating system or environment. This isolation of the container's content promotes security and prevents conflicts between applications and libraries. Containers are also highly portable and efficient. They can be easily run on any machine(s) no matter the underlying infrastructure, and because they share the host's OS kernel, they do not take up unnecessary resources and are very lightweight.

These advantages are especially important in a DevOps setting, where applications are deployed across different environments (e.g. development, test, production) and shared between developers working on machines with different OS and hardware. Their small and lightweight nature make continuous deployment easy, and because they can be used together to build larger multi-container applications they offer great flexibility and scalability.

In this project Docker is used to containerise the application which will then be deployed to our cluster, while Docker Hub is used for hosting and version control of the image.
More details about the container and containerisation process are available in [_Docker_overview&containerisation_process.md_](https://github.com/Koko-66/Web-App-DevOps-Project/blob/main/Docs/Docker_overview&containerisation_process.md).

## Terraform (IaC)

Terraform is an Infrastructure as Code tool used to define and provision infrastructure resources (e.g. virtual machines, networks, and databases) in a declarative way, i.e. using code. The code defines the infrastructure configurations, which can then be executed to create, modify, or destroy the specified resources.

IaC is a powerful tool enabling automation, version control, reusability and consistency in the provisioning and management of infrastructure resources.

In this project Terraform is used to provision Azure resources needed to run the app on Azure Kubernetes Service (AKS). It comprises two modules: networking-module and aks-cluster-module. For more details on the setup of the Terraform project and modules see [_Terraform project setup.md_](https://github.com/Koko-66/Web-App-DevOps-Project/blob/main/Docs/Terraform_project_setup.md). 

## Kubernetes deployment 

Deploying the containers using Kubernetes offers significant advantages. It mitigates errors by automating the processes of deploying, scaling and updating applications, and adds to the overall portability of the whole app, which can be easily moved between different environments. 
It also allows to quickly scale the application up or down, depending on need, and is designed to be self-healing - it monitors its components for failures and can automatically recover from them. 

The deployment process and manifests used in this project are described in more detail in [_Deploying_with_Kubernetes.md_](https://github.com/Koko-66/Web-App-DevOps-Project/blob/main/Docs/Deploying_with_Kubernetes.md)

## CI/CD implementation with Azure Pipelines

The project takes advantage of the CI/CD capabilities of Azure DevOps' **Pipelines** to automate the building of Docker image and deployment of the app to the AKS cluster. This approach ensures automated, efficient and consistent process for implementing code changes and their deployment.

The details of the CI/CD pipeline configuration can be found in the file [_Pipeline_configuration.md_](https://github.com/Koko-66/Web-App-DevOps-Project/blob/main/Docs/Pipeline_configuration.md)

## AKS Cluster Monitoring
Monitoring clusters in CI/CD is essential to ensuring the stability and performance of the Ci/CD pipelines. It allows for quick detection of issues such as resource constraints, failures, and bottlenecks, which in turn enables rapid response to resolve issues and improve the software development process.

To ensure the infrastructure and software work as expected at all times, this project utilizes Azure Monitor features that provide access to various tracking charts and alerts.

A more detailed description of measures implemented is available in the [_Cluster_monitoring.md_](https://github.com/Koko-66/Web-App-DevOps-Project/blob/main/Docs/Cluster_monitoring.md)

## Managing Secrets
Protecting and managing secrets and sensitive information is a crucial aspect of development, integral to maintaining the security and integrity of both the application and its users' data. Failure to adequately protect these can lead to serious consequences, including unauthorized access, data breaches, financial loss, reputational damage, and even legal liabilities. 
Key Vault in Azure portal offers effective secret management that helps mitigate risks, stay in line with privacy standards, and uphold the integrity of applications, while. Details of how Azure Key Vault is used in this project are available in file [Secrets_management_with_Azure_Key_Vault.md]A more detailed description of measures implemented is available in the [_Cluster_monitoring.md_](https://github.com/Koko-66/Web-App-DevOps-Project/blob/main/Docs/Secrets_management_with_Azure_Key_Vault.md)

## Contributors 

- [Maya Iuga](https://github.com/maya-a-iuga)
- [Koko-66](https://github.com/koko-66)

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.