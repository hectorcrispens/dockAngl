![docker](img/docker.svg) ![texto](img/texto.svg)



# Docker Image for Angular

Una imagen para el desarrollo de aplicaciones Angular con Docker

[![docker](https://img.shields.io/badge/Docker-19.03.8-informational?style=plastic&logo=docker)](https://www.docker.com/) [![node](https://img.shields.io/badge/Node-14.17.3:Slim-success?style=plastic&logo=node.js)](https://nodejs.org/es/) [![npm](https://img.shields.io/badge/npm-6.14.13-cb3837?style=plastic&logo=npm)](https://www.npmjs.com/)  [![angular](https://img.shields.io/badge/Angular/cli-12.1.4-cb3837?style=plastic&logo=AngularJS)](https://angular.io/cli)



## Contributors

[![hector](img/avatar-hector.svg)](https://www.linkedin.com/in/hector-orlando-25124a18a/)  [![sergio](img/avatar-sergio.svg)](https://www.linkedin.com/in/sergio-ridaura/)

 

Version 12.1.4 dockAngl



## Tabla de contenido

- [Docker Image for Angular](#docker-image-for-angular)
  - [Descripción](#descripción)
  - [Contenido de esta imagen](#contenido-de-esta-imagen)
  - [Comandos disposibles de angular/cli](#comandos-disposibles-de-angularcli)
  - [Como usar esta imagen](#como-usar-esta-imagen)
  - [Ejemplos de como crear el contenedor](#ejemplos-de-como-crear-el-contenedor)
  - [Links de interes](#links-de-interes)
  - [Licencia](#licencia)
    - [GNU General Public License](#gnu-general-public-license)

------




## Descripción

Esta imagen esta destinada a trabajos con el framework de javascript, **Angular** y esta optimizada para trabajar con la versión v12.2.0. Ya que fue construida a partir de node v14.17.3 Slim es perfectamente compatible con dicha versión. Por otro lado al usar la base slim su reducido tamaño hace que sea fácil de manejar.

Angular es un framework de javascript que incluye css y html, con el cual se permiten construir aplicaciones para el front-end cuya principal filosofia es la del trabajo basado en componentes, lo cual permite que las aplicaciones puedan escalar de forma oganizada.

Una de las principales características para el desarrollo con **Angular** es la herramienta de linea de comando **angular/cli**.

La herramienta de linea de comando **angular/cli** permite muchas cosas, desde incorporar librerias externas, crear componentes, servicios, etc. 

------



## Contenido de esta imagen

**node:** 14.17.3 Slim

**npm: **6.14.13

**angular/cli:** 12.1.4

------



## Comandos disposibles de angular/cli

  **add** Adds support for an external library to your project.
  **analytics** Configures the gathering of Angular CLI usage metrics. See https://angular.io/cli/usage-analytics-gathering.
  **build** (b) Compiles an Angular app into an output directory named dist/ at the given output path. Must be executed from within a workspace directory.
  **deploy** Invokes the deploy builder for a specified project or for the default project in the workspace.
  **config** Retrieves or sets Angular configuration values in the angular.json file for the workspace.
  **doc** (d) Opens the official Angular documentation (angular.io) in a browser, and searches for a given keyword.
  **e2e** (e) Builds and serves an Angular app, then runs end-to-end tests.
  **extract-i18n** (i18n-extract, xi18n) Extracts i18n messages from source code.
  **generate** (g) Generates and/or modifies files based on a schematic.
  **help** Lists available commands and their short descriptions.
  **lint** (l) Runs linting tools on Angular app code in a given project folder.
  **new** (n) Creates a new workspace and an initial Angular application.
  **run** Runs an Architect target with an optional custom builder configuration defined in your project.
  **serve** (s) Builds and serves your app, rebuilding on file changes.
  **test** (t) Runs unit tests in a project.
  **update** Updates your application and its dependencies. See https://update.angular.io/
  **version** (v) Outputs Angular CLI version.

------



## Como usar esta imagen

Descargue esta imagen ejecutando:

```bash
docker pull hectorcrispens/angl-cli
```

La sintaxis para desplegar un contenedor de docker a partir de una imagen es la siguiente:

```bash
$ docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]
```

Una vez descargada la imagen ya puede construir un contenedor utilizado el siguiente comando:

```bash
docker run -i -d --mount type=bind,source=<source>,target=/angl -p <port>:4200 --name "<name>" angl-cli /bin/bash -c "<command>";
```

A continuación vamos a detallar cada una de las opciones y parametros que incluyen el comando anterior.

-i, --interactive : Especifica que durante la implementacion y arranque del contenedor, el mismo logueará en la pantalla cada una de las acciones que se lleven a cabo

-d : Esta opción (detached) permite que una vez creado el contenedor la consola de comandos se libere mientras el contenedor se sigue ejecutando de fondo.

--mount type=bind,source=<source>,target=/angl : Una de las caracteristicas de los contenedores es que permiten mapear carpetas del sistema operativo anfitrion adentro de los contenedores. En este caso el *WORKDIR* del contenedor es la carpeta **/angl**, por tanto la parte del **target=/angl** no la deberia tocar. En cambio el <source> deberia hacer referencia a la carpeta local donde se haya su proyecto de angular con el cual espera trabajar. **type=bind** indica a docker que el flujo de datos será bidireccional desde la carpeta mapeada al contenedor y visceversa desde el contenedor hacia la carpeta local.

-p <port>:4200 :  El puerto interno del contenedor será el 4200 que es el puerto por defecto donde levantará la aplicación de angular. No obstante al igual que las carpetas los puertos también pueden ser mapeados por lo que debe especificar el puerto externo en el cual estará respondiendo el contenedor.

--name "<name>" : Puede especificar un nombre para el contenedor, esto es opcional ya que si no asigna un nombre docker automaticamente asignará uno de forma aleatoria. Es importante al momento de conectarse a un contenedor conocer su nombre.

/bin/bash -c "<command>" : Esta imagen no provee un servicio que se ejecute de manera permanente, por lo tanto el <command> debe permitir que un servicio se ejecute de forma permanente, y ese comando será *ng serve --host 0.0.0.0;*  

> Aclaraciones:
>
> Existen dos formas de trabajar con este contenedor. La primera es que ya posea un proyecto de angular el cual indicará su ubicación en <source> y la segunda es que al momento de construir el contenedor se cree dicha estructura del proyecto. En ambos casos esto afectará las especificaciones del <command> indicando si creará un nuevo proyecto o si ya lo tiene.

------



## Ejemplos de como crear el contenedor

A continuación se muestra como crear un contenedor para esta imagen. Vamos a tomar como ejemplo que la carpeta local con la cual vamos a trabajar será la carpeta */home/* y que el puerto en el cual vamos a interactuar con la aplicación sera el *4200* por lo cual vamos a poder visualizar la misma abriendo un navegador web y colocando la siguiente url: [http://localhost:4200](http://localhost:4200).

Para el caso que ya cuente con un proyecto de angular en */home* el comando completo sería:

```bash
docker run -i --mount type=bind,source=/home,target=/angl -p 4200:4200 --name "container_angl" angl /bin/bash -c "npm install && chmod 777 -R * && ng serve --host 0.0.0.0;";

```

 En cambio si el proyecto angular se creará al momento de levantar el contenedor el comando completo será:

```bash
docker run -i -d --mount type=bind,source=/home,target=/angl -p 4200:4200 --name "container_angl" angl /bin/bash -c "ng new angl --directory ./ && chmod 777 -R * && ng serve --host 0.0.0.0;";
```

------



## Links de interes

En Github puede encontrar un proyecto de **Angular** que además incluye bootstrap v5.1.0 como también un conjunto de componentes pre diseñados que le permitirán construir aplicaciones más rápidamente. Puede acceder desde [aquí](https://github.com/hectorcrispens/anglBtrp).

También puede acceder al siguiente [enlace](https://github.com/sergrida/dockMspa), el cual es un proyecto para docker que integra todo el stack completo con mysql, symfony y angular en el front-end y que se integra perfectamente con esta imagen.

------



## Licencia

Copyright (C) 2021.

- Sergio Ridaura,
  - [![linkedin](https://img.shields.io/badge/LinkedIn--0a66c2?style=social&logo=linkedin)](https://www.linkedin.com/in/sergio-ridaura/) [![GitHub](https://img.shields.io/badge/GitHub--0a66c2?style=social&logo=GitHub)](https://github.com/sergrida) [![Correo](https://img.shields.io/badge/Info-info@sergioridaura.com-0a66c2?style=social&logo=Mail.Ru)](mailto:info@sergioridaura.com) [![Site](https://img.shields.io/badge/Site-https://sergioridaura.com-ff7139?style=social&logo=FirefoxBrowser)](https://sergioridaura.com) 
- Héctor Orlando,
  - [![linkedin](https://img.shields.io/badge/LinkedIn--0a66c2?style=social&logo=linkedin)](https://www.linkedin.com/in/hector-orlando-25124a18a/) [![linkedin](https://img.shields.io/badge/GitHub--0a66c2?style=social&logo=GitHub)](https://github.com/hectorcrispens) [![linkedin](https://img.shields.io/badge/Gmail--0a66c2?style=social&logo=Gmail)](mailto:hector.or.cr@gmail.com)



### GNU General Public License

Este programa es software gratuito: puedes redistribuirlo y/o  modificar bajo los términos de la Licencia Pública General GNU tal como  se publicó por la Free Software Foundation, ya sea la versión 3 de la  Licencia, o cualquier versión posterior.

Este programa se distribuye con la esperanza de que sea de utilidad,  pero SIN NINGUNA GARANTÍA; sin siquiera la garantía implícita de  COMERCIABILIDAD o APTITUD PARA UN PROPÓSITO PARTICULAR. Ver el Licencia  pública general GNU para más detalles.

Debería haber recibido una copia de la Licencia Pública General GNU junto con este programa, en LICENSE.md o https://www.gnu.org/licenses/gpl-3.0.html.en.
