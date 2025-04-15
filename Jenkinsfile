pipeline {
    agent any

    environment {
        ACR_NAME = 'dotnetacr-rudram123'
        RESOURCE_GROUP = 'dotnet-rg'
        CLUSTER_NAME = 'dotnet-aks'
        IMAGE_NAME = 'myapiapp'
        TERRAFORM_PATH = '"E:\\Download Brave\\terraform_1.11.3_windows_386\\terraform.exe"'
    }

    stages {
        stage('Terraform Deploy') {
            steps {
                dir('terraform') {
                    bat "${env.TERRAFORM_PATH} init"
                    bat "${env.TERRAFORM_PATH} apply -auto-approve"
                }
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                bat """
                    az acr login --name %ACR_NAME%
                    docker build -t %ACR_NAME%.azurecr.io/%IMAGE_NAME%:latest ./MyApiApp
                    docker push %ACR_NAME%.azurecr.io/%IMAGE_NAME%:latest
                """
            }
        }

        stage('Deploy to AKS') {
            steps {
                bat """
                    az aks get-credentials --resource-group %RESOURCE_GROUP% --name %CLUSTER_NAME%
                    kubectl apply -f k8s\\deployment.yaml
                """
            }
        }
    }
}
