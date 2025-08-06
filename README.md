# ment-notification

Backend responsável por

## Pré-requisitos

Instalar:

- JDK amazoncorretto: 17-alpine-jdk
- Maven

## Inicializar o projeto

**Clone project**

```sh
REPO
```

**Executar este comandos abaixo na pasta raiz do projeto**

```sh
Na pasta onde está localizado o arquivo pom.xml, executar:
mvn clean install
mvn docker:build

Na pasta onde está localizado o arquivo docker-compose.yml, executar:
docker-compose up (inicia todos os containers declarados no docker-compose)
docker-compose up -d <name of container>  (inicia container especifico declarado no docker-compose)
```

#### Configuração de IDE (Eclipse e IntelliJ)

Essa configuração evita conflitos de formatação de código.

##### 1. Eclipse

Abra um terminal na raíz projeto e execute:

```
mvn eclipse:clean eclipse:eclipse
```

Esse comando criará um projeto já com perfil de code formatter configurado.

- Accessar Window > Preferences > Java > Editor > Save Actions
    - Habilitar "Perform the selected actions on save"
    - Habilitar "Format source code"
    - Habilitar "Format all lines"

##### 2. IntelliJ

- Instalar plugins:
    - Eclipse Code Formatter: https://plugins.jetbrains.com/plugin/6546-eclipse-code-formatter
    - Save Actions: https://plugins.jetbrains.com/plugin/7642-save-actions
- Configurar plugin Eclipse Code Formatter ( File > Settings > Other Settings > Eclipse Code Formatter) conforme
  instruções: https://github.com/krasa/EclipseCodeFormatter#instructions. O arquivo xml com as configurações de
  formatação está em /etc/intellij/formatter.xml
- Configurar plugin Save Actions ( File > Settings > Other Settings > Save Actions)
    - Habilitar "Activate save actions on save"
    - Habilitar "Optimize imports"
    - Habilitar "Reformat file"

**Testes Unitários**

- Abra a raiz do projeto e execute os testes com o comando:

```sh
mvn test
```

**Relatório de Cobertura de testes**

O relatório de cobertura é gerado pelo Jacoco. Para extraí-lo basta:

- Executar os testes com o comando:

```sh
mvn test
```

- Abrir o arquivo index.html em {project}/target/site/jacoco/

**Documentação das APIs**

A documentação desse projeto é mantida via Swagger e pode ser consultada no Portal de Desenvolvedores Porto
Bank: https://portal-portofinance.sensedia.com/api-portal/swagger.
