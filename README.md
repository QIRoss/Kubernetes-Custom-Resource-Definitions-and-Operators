# Kubernetes Custom Resource Definitions and Operators

Studies based in day 13-14 of 100 Days System Design for DevOps and Cloud Engineers.

https://deoshankar.medium.com/100-days-system-design-for-devops-and-cloud-engineers-18af7a80bc6f

Days 11–20: Advanced Cloud-Native Technologies

Day 13–14: Explore and implement advanced Kubernetes concepts like Custom Resource Definitions (CRDs) and Operators.

(FAILED EXPERIENCE UNTIL NOW SINCE OPERATOR NOT CONNECTING PROPERLY)

## What is a CRD?
Custom Resource Definitions (CRDs) allow you to extend Kubernetes by defining your own types of resources, apart from the default Kubernetes objects like Pods, Services, and Deployments. A CRD acts as a blueprint for Kubernetes to understand a new type of resource.

In this project, we define a FastAPIDeployment CRD, which represents a custom resource that holds the configuration for deploying a FastAPI application on Kubernetes. This custom resource contains specifications like:

The Docker image of the FastAPI application.
The number of replicas (Pods) to run.
The port to expose for the application.

## Project Overview
This project includes:

A Custom Resource Definition (CRD) for FastAPIDeployment.
A Python-based Operator that uses kopf (Kubernetes Operator Framework for Python) to manage FastAPI applications.
A deployment YAML for deploying the Operator to your K3s cluster.

## How to run
This project was developed using K3s
```
sudo k3s kubectl get pods
sudo k3s kubectl apply -f clusterrole.yaml
sudo k3s kubectl apply -f clusterrolebinding.yaml
sudo k3s kubectl apply -f fastapi_crd.yaml
sudo k3s kubectl apply -f deployment.yaml
```

# Terraform
AWS Terraform script basic server and agent
```
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```