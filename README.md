

# Pathways Dojo Weather App 

This repository is used in conjunction with the Contino Infra Engineer to Cloud Engineer Pathway course delivered in Contini-U. 

The original repo included and supports the following functionality:
* Dockerfile and docker-compose configuration for 3M based deployments
* Makefile providing basic Terraform deployment functionality using the 3 Musketeers deployment method
* GitHub workflows for supporting basic Terraform deploy and destroy functionality 
* Terraform IaC for the test deployment of an s3 bucket
* Node Weather App - https://github.com/phattp/nodejs-weather-app

The solution has been updated with the following functionality:
* Github workflows to build and push the Node Weather App to Amazon ECR
* Deployment of VPC and network constructs, and the required components to run the container on ECS
* Configuration of Go Daddy DNS to configure a CNAME for beardedsamwise.co

The application is now fully deployed and available at: [www.beardedsamwise.co](http://www.beardedsamwise.co)

<br> 

## Architecture

The high level architecture of the solution is as follows. The ALB and ECS instances each have a different security group attached allowing HTTP inbound to the ALB from anywhere, and TCP 3000 from the ALB. For more information refer to [sg.tf](/infrastructure/modules/fargate-env/sg.tf).

![Network Diagram](/images/weather_app_diagram.png)

## Working locally with Terraform

The provided `makefile`, `dockerfile` , and `docker-compose.yml` files in the `Infrastructure` directory work together to create a docker container which is used to run Terraform deployments and other supported commands. It expects AWS account credentials and Go Daddy API credentials (`GODADDY_KEY` and `GODADDY_SECRET`) to be passed as environment variables. 

To run a simple aws command, ensure you have set your aws temporary credentials in your local environment and run the following. 

```
make list_bucket
```

Deploying Terraform environment locally - creates tfplan file during plan as input to apply. Apply is auto-approved.

```
make run_plan
make run_apply
```

Destroying Terraform environment locally. Destroy plan is speculative. Destroy apply is auto-approved.

```
make run_destroy_plan
make run_destroy_apply
```
Terraform `init`, `validate` and `fmt` are run for each of the `make` commands above.

<br> 

## Working locally with the application

A similar approach is used as with Terraform. 

The provided `makefile` in the `Application` directory is used to login in to EKS, as well as build and push Docker images. The `makefile` expects three environment variables are configured locally. 

`ACCOUNTID` - Your AWS account ID
`AWSREGION` - The region the Elastic Container Registry (ECR) is deployed to
`REPONAME`  - The name of the Elastic Container Registry (ECR) repo

To log in to EKS execute `make login`.

To build the supplied Dockerfile execute `make build`.

To push the built image to ECR execute `make push`. 

To test the image locally before pushing to ECR you can run the Docker image using `docker run -p 127.0.0.1:3000:3000/tcp weatherapp:1` where `weatherapp:1` is the `name:tag` of your Docker image. 

<br> 

## 3 Musketeers

For more information on 3 Musketeers deployment method, visit the official site here. https://3musketeers.io/

<br> 


