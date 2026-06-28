pipeline {
    agent any

    environment {
        ACR_NAME = 'fullstackforgeacr'
        IMAGE_NAME = 'fullstackforgeacr.azurecr.io/fullstack-forge'
        IMAGE_TAG = "v${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/neravr/fullstack-forge.git'
            }
        }

        stage('Ansible - Verify Environment') {
            steps {
                sh 'ansible-playbook ansible/configure-jenkins.yml'
            }
        }

        stage('Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Push to ACR') {
            steps {
                sh "az acr login --name ${ACR_NAME}"
                sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Ansible - Configure AKS Nodes') {
            steps {
                sh 'ansible-playbook ansible/configure-aks-nodes.yml'
            }
        }

        stage('Deploy to AKS') {
            steps {
                sh "kubectl set image deployment/fullstack-forge fullstack-forge=${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }
}