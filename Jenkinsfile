#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = "eu-west-1"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    try {
                        dir('terraform') {
                            sh "terraform init"
                            sh "terraform apply -auto-approve"
                        }
                    } catch (Exception e) {
                        error "Terraform apply failed: ${e}"
                    }
                }
            }
        }
        stage("Wait for EKS Cluster to be Ready") {
            steps {
                script {
                    sh "aws eks wait cluster-active --name my-eks-cluster"
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