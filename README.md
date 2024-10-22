# terraform_aws_serverless_infrastructure
Dynamic Serverless AWS Architecture with Terraform

Description: This repository contains the code for setting up a dynamic and serverless AWS infrastructure using Terraform. The infrastructure leverages several AWS services to create a scalable, event-driven system suitable for various serverless applications. The key components of this project include Amazon RDS, AWS Lambda functions, API Gateway, EventBridge, IAM roles, and security groups, all organized using a modular Terraform configuration.

# Features:

- AWS EventBridge Integration: EventBridge triggers serverless Lambda functions for automation and orchestration based on predefined rules.
- Amazon RDS (MySQL Database): MySQL RDS instance for reliable data storage, secured using security groups.
- Serverless Compute (AWS Lambda): Multiple Lambda functions for data processing (API Lambda) and data retrieval (Get RDS Data Lambda), with automated scaling capabilities.
- API Gateway Integration: RESTful endpoint for secure data access from RDS using Get RDS Data Lambda.
- IAM Roles & Security Groups: Implementation of least privilege principles using IAM roles for AWS services and security groups for network control.
- Terraform Modular Design: Organized as reusable modules for Lambda, IAM, RDS, and network security, enabling easier maintainability and scalability.

# Benefits of Using Terraform:
Infrastructure as Code (IaC): Enables version-controlled, reusable infrastructure, ensuring consistent deployments.
Modular Architecture: Components are broken down into reusable modules for easy integration into other projects.
Scalable and Secure: Designed to scale based on demand while keeping security best practices in mind.

## Getting Started: To deploy this infrastructure:

# Clone the repository.
Modify variables.tf as per your environment.
Run **terraform init**, **terraform plan**, and **terraform apply** to create the resources.

Use Cases:
- Event-driven serverless data processing.
- Secure RESTful API for querying a MySQL database.
- Demonstration of Terraform’s power in creating scalable AWS architectures.

# Technologies Used:
- AWS Services: Lambda, RDS (MySQL), API Gateway, EventBridge, IAM, VPC.
- Terraform: Infrastructure as Code (IaC) for AWS.
- Feel free to clone, modify, and use this infrastructure as a starting point for your own serverless AWS projects.
