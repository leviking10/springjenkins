# Utiliser une image de base officielle Java avec JDK 17
FROM openjdk:8

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier exécutable .jar dans le répertoire de travail du conteneur
COPY target/springjenkins.jar /app/springjenkins.jar

# Exposer le port sur lequel votre application écoute, adapté selon votre application.yml
EXPOSE 8080

# Exécuter l'application
CMD ["java", "-jar", "/app/springjenkins.jar"]
