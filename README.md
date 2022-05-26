# GoViolin- Infra

GoViolin is a web app written in Go that helps with violin practice.
This repo contains the most important infra files needed to deploy this web app

## Pre-Requisites
To run the docker file locally: 

First build the image
```sh 
 docker build -t $IMAGE_NAME:$IAMGE_TAG .
 ```

Run the container 
```sh
 docker run -p 5000:8080 $IMAGE_NAME:$IAMGE_TAG
```
To run k8s or helm you should have minikube installed


## Dockerfile
- using multi-stage dockerfile to build small image size (around 225mb)
- based on alpine (less vulnerabilities)


## Jenkins PipeLine
Steps:
- [✓] Run tests
- [✓] Build Image
- [✓] Push to docker Hub 
- [✓] Report to console and email

## Terraform
- Terraform scripts to build the infrastructure needed to run the image and jenkins

## Helm Chart
- For easily managing K8s files 
```sh
helm install $RELEASE_NAME ./goviolin-chart
```
