FROM adoptopenjdk/openjdk8:alpine-slim AS overlay

RUN mkdir -p cas-mgmt-overlay

COPY ./maven cas-mgmt-overlay/maven/
COPY ./pom.xml ./mvnw cas-mgmt-overlay/

RUN cd cas-mgmt-overlay \
    && ./mvnw clean package -T 5

FROM adoptopenjdk/openjdk8:alpine-jre AS cas

RUN cd / \
    && mkdir -p /etc/cas/config \
    && mkdir -p cas-mgmt-overlay;

COPY --from=overlay cas-mgmt-overlay/target/cas-management.war cas-mgmt-overlay/

EXPOSE 8080

ENV PATH $PATH:$JAVA_HOME/bin:.

WORKDIR cas-mgmt-overlay

ENTRYPOINT ["java", "-server", "-noverify", "-Xmx2048M", "-jar", "cas-management.war"]