FROM maven:3.8.5-jdk-11-slim
WORKDIR /app
COPY pom.xml /app/
COPY src /app/src
RUN mvn -e -B package
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "target/hello-world-spring-boot-pom-0.0.1-SNAPSHOT.jar"]
