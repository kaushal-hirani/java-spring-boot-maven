FROM maven:3.8.5-jdk-11-slim
COPY pom.xml .
COPY src ./src
COPY mvnw .
COPY mvnw.cmd .
RUN mvn -e -B package
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "target/hello-world-spring-boot-pom-0.0.1-SNAPSHOT.jar"]
