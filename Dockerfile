FROM eclipse-temurin:11
COPY build/libs/calculator-cicd-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]