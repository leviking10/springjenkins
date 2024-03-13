pipeline {
    agent any // Indique que la pipeline peut s'exécuter sur n'importe quel agent disponible dans Jenkins

    tools {
        maven 'Maven'
        jdk '8'
    }

    stages {
        stage('Build') { // Étape de construction du projet
            steps {
                sh 'mvn clean package' // Exécute Maven pour nettoyer puis construire le paquet
            }
        }

        stage('Test') { // Étape de test du projet
            steps {
                sh 'mvn test' // Exécute les tests avec Maven
            }
            post {
                failure { // Actions à effectuer si les tests échouent
                    echo 'Les tests ont échoué.'
                }
            }
        }

        stage('Deploy') { // Étape de déploiement de l'application
            steps {
                echo 'Déploiement de l\'application' // Placeholder pour vos commandes de déploiement
                // Par exemple : sh 'script-de-deploiement.sh'
            }
        }
    }

    post {
        always {
            cleanWs() // Nettoie l'espace de travail après la construction
        }
    }
}
