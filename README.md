# Multiply the Power of Argo Projects By Using Them Together

![argo](https://raw.githubusercontent.com/argoproj/argoproj/master/docs/assets/argo.png)


Argoproj is a set of loosely coupled tools that aims to unleash to power of Kubernetes:

* Argo Workflows - container-native workflow engine for orchestrating parallel jobs on Kubernetes.
* Argo Events - The event-driven workflow automation framework
* Argo CD - Declarative continuous delivery for Kubernetes
* Argo Rollouts - Progressive delivery for Kubernetes

Each Argo sub-project is focused on a separate use-case and can be used independently. But together, Argo projects
complement each other and form a **powerful application delivery platform**.

## Demo

This repository demonstrates how Argo allows gluing disconnected open-source projects into a complex system that
solves real-world use cases, with zero code written.

We are going to build a web application consisting of multiple microservices as well as a background batch processing
system that leverages machine learning. The application allows users to upload an image, stores the photo in an
S3 compatible storage and produces a new image with highlighted faces on it using a pre-trained ML model.

![image](https://user-images.githubusercontent.com/426437/96329261-e9e35900-0fff-11eb-9da1-ee1bb29b761f.png)

## Components

Instead of building an application from scratch, we are going to leverage existing open-source projects and
the Argo projects to make them work together for profit:

![image](https://user-images.githubusercontent.com/426437/96401561-8f293900-1188-11eb-9b3d-a8ff3b714a2d.png)

* [minio](https://github.com/minio/minio) - Kubernetes native S3 compatible storage. Minio is going to store
user uploaded images and ML workflows outputs.
* [filestash](https://www.filestash.app/) - A modern web client for the storage of your choice. Filestash
allows user to upload an image and view processing results.
* [facedetect](https://www.thregr.org/~wavexx/software/facedetect/) - a simple face detector for batch processing.
The facedetect encapsulates the magic and produces an image with detected faces.
* [argo-workflows](https://github.com/argoproj/argo) - workflow engine for Kubernetes. Argo Workflows orchestrates
steps requires to access uploaded image, process the image and store processing results.
* [argo-events](https://github.com/argoproj/argo-events) - event-driven automation framework for Kubernetes.
Argo Events are watching for new images in the S3 storage and triggers the batch processing workflow.
* [argo-cd](https://github.com/argoproj/argo-cd) - GitOps continuous delivery tool for Kubernetes. Argo CD
manages components listed above it the Kubernetes cluster and encapsulates both day one and day two operations.


## Let's do it

1. First of all we need a Kubernetes cluster. Nothing fancy is required here. Use your GKE, EKS cluster or just run
[minikube](https://github.com/kubernetes/minikube) cluster on your laptop.
2. Install Argo CD. Follow the getting started instructions in Argo CD [documentation](https://argoproj.github.io/argo-cd/getting_started/).
> TLDR:
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
3. Deploy the demo scenario using Argo CD, which in turn will spawn all required components in your K8s cluster:

```
kubectl apply -f https://raw.githubusercontent.com/alexmt/kubecon-2020-demo/master/demo.yaml -n argocd
```
4. Check the components' status in Argo CD user interface.

![image](https://user-images.githubusercontent.com/426437/96329250-d46e2f00-0fff-11eb-812d-67d3cf01a801.png)


## Try it

1. Navigate to [filestash](https://www.filestash.app/) and upload an image using upload button. Note: image file must have ".jpg" extension.
2. Use [argo workflows](https://github.com/argoproj/argo) user interface to observe background processing process.
![image](https://user-images.githubusercontent.com/426437/96329233-bdc7d800-0fff-11eb-88ad-d3bb0f395b8d.png)
3. See image processing results in [filestash](https://www.filestash.app/) interface.
![image](https://user-images.githubusercontent.com/426437/96329959-7abd3300-1006-11eb-9c87-8e726d6d710a.png)


## What to know more?

See the live demo at Kubecon!

https://kccncna20.sched.com/event/ekGL/gitops-cd-and-workflows-with-argo-hong-wang-alexander-matyushentsev-intuit

![image](https://user-images.githubusercontent.com/426437/96330025-02a33d00-1007-11eb-8562-3630d5fc5ff5.png)
