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

    }

    post {
        always {
            cleanWs() // Nettoyer l'espace de travail après la construction
        }
    }
}
