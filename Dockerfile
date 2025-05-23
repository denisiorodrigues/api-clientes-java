# Etapa 1: Build da aplicação
FROM maven:3.9.6-eclipse-temurin-11-alpine AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Etapa 2: Imagem final, apenas com o JAR
FROM eclipse-temurin:11-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]