"use strict"

# Use local.env.js for environment variables that grunt will set when the server starts locally.
# Use for your api keys, secrets, etc. This file should not be tracked by git.
#
# You will need to set these on the server you deploy to.
module.exports =

  DOMAIN: "http://localhost:9001"
  AUTHORIZATION_SERVER_URL: "http://auth.producteca.com"
  PRODUCTECA_API: "http://api.producteca.com"

  SESSION_SECRET: "a session secret"
  COOKIE_KEY: "a signature"
  MONGO_URI: "a connection string to a mongodb database"
  WEBJOB_SIGNATURE: "a signature for webjobs"
  PRODUCTECA_CLIENTID: "5"
  PRODUCTECA_CLIENTSECRET: "6e5800d3-4766-4601-a7f0-034d70382b7c"

  # Control debug level for modules using visionmedia/debug
  DEBUG: ""
