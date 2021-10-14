#!/bin/bash

if [[ -f /angl/package.json ]]
then
    if [[ -d /angl/node_modules ]]
    then
        # Se detecto un proyecto y tambien los node_modules
        echo "ng serve --host 0.0.0.0"
        ng serve --host 0.0.0.0
    else
        # Se detecto un proyecto pero sin los node_modules
        echo "npm install && ng serve --host 0.0.0.0"
        npm install && ng serve --host 0.0.0.0

    fi
else
    # Se crea un proyecto nuevo ya que no se detecto un package.json
    echo "Se esta por crear un nuevo proyecto"
    read -p "Ingrese un nombre [angl]: " name
    name=${name:-angl}

    echo "ng new $name --directory ./"
    echo "npm install && ng serve --host 0.0.0.0"
    
    ng new $name --directory ./
    npm install && ng serve --host 0.0.0.0
fi