FROM gradle:7.6.1-jdk17 AS gradle
WORKDIR /usr/app/

COPY . .

RUN gradle bootJar -x test


FROM docker.io/openjdk:17-jdk-slim-bullseye
ENV TZ Asia/Seoul
WORKDIR /usr/src/app

COPY --from=gradle /usr/app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/src/app/app.jar"]
