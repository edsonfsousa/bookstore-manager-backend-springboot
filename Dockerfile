#
# Build stage
#
FROM maven:3.8.3-jdk-17-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -Dmaven.repo.local=/.m2 -f /home/app/pom.xml clean package

FROM openjdk:17-jre
COPY --from=build /home/app/target/superare-0.0.1-SNAPSHOT.jar /run.jar

ENV SERVER_PORT="8081"
ENV DATA_SOURCE_URL="jdbc:postgresql://localhost:5432/superareDB"
ENV DATA_SOURCE_USERNAME="postgres"
ENV DATA_SOURCE_PASSWORD="qwe123*"
# RUN apk add --no-cache tzdata
ENV TZ America/Fortaleza


WORKDIR /

ENTRYPOINT ["java","-jar", "run.jar"]