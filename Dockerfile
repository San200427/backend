# Use OpenJDK base image
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy Maven wrapper & pom.xml first (to use cache)
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Download dependencies (helps with Docker caching)
RUN ./mvnw dependency:go-offline

# Copy the rest of the source code
COPY src ./src

# Build the Spring Boot app
RUN ./mvnw clean package -DskipTests

# Run the built JAR
CMD ["java", "-jar", "target/demo-0.0.1-SNAPSHOT.jar"]
