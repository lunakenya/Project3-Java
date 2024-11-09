# Use a Maven base image with JDK 17 to build the application
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven configuration file to the container
COPY pom.xml .

# Download project dependencies (this will be cached in the container layer)
RUN mvn dependency:go-offline -B

# Copy the rest of the application files
COPY . .

# Build the application, skipping tests
RUN mvn clean package -DskipTests

# Second stage: use a lightweight JDK image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory in the final container
WORKDIR /app

# Copy the generated JAR file from the build stage
COPY --from=build /app/target/proyecto2-0.0.1-SNAPSHOT.jar app.jar

# Expose the port on which Spring Boot will listen
EXPOSE 8083

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
