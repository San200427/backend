# Use OpenJDK base image
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy Maven wrapper and set permissions
COPY mvnw .
RUN chmod +x mvnw                # 🔧 THIS FIXES THE ISSUE

COPY .mvn .mvn
COPY pom.xml .

# Download dependencies
RUN ./mvnw dependency:go-offline

# Copy rest of the project
COPY src ./src

# Build the JAR
RUN ./mvnw clean package -DskipTests

# Run the built app
CMD ["java", "-jar", "target/demo-0.0.1-SNAPSHOT.jar"]
