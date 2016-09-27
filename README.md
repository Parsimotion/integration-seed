# integration-seed
Please, replace the string "integration-seed" with the name you want, in all the project.

## Very Important!!! If you don't read then a cat will be killed.

If you update from integration-seed 1.0 then you should migrate users and yours references (User[providerId] -> User[\_id]).

## Login
This integration doesn't login automatically, because it runs in an `iframe` inside the Producteca's client. If you are using it outside the Producteca environment (in development, for example) you should login manually going to `http://localhost:9001/auth/producteca`.

## Setup

```bash
#(instalar mongodb-org)

npm install
bower install
```

Crear `/server/config/local.env.coffee` con:
```coffee
# Use local.env.js for environment variables that grunt will set when the server starts locally.
# Use for your api keys, secrets, etc. This file should not be tracked by git.
#
# You will need to set these on the server you deploy to.
module.exports =
 DOMAIN: "http://localhost:9000"
 SESSION_SECRET: "***"
 VARIABLE: "***"

 # Control debug level for modules using visionmedia/debug
 DEBUG: ""
```

Los valores de estos atributos son secretos, por eso este archivo se encuentra ignorado en el versionado.

## Servidor

```bash
grunt serve
```

## Tests

```bash
grunt test:client
grunt test:server
```
