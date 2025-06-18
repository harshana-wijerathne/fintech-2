# Stage 1: Build the WAR using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set work directory
WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build WAR file
RUN mvn clean package -DskipTests

# Stage 2: Run the app using Tomcat
FROM tomcat:10.1-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from build stage
COPY --from=build /app/target/fintech-1.0.0.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
