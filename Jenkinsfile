#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "eu-west-3"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    sh 'mkdir -p terraform2'
                    sh 'mkdir -p /var/lib/jenkins/workspace/terraform2'
                    sh 'cp -r backend.tf eks.tf /var/lib/jenkins/workspace/terraform2/'
                    dir('/var/lib/jenkins/workspace/terraform2') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws eks update-kubeconfig --name my-eks-cluster"
                        sh "kubectl apply -f nginx-deployment.yaml"
                        sh "kubectl apply -f nginx-service.yaml"
                    }
                }
            }
        }
    }
}
