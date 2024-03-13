pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK 8'
    }

    environment {
        // Nom de l'utilisateur Docker Hub et mot de passe (à stocker dans Jenkins Credentials)
        DOCKERHUB_CREDENTIELS = credentials('dockerhub-credentials')
        // Nom de l'image Docker à construire et pousser
        DOCKER_IMAGE = 'mleviking/springjenkins'
        // Le tag de l'image Docker, typiquement le numéro de build Jenkins
        DOCKER_TAG = "${env.BUILD_NUMBER}"
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

        stage('Build Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', DOCKERHUB_CREDENTIELS) {
                        sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    }
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('', DOCKERHUB_CREDENTIELS) {
                        sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout'
            cleanWs() // Nettoyer l'espace de travail après la construction
        }
    }
}
