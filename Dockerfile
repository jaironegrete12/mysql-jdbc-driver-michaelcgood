FROM maven:3.5.2-jdk-8 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package -DskipTests

FROM openjdk:8-jre
COPY --from=build /usr/src/app/target/mysql-jdbc-0.0.1-SNAPSHOT.jar /usr/app/mysql-jdbc-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app/mysql-jdbc-0.0.1-SNAPSHOT.jar"]