# Etapa 1: compila a aplicação web usando Java 17 e Maven.
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copia primeiro o descritor para aproveitar o cache das dependências.
COPY pom.xml .
RUN mvn -B dependency:go-offline

COPY src ./src
RUN mvn -B clean package -DskipTests

# Etapa 2: executa o WAR no Tomcat 9 (compatível com javax.servlet 4.0).
FROM tomcat:9.0-jdk17-temurin
COPY --from=build /app/target/loja-web-sessao.war /usr/local/tomcat/webapps/loja-web-sessao.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
