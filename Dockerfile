FROM java:8
WORKDIR /
ADD spring-petclinic.jar spring-petclinic.jar
EXPOSE 8000
CMD java -jar spring-petclinic.jar