pipeline {
    agent any

    environment {
        ACR_NAME = 'dotnetacr-rudram123'
        AZURE_CREDENTIALS_ID = 'azure-service-principal'
        ACR_LOGIN_SERVER = "${ACR_NAME}.azurecr.io"
        IMAGE_NAME = 'myapiapp'
        IMAGE_TAG = 'latest'
        RESOURCE_GROUP = 'dotnet-rg'
        AKS_CLUSTER = 'dotnet-aks'
        TF_WORKING_DIR = 'terraform'
        TERRAFORM_PATH = 'E:/Download Brave/terraform_1.11.3_windows_386/terraform.exe'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mishra-rd015/DotNet-Docker-Jenkins.git'
            }
        }

        stage('Build .NET App') {
            steps {
                bat 'dotnet publish DockerJenkinsDotnetProject/DockerJenkinsDotnetProject.csproj -c Release -o out'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${ACR_LOGIN_SERVER}/${IMAGE_NAME}:${IMAGE_TAG} -f DockerJenkinsDotnetProject/Dockerfile DockerJenkinsDotnetProject"
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                    bat """
                    cd ${TF_WORKING_DIR}
                    ${TERRAFORM_PATH} init
                    """
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                    bat """
                    cd ${TF_WORKING_DIR}
                    ${TERRAFORM_PATH} plan -out=tfplan
                    """
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                    bat """
                    cd ${TF_WORKING_DIR}
                    ${TERRAFORM_PATH} apply -auto-approve tfplan
                    """
                }
            }
        }

        stage('Login to ACR') {
            steps {
                bat "az acr login --name ${ACR_NAME}"
            }
        }

        stage('Push Docker Image to ACR') {
            steps {
                bat "docker push ${ACR_LOGIN_SERVER}/${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Get AKS Credentials') {
            steps {
                bat "az aks get-credentials --resource-group ${RESOURCE_GROUP} --name ${AKS_CLUSTER} --overwrite-existing"
            }
        }

        stage('Deploy to AKS') {
            steps {
                bat "kubectl apply -f DockerJenkinsDotnetProject/deployment.yaml"
            }
        }
    }

    post {
        success {
            echo 'All stages completed successfully!'
        }
        failure {
            echo 'Build failed.'
        }
    }
}
