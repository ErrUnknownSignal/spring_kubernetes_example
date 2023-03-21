FROM docker.io/openjdk:17-jdk-slim-buster
WORKDIR /usr/src/app
COPY build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/src/app/app.jar"]