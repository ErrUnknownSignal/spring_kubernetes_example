FROM docker.io/openjdk:20-ea-17-jdk-slim-bullseye
WORKDIR /usr/src/app
COPY build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/src/app/app.jar"]