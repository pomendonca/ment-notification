# Usando Amazon Corretto 17 (OpenJDK 17)
FROM amazoncorretto:17-alpine-jdk

# Adiciona curl (necessário apenas para instalar Maven)
RUN apk add --no-cache curl

# Configura versão e diretório do Maven
ARG MAVEN_VERSION=3.8.3
ARG SHA=1c12a5df43421795054874fd54bb8b37d242949133b5bf6052a063a13a93f13a20e6e9dae2b3d85b9c7034ec977bbc2b6e7f66832182b9c863711d78bfe60faa
ARG MAVEN_HOME_DIR=usr/share/maven
ARG APP_DIR="app"

# Diretório Maven e download
ARG BASE_URL=https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries
RUN mkdir -p /$MAVEN_HOME_DIR /$MAVEN_HOME_DIR/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /$MAVEN_HOME_DIR --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /$MAVEN_HOME_DIR/bin/mvn /usr/bin/mvn

# Configura Maven e app
ENV MAVEN_CONFIG "/${APP_DIR}/.m2"
ENV APP_NAME ment-notification

# Copia código fonte e POM
COPY ./src ./$APP_DIR/src
COPY pom.xml ./$APP_DIR

WORKDIR /$APP_DIR

# Build do JAR
RUN mvn clean package

# Copia JAR para diretório de trabalho
RUN cp target/$APP_NAME.jar .

# Limpeza: remove fonte, POM, Maven e cache
RUN rm -rf src pom.xml target /$MAVEN_HOME_DIR $MAVEN_CONFIG \
    && apk del curl

VOLUME $APP_DIR/tmp
EXPOSE 8081

ENTRYPOINT ["java", "-jar", "ment-notification.jar", "-Djava.security.egd=file:/dev/./urandom"]
