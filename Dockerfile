FROM openjdk:17-alpine as build

WORKDIR /build

COPY pom.xml .
COPY mvnw .
COPY .mvn/ ./.mvn/

RUN ls

RUN /build/mvnw dependency:go-offline

COPY . .

RUN /build/mvnw package

FROM openjdk:17-alpine

WORKDIR /app

COPY --from=build /build/target/*.jar app.jar

CMD ["java", "-jar", "/app/app.jar"]