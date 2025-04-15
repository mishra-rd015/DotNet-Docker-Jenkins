pipeline {
    agent any

    environment {
        ACR_NAME = 'dotnetacr123'
        RESOURCE_GROUP = 'dotnet-rg'
        CLUSTER_NAME = 'dotnet-aks'
        IMAGE_NAME = 'myapiapp'
    }

    stages {
        stage('Terraform Deploy') {
            steps {
                dir('terraform') {
                    bat 'terraform init'
                    bat 'terraform apply -auto-approve'
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
