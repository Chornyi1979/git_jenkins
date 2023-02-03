FROM openjdk:8-jre-alpine

EXPOSE 8080
COPY ./target/hello-*.jar /usr/app/
WORKDIR /usr/app

CMD java -jar hello-*.jar
