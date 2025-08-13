# Base Java
FROM amazoncorretto:17-alpine-jdk

# Instala curl
RUN apk add --no-cache curl

# Define versão do Maven
ARG MAVEN_VERSION=3.8.3
ARG SHA=1c12a5df43421795054874fd54bb8b37d242949133b5bf6052a063a13a93f13a20e6e9dae2b3d85b9c7034ec977bbc2b6e7f66832182b9c863711d78bfe60faa
ARG MAVEN_HOME_DIR=/usr/share/maven
ARG APP_DIR=ment-notification

# Download e instalação do Maven
RUN mkdir -p $MAVEN_HOME_DIR /$APP_DIR/.m2 \
  && curl -fsSL -o /tmp/apache-maven.tar.gz https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C $MAVEN_HOME_DIR --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s $MAVEN_HOME_DIR/bin/mvn /usr/bin/mvn

ENV MAVEN_CONFIG="/$APP_DIR/.m2"
ENV APP_NAME=ment-notification

# Copia o código
WORKDIR /$APP_DIR
COPY pom.xml ./
COPY src ./src

# Build do jar
RUN mvn clean package -DskipTests

# Copia o jar gerado para a raiz do WORKDIR
RUN cp target/$APP_NAME.jar .

# Limpeza para imagem menor
RUN rm -rf src pom.xml target $MAVEN_HOME_DIR

EXPOSE 8081
ENTRYPOINT ["java", "-jar", "ment-notification.jar", "-Djava.security.egd=file:/dev/./urandom"]
