# Use local.env.js for environment variables that grunt will set when the server starts locally.
# Use for your api keys, secrets, etc. This file should not be tracked by git.
#
# You will need to set these on the server you deploy to.

DEVELOPMENT = "16"
PRODUCTION = "5"

module.exports =

  BLUEBIRD_W_FORGOTTEN_RETURN: "false"
  DOMAIN: "http://localhost:9001"
  SESSION_SECRET: "a session secret"
  COOKIE_KEY: "a signature"
  WEBJOB_SIGNATURE: "a signature for webjobs"
  PRODUCTECA_CLIENTID: DEVELOPMENT
  PRODUCTECA_CLIENTSECRET: "random localhost integration secret!"

  AUTHORIZATION_SERVER_URL: "http://producteca-oauth-development.azurewebsites.net"
  PRODUCTECA_API: "http://parsimotion-api-development.azurewebsites.net"
  MASTER_TOKEN: "you know the token :)"
  # MONGO_URI: "a connection string to a mongodb database"
