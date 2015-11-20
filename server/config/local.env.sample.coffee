# Use local.env.js for environment variables that grunt will set when the server starts locally.
# Use for your api keys, secrets, etc. This file should not be tracked by git.
#
# You will need to set these on the server you deploy to.
module.exports =

  DOMAIN: "http://localhost:9001"
  SESSION_SECRET: "a session secret"
  COOKIE_KEY: "a signature"
  WEBJOB_SIGNATURE: "a signature for webjobs"
  PRODUCTECA_CLIENTID: "16"
  PRODUCTECA_CLIENTSECRET: "random localhost integration secret!"

  AUTHORIZATION_SERVER_URL: "http://auth-development.producteca.com"
  PRODUCTECA_API: "http://development-api.producteca.com"
  MONGO_URI: "a connection string to a mongodb database"
