FROM maven:3.9.6-eclipse-temurin-11 as dep-stage
WORKDIR /app
COPY pom.xml .
#COPY src scripts WebContent setup .
#COPY . .
RUN mvn dependency:resolve-plugins

FROM dep-stage as build
WORKDIR /app
COPY . .
RUN mvn package -DskipTests

FROM tomcat:9.0.85-jdk21-temurin-jammy
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/shopping-cart.war
EXPOSE 8080
