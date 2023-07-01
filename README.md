# Moringa Argo Playground
Learning at Moringa

## Intro
Using this repo, you will be able to learn the basics of setting up argo locally and deploying your first code. Some of what is covered includes:
        i. K8s basics
        ii. Building docker images using github actions and pushing them to dockerhub
        iii. Tweak the web app and see the changes get deployed

What is not covered:
        i. SSL configurations
        ii. Ingress controllers
        iii. Helm

All this can be configured and added to this repo. I may do that for future classes. But if you can, happy to see your contribution.

## Prerequisites

1. Minikube
2. Git
3. Docker Hub account
4. Docker Desktop
### Commands


# Part A - K8s
1. Start minikube

        minikube start
- Check minikube status

        minikube status
    It should be running

2. Make directory called Moringa, change into the directory and clone the repo provided:

        mkdir Moringa && cd Moringa && git clone https://github.com/CharlesGM/Moringa-Argo.git

3. Create argocd namespace and Install argo-cd 

        kubectl create namespace argocd
        kubectl -n argocd create -f argo.yaml

Wait for the pods to all be in running state. Run the command below to follow:

        kubectl get pods --watch -n argocd

4. Obtain argocd admin login password:

        kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

5. Port-forward your argocd server so that you can access it from your browser:

        Kubectl -n argocd get pods
        kubectl -n argocd port-forward argocd-server-xxxxxxxx 8080

# PART B

There is github action workflows that is already included in this repo (.github/workflows/github_actions.yaml). You will need to set your Docker Hub username and access token as secrets in your GitHub repository settings. Go to your repository on GitHub, click on Settings > Secrets > New repository secret, and add the following secrets:

        i.  DOCKERHUB_USERNAME: Your Docker Hub username.
        ii. DOCKERHUB_TOKEN: Your Docker Hub access token. You can create an access token by logging into Docker Hub, going to Account Settings > Security, and creating a new access token.

Henceforth, every time you push code to the main or master branch (or whichever branch you specify), this GitHub Action will automatically build a Docker image and push it to Docker Hub.

# PART C

So far, your CI/CD should work well. Consult ArgoCD documentations for deploying the app.

Lastly, as of now, to change the color of the web app, you need to edit *the color name* in index.html, K8s/deployment.yaml and github_actions.yaml section of color. This will do the following:
        i. Index.html edits the app color itself
        ii. github_actions.yaml - editing this file creates a tag of the new color and pushes the image to docker hub with the new color as tag
        iii. K8s/deployment.yaml - editing this file with the new color will enable ArgoCD to pull the image with the same tag and deploy it to cluster.

However, the above steps are manual and can be automated. More edits coming to rectify this. But for now, to see changes as you build new images, you must follow the steps above.

## Assignment
What's not described here: Creating an app on argocd
Why: ArgoCD documentation will help here. That's an assignement for now :-)
