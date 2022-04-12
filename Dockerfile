FROM maven:3.8.5-jdk-11
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -e -B package
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/target/hello-world-spring-boot-pom-0.0.1-SNAPSHOT.jar"]