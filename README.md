![docker](img/docker.svg) ![texto](img/texto.svg)



# Docker Image for Angular

Una imagen para el desarrollo de aplicaciones Angular con Docker

[![docker](https://img.shields.io/badge/Docker-19.03.8-informational?style=plastic&logo=docker)](https://www.docker.com/) [![node](https://img.shields.io/badge/Node-14.17.3:Slim-success?style=plastic&logo=node.js)](https://nodejs.org/es/) [![npm](https://img.shields.io/badge/npm-6.14.13-cb3837?style=plastic&logo=npm)](https://www.npmjs.com/)  [![angular](https://img.shields.io/badge/Angular/cli-12.1.4-cb3837?style=plastic&logo=AngularJS)](https://angular.io/cli)



## Contributors

[![hector](img/avatar-hector.svg)](https://www.linkedin.com/in/hector-orlando-25124a18a/)  [![sergio](img/avatar-sergio.svg)](https://www.linkedin.com/in/sergio-ridaura/)

 

Version 13.10.21 dockAngl



## Tabla de contenido

- [Docker Image for Angular](#docker-image-for-angular)
  - [Contributors](#contributors)
  - [Tabla de contenido](#tabla-de-contenido)
  - [Descripción](#descripción)
  - [Contenido de esta imagen](#contenido-de-esta-imagen)
  - [Como usar esta imagen](#como-usar-esta-imagen)
  - [Crear un contenedor](#crear-un-contenedor)
  - [Conectarse al contenedor](#conectarse-al-contenedor)
  - [Usuarios y grupos](#usuarios-y-grupos)
  - [Links de interes](#links-de-interes)
  - [Comandos disposibles de angular/cli](#comandos-disposibles-de-angularcli)
  - [Licencia](#licencia)
    - [GNU General Public License](#gnu-general-public-license)

------




## Descripción

Esta imagen esta destinada a trabajos con el framework de javascript, **Angular** y esta optimizada para trabajar con la versión v12.2.0. Ya que fue construida a partir de node v14.17.3 Slim es perfectamente compatible con dicha versión. Por otro lado al usar la base slim su reducido tamaño hace que sea fácil de manejar.

Esta imagen es muy fácil de usar, ya que esta optimizada e incorpora funcionalidades para que la creación de proyectos en **Angular**. Más abajo se detalla su forma de uso.

Angular es un framework de javascript que incluye css y html, con el cual se permiten construir aplicaciones para el front-end cuya principal filosofia es la del trabajo basado en componentes, lo cual permite que las aplicaciones puedan escalar de forma oganizada.

Una de las principales características para el desarrollo con **Angular** es la herramienta de linea de comando **angular/cli**.

La herramienta de linea de comando **angular/cli** permite muchas cosas, desde incorporar librerias externas, crear componentes, servicios, etc. 

------



## Contenido de esta imagen

**node:** 14.17.3 Slim

**npm:** 6.14.13

**angular/cli:** 12.1.4

------



## Como usar esta imagen

Descargue esta imagen ya creada desde [dockerhub](https://hub.docker.com/r/hectorcrispens/angl-cli) ejecutando:

```bash
docker pull hectorcrispens/angl-cli
```

O si prefiere puede crear la imagen a partir del archivo dockerfile de este repositorio. Para ello primero es necesario clonar el repositorio de git y luego construir la imagen del contenedor a partir del archivo `dockerfile`.

```bash
# Clonado del repositorio
git clone git@github.com:hectorcrispens/dockAngl.git
cd dockAngl

# Construcción de la imagen, tambien puede pasar sus credenciales de git como argumentos 
docker build -t angl --file angl.Dockerfile .
docker build --build-arg NAME=yourName --build-arg EMAIL=yourEmail -t angl -file angl.Dockerfile .

```



## Crear un contenedor 

Una vez que la imagen fue descargada o creada a partir del archivo `dockerfile` podemos visualizarla.

```bash
docker images
REPOSITORY   TAG            IMAGE ID       CREATED        SIZE
angl         latest         229fe95bd75f   23 hours ago   329MB
```

Vemos que hemos construido/descargado una imagen llamada **angl**. La sintaxis para crear un contenedor es como se muestra abajo, sin embago la parte del *COMMAND* y los *ARG* no se utilizan con esta imagen, ya que la misma cuenta con un mecanismo para identificar si hay o no un proyecto de angular.

```bash
docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]
```

Las opciones al iniciar un contenedor son las siguientes, y el contenedor tomará una decisión en base a alguna de ellas.

- No existe proyecto:  En el caso de que se inicie un contenedor y en la carpeta donde iría el proyecto no detecta que haya uno. El contenedor automaticamente creará un nuevo proyecto para usted, solicitará un nombre en caso que se haya iniciado el modo interactivo y levantará el servicio de aplicación.
- No estan los **node_modules** : En el caso que las dependencias no esten instaladas, cosas que es común porque generalmente no se versionan las mismas. Al levantar el contenedor si la carpeta `node_modules` no aparece en la raiz del proyecto, este la creará y comenzará la descargas de las mismas y posteriormente levantará el servicio de aplicaciónes. *Tener en cuenta que si la carpeta* `node_modules` *existe pero esta vacia el contenedor detectará que ésta ya está y fallará al ejecutar el servidor de aplicaciones. Para evitar esto, elimine completamente la carpeta* `node_modules` *y el contenedor var a reconstruir la carpeta con todos los modulos correspondientes*.
- Esta el proyecto con los **node_modules** : Si el contenedor encuentra un proyecto de `angular` junto con los `node_modules` iniciará automaticamente el servidor de aplicaciones.

Como podemos ver, lo único que debemos hacer es iniciar el contenedor con `docker run` y el se encargará de todo. Debemos tener en claro, considerar una `carpeta` en el host, la cual utilizaremos para trabajar en nuestro proyecto.

La sintaxis para levantar entonces el contenedor y el servidor de aplicaciones seria como sigue:

```bash
# pwd es un comando que devuelve la ruta actual, por lo tanto la ruta actual será la que contendrá el proyecto
docker run -it -v `pwd`:/angl -p 4200:4200 --name angl_container  angl
```



## Conectarse al contenedor

Una vez levantado nuestro contenedor con el servidor de aplicaciones activo, vamos a necesitar conectarnos al contenedor para poder crear **componentes**, **servicios**, **directivas**, etc.La interface de linea de comandos `@angular/cli` solo esta diponible dentro del contenedor por ello debemos conectarnos al mismo. 

La sintaxis para conectarnos al contenedor es la siguiente:

```bash
docker exec -it angl /bin/bash
node@3573a9aa1753:/angl$ 
```

el directorio de trabajo se sitúa automaticamente donde se encuentra el proyecto, desde alli ya tiene acceso al comando `ng` con el que puede crear componentes, etc. Para más información consulte la siguiente referencia [aqui](https://angular.io/cli).

## Usuarios y grupos

Cuando trabajamos con un proyecto, tenemos que crear **componentes**, **directivas**, etc. Sin embargo, como la linea de comandos `@angular/cli` se encuentra dentro del contenedor, cuando estos se crean con el comando `ng generate` el **owner** y el **group** de los archivos generados corresponden al usuario y el grupo primario del contenedor, que por defecto es el usuario **node** y el **uid** es el 0. Cuando quiera acceder a los archivos creados desde el host anfitrión le dirá que no tiene permisos para modificar dichos archivos ya que usted no es el **owner** de dichos archivos y tendrá que utilizar `sudo chown` para cambiarlo.

Sin embargo hacer esto cada vez resulta molesto, para evitar esto puede pasar su usuario dentro del contenedor. Mas precisamente, lo que nos interesa mapear nuestro `uid` y `gid` dentro del contenedor. Docker permite hacer esto con el comando `docker run`, puede encontrar una refencia [acá](https://docs.docker.com/engine/reference/commandline/run/).

Para ello, lo primero es averiguar nuestro `uid` y `gid`.

```bash
# visualizar nuestro id de usuario
echo $(id -u)
1000

# visualizar el id de nuestro grupo primario
echo $(id -g)
1000
```

Ya con nuestro `uid` y `gid` podemos pasarselo al contenedor.

```bash
# La sintaxis del parametro es como sigue --user <uid>:<gid>
docker run -it -v `pwd`:/angl -p 4200:4200 --name angl --user 1000:1000 angl
```

De esa manera, aunque el usuario dentro del contenedor sea el usuario **node**, el `uid`con el que se crearán los archivos será el 1000. Si utiliza `ls -l`para ver los archivos creados desde su host anfitrión podra ver que ahora el `owner` es el suyo.



## Links de interes

En Github puede encontrar un proyecto de **Angular** que además incluye bootstrap v5.1.0 como también un conjunto de componentes pre diseñados que le permitirán construir aplicaciones más rápidamente. Puede acceder desde [aquí](https://github.com/hectorcrispens/anglBtrp).

También puede acceder al siguiente [enlace](https://github.com/sergrida/dockMspa), el cual es un proyecto para docker que integra todo el stack completo con mysql, symfony y angular en el front-end y que se integra perfectamente con esta imagen.

------



## Comandos disposibles de angular/cli

  **add** Adds support for an external library to your project.
  **analytics** Configures the gathering of Angular CLI usage metrics. See https://angular.io/cli/usage-a  		nalytics-gathering.
  **build** (b) Compiles an Angular app into an output directory named dist/ at the given output path. 		Must be executed from within a workspace directory.
  **deploy** Invokes the deploy builder for a specified project or for the default project in the workspace.
  **config** Retrieves or sets Angular configuration values in the angular.json file for the workspace.
  **doc** (d) Opens the official Angular documentation (angular.io) in a browser, and searches for a 		given keyword.
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
