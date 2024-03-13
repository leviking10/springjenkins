pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK 8'
    }

    environment {
        // Nom de l'image Docker à construire et pousser
        DOCKER_IMAGE = 'mleviking/springjenkins'
        // Le tag de l'image Docker, typiquement le numéro de build Jenkins
        DOCKER_TAG = "${env.BUILD_NUMBER}"
        // Le port que l'application utilise
        APP_PORT = 8080
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                failure {
                    echo 'Les tests ont échoué.'
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Générer un timestamp pour taguer l'image
                    def timestamp = new Date().format("yyyyMMddHHmmss", TimeZone.getTimeZone('UTC'))
                    def dockerImage = "${env.DOCKER_HUB_USERNAME}/springjenkins:${timestamp}"
                    // Se connecter à Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                        sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
                        sh "docker build -t ${dockerImage} ."
                        sh "docker push ${dockerImage}"
                    }
                }
            }
        }
    post {
        always {
            cleanWs() // Nettoyer l'espace de travail après la construction
        }
    }
}
