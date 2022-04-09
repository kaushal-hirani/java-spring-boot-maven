FROM maven:3.8.1-openjdk-11-slim
WORKDIR /app
COPY pom.xml .
RUN mvn -e -B dependency:resolve
COPY src ./app/src
RUN mvn clean -e -B package
EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "/app/target/hello-world-spring-boot-pom-0.0.1-SNAPSHOT.jar" ]